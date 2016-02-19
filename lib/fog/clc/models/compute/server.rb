require 'fog/core/model'
require 'fog/compute/models/server'
require 'fog/clc/core'

module Fog
  module Compute
    class CLC

      class Server < Fog::Compute::Server
        include Fog::CLC::Common

        identity  :id

        attribute :name
        attribute :description
        attribute :password
        attribute :status
        attribute :os
        attribute :group_id,         :aliases => "groupId"
        attribute :os_type,          :aliases => "osType"
        attribute :server_type,      :aliases => "type", :default => "standard"
        attribute :storage_type,     :aliases => "storageType", :default => "standard"
        attribute :power_state,      :aliases => "powerState", :default => "on"
        attribute :cpu,              :type => :integer, :default => 1
        attribute :mem,              :type => :integer, :aliases => "memoryMB"
        attribute :disk,             :type => :integer, :aliases => "storageGB"
        attribute :disks,            :type => :array, :aliases => "disks"
        attribute :created_at,       :type => :time, :aliases => 'createdDate'
        attribute :modified_at,      :type => :time, :aliases => 'modifiedDate'
        attribute :details

        def initialize(attrs)
          cache_attrs!(attrs)
          super(attrs)
        end

        def create
          requires :name, :group_id, :server_type, :cpu, :mem
          block_status do
            resp = service.create_server(attrs_to_hash)
            unless self.id = links(resp)['self']
              raise Fog::CLC::Errors::ServiceError, "expected server id under links[rel=self]"
            end
            resp
          end
          read
        end

        def read
          requires :id
          attrs = service.get_server(check_uuid(id))
          cache_attrs!(attrs)
          merge_attributes(attrs)
          self
        end

        def update
          requires :id
          patches = gen_patches
          unless patches.empty?
            block_status do
              # detect changes and prepare set of patch ops
              service.update_server(check_uuid(id), patches)
            end
            read
          end
        end

        def destroy
          requires :id
          block_status do
            service.delete_server(check_uuid(id))
          end
        end

        def save
          if identity
            update
          else
            create
          end
        end

        def wait_until_ready
          loop do
            break if self.status == 'active'
            sleep(Fog::CLC::POLL_INTERVAL)
            read
          end
          self
        end


=begin
        def power_state=(val)
          return if power_state == val
        end
=end
        def private_ip_addresses
          details["ipAddresses"].map {|h| h["internal"] }
        end

        def public_ip_addresses
          details["ipAddresses"].map {|h| h["public"] }
        end

        def private_ip_address
          private_ip_addresses.first
        end

        def public_ip_address
          public_ip_addresses.first
        end

        def ssh_ip_address
          public_ip_address or private_ip_address
        end



        protected

        def cache_attrs!(attrs)
          if d = attrs["details"]
            # un-nest the good stuff, but retain the important stuff
            f = %w( id type name description groupId os osType locationId storageType )
            f.each {|k| d[k] = attrs[k] }
            attrs.merge!(d)
          end
        end

        def gen_patches
          # prepares patch objects - eg: {op:set, member:<field>, value:<val>}
          # only supports certain fields
          patches = []
          methods = %w(mem group_id cpu description disks password)
          specials = { 'mem' => 'memory', 'group_id' => 'groupId' }
          prev = self.class.new(details)
          methods.each do |m|
            s = m.to_sym
            if self.send(s) != prev.send(s)
              patches << {
                :op => :set,
                :member => specials[m] || m,
                :value => self.send(s)
                }
            end
          end
          patches
        end

        def attrs_to_hash
          data = {
            :name => self.name,
            :description => self.description,
            :type => self.server_type,
            :password => self.password,
            :groupId => self.group_id,
            :sourceServerId => map_os_names(self.os),
            :powerState => self.power_state,
            :cpu => self.cpu,
            :memoryGB => (self.mem / 1024.0).floor,
            :storageGB => self.disk,
            :strorageType => self.storage_type,
          }

          if self.server_type == 'bareMetal'
            # FIXME: handle bareMetal fields: add/subtract
          end
          data
        end

        def map_os_names(name)
          case name
          # ubuntu
          when /ubuntu12/
            "UBUNTU-12-64-TEMPLATE"
          when /ubuntu14/, /ubuntu$/
            "UBUNTU-14-64-TEMPLATE"
          # debian
          when /debian6/
            "DEBIAN-6-64-TEMPLATE"
          when /debian7/, /debian$/
            "DEBIAN-7-64-TEMPLATE"
          # centos
          when /centos5/
            "CENTOS-5-64-TEMPLATE"
          when /centos6/
            "CENTOS-6-64-TEMPLATE"
          when /centos7/, /centos$/
            "CENTOS-7-64-TEMPLATE"
          # redhat
          when /rhel5/, /redhat5/
            "RHEL-7-64-TEMPLATE"
          when /rhel6/, /redhat6/
            "RHEL-7-64-TEMPLATE"
          when /rhel7/, /redhat/, /rhel$/
            "RHEL-7-64-TEMPLATE"
          # windows
          when /win2008r2dtc/
            "WIN2008R2DTC-64"
          when /win2008r2ent/
            "WIN2008R2ENT-64"
          when /win2008r2std/
            "WIN2008R2STD-64"
          when /win2012dtc/
            "WIN2012DTC-64"
          when /win2012r2dtc/
            "WIN2012R2DTC-64"
          else
            name
          end
        end


      end
    end
  end
end
