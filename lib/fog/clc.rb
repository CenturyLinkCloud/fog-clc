require 'fog/core/services_mixin'
require 'fog/compute'
require 'fog/core'
require 'fog/core/connection'
require 'fog/clc/version'

module Fog
  module CLC
    extend Fog::Provider

    API_BASE = "https://api.ctl.io"

    # val:false - all queued responses are polled until completion
    # val:true - explicitly manage async calls
    POLL_ASYNC = true
    POLL_INTERVAL = 5

    service(:compute, 'clc/compute')

  end
end
