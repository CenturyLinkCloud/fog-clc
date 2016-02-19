require 'fog/json'
require 'fog/core'
require 'fog/clc/common'

module Fog
  module CLC
    extend Fog::Provider
    service(:compute, "Compute")

    # val:false - all queued responses are polled until completion
    # val:true - explicitly manage async calls
    POLL_ASYNC = false
    POLL_INTERVAL = 5

  end
end
