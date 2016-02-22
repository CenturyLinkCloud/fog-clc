# fog-clc

fog.io plugin for CLC platform - provides compute resources for use within fog projects. 


# Usage

add the gem to your Gemfile

```
gem "fog-clc", :git => "https://github.com/CenturyLinkCloud/eco-fog-clc"
```

require into your project and instantiate

```
require 'fog/clc'
creds = {
  clc_username:<u>,
  clc_password:<p>,
  clc_alias:<alias>,
}
clc = Fog::Compute::CLC.new(creds)

```

```
# load a server
server = clc.servers.get("CA1ACCSVR")
<Fog::Compute::CLC::Server
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
  group_id: "415c02ad8b67e31191230050569f1368",
  os: "ubuntu",
  cpu: 2,
  mem: 2048,
  disk: 10,
)
resp = server.save


# add a public ip to it
ports = [Fog::Compute::CLC::PublicIP::Port.new(22)]
server.add_public_ip(server.private_ip_addresses.first, ports)

```



# TODO
- groups
- load balancer
- queue
- firewall?
- server-template?
