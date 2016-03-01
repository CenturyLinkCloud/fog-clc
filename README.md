# fog-clc

[fog.io](http://fog.io) plugin for CLC platform - provides compute resources for use within fog projects. 


# Usage

add the gem to your Gemfile

```ruby
gem "fog-clc", :git => "https://github.com/CenturyLinkCloud/eco-fog-clc"
```

require into your project and instantiate

```ruby
require 'fog/clc'
creds = {
  clc_username:<u>,
  clc_password:<p>,
  clc_alias:<alias>,
}
clc = Fog::Compute::CLC.new(creds)

```

```ruby
# load a server
server = clc.servers.get("CA1ACCSVR")
=> <Fog::Compute::CLC::Server
    id="ca1accsvr",
    name="CA1ACCSVR",
    description="",
    password=nil,
    status="active",
    os="ubuntu14_64Bit",
    group_id="415c02ad8b67e31191230050569f1368",
    os_type="Ubuntu 14 64-bit",
    server_type="standard",
    storage_type="premium",
    power_state="started",
    cpu=2,
    mem=2048,
    disk=17,
    disks=[{"id"=>"0:0", "sizeGB"=>1, "partitionPaths"=>[]}, {"id"=>"0:1", "sizeGB"=>2, "partitionPaths"=>[]}, {"id"=>"0:2", "sizeGB"=>14, "partitionPaths"=>[]}],
    created_at=nil,
    modified_at=nil,
    ...
    >

# create a server
server = clc.servers.new(
  name: "test",
  group_id: gid,
  os: "ubuntu",
  cpu: 2,
  mem: 2048,
  disk: 10,
)
server.save


# find a group
top = clc.groups.in_dc("VA1").first
hardware = top.first
groups = hardware.groups
groups.select {|g| g.name == 'Default Group' }
=> [  <Fog::Compute::CLC::Group
    id="cd256843f4f2e3119bcd0050569f1367",
    name="Default Group",
    description="The default location for new servers created in your account.",
    type="default",
    status="active",
    parent_group_id="cc256843f4f2e3119bcd0050569f1367",
    groups=[],
    customFields=[],
    links=[...],
    servers_count=0,
    location_id="VA1"
  >]


# create a group
parent = groups.first
group = clc.groups.new(:name => "Foggy", :description => "a foggy day in londontown", :parent_group_id => parent.id)
group.save
=>   <Fog::Compute::CLC::Group
    id="698103f72f5c493b93fee2a17171171a",
    name="Foggy",
    description="a foggy day in londontown",
    type="default",
    status="active",
    parent_group_id="87aab28f129345f5a01013ea343140da",
    groups=[],
    customFields=[],
    links=[...],
    servers_count=nil,
    location_id="VA1"
  >


# add a public ip to it
ports = [Fog::Compute::CLC::PublicIP::Port.new(22)]
server.add_public_ip(server.private_ip_addresses.first, ports)

```


# TODO
- groups
- firewall?
- server-template?
- archive/restore servers
- exec package

# License
Distributed under the [Apache 2.0 license](LICENSE.md) 

