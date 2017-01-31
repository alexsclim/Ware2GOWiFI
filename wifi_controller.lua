-- This information is used by the Wi-Fi dongle to make a wireless connection to the router in the Lab
-- or if you are using another router e.g. at home, change ID and Password appropriately
SSID = "Turtle"
SSID_PASSWORD = "turtleman"

-- configure ESP as a station
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)

-- alternatively you could do it this way
-- wifi.sta.config("M112-PD","aiv4aith2Zie4Aeg", 1)
-- wifi.sta.connect()

-- pause for connection to take place - adjust time delay if necessary or repeat until connection made
tmr.delay(1000000) -- wait 1,000,000 us = 1 second

ip = wifi.sta.getip()

if(ip==nil) then
  print("Connecting...")
else
  tmr.stop(0)
  print("Connected to AP!")
  print(ip)
end

HOST = "localhost"
URI = "/locations/nearby"

function build_post_request(host, uri, data_table)

     data = ""

     for param,value in pairs(data_table) do
          data = data .. param.."="..value.."&"
     end

     request = "POST "..uri.." HTTP/1.1\r\n"..
     "Host: "..host.."\r\n"..
     "Connection: close\r\n"..
     "Content-Type: application/x-www-form-urlencoded\r\n"..
     "Content-Length: "..string.len(data).."\r\n"..
     "\r\n"..
     data
     print(request)
     return request
end

function display(sck,response)
     print(response)
end

function send_post_request(payload)

  socket = net.createConnection(net.TCP,0)
  socket:on("receive",display)
  socket:connect(3000, "192.168.43.72")

  socket:on("connection",function(sck)
    post_request = build_post_request(HOST,URI,payload)
    sck:send(post_request)
  end)
end
