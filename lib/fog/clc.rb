require 'fog/core/services_mixin'
require 'fog/compute'
require 'fog/core'
require 'fog/core/connection'

module Fog
  module CLC
    extend Fog::Provider

    VERSION = "0.1"

    API_BASE = "https://api.ctl.io"

    POLL_INTERVAL = 5

    # false: all queued responses are polled until completion
    # true:  explicitly manage async calls
    POLL_ASYNC = false

    # server & group power states
    POWER_STATES = %w(
      powerOn powerOff pause reboot reset shutDown
      setMaintenance startMaintenance stopMaintenance
    ).freeze

    # available datacenters/locations
    DC = %W(
      CA1 CA2 CA3 DE1 GB1 GB3 IL1 NY1 SG1 UC1 UT1 VA1 WA1
    ).freeze

    service(:compute, 'clc/compute')

  end
end
