-- This information is used by the Wi-Fi dongle to make a wireless connection to the router in the Lab
-- or if you are using another router e.g. at home, change ID and Password appropriately
SSID = "ShawOpen"
SSID_PASSWORD = ""

-- configure ESP as a station
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)

-- alternatively you could do it this way
-- wifi.sta.config("M112-PD","aiv4aith2Zie4Aeg", 1)
-- wifi.sta.connect()

-- pause for connection to take place - adjust time delay if necessary or repeat until connection made
tmr.delay(10000000) -- wait 1,000,000 us = 1 second

ip = wifi.sta.getip()

if(ip==nil) then
  print("Connecting Error")
else
  tmr.stop(0)
  print("Connected to AP!")
  print(ip)
end

HOST = "localhost"

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
     return request
end

function display(sck,response)
     print(response)
end

function post_location(location_id, latitude, longitude)

  uri = "/nearby"

  location = {
    user_id = user_id,
    latitude = latitude,
    longitude = longitude
  }

  socket = net.createConnection(net.TCP,0)
  socket:on("receive", display)
  socket:connect(3000, "137.82.61.1")

  socket:on("connection", function(sck)
    post_request = build_post_request(HOST, uri, location)
    socket:send(post_request)
  end)
end

function post_review(user_id, user_name, building_id, review)

  uri = "/review"

  review = {
    user_id = user_id,
    user_name = user_name
    building_id = building_id
    review = review
  }

  socket = net.createConnection(net.TCP, 0)
  socket:on("receive", display)
  socket:connect(3000, "137.82.61.1")

  socket:on("connection", function(sck)
    post_request = build_post_request(HOST, uri, review)
    socket:send(post_request)
  end)
end

function get_reviews(building_id)

  socket = net.createConnection(net.TCP, 0)
  socket:on("receive", function(sck, c) print(c) end )
  socket:connect(3000,"137.82.61.1")
  socket:send("GET /reviews/"..building_id.." HTTP/1.1\r\nHost: localhost\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

function get_hot_locations()

  socket = net.createConnection(net.TCP, 0)
  socket:on("receive", function(sck, c) print(c) end )
  socket:connect(3000,"137.82.61.1")
  socket:send("GET /hot HTTP/1.1\r\nHost: localhost\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

function send_get_request()
  socket = net.createConnection(net.TCP, 0)
  socket:on("receive", function(sck, c) print(c) end )
  socket:connect(80,"137.82.61.1")
  socket:send("GET /~l6w8/testlocationdata.txt HTTP/1.1\r\nHost: ece.ubc.ca\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

function get_file(filename)
  sk = net.createConnection(net.TCP, 0)
  sk:on("receive", function(sck, c) print(c) end )
  sk:connect(80,"137.82.61.1")
  sk:send("GET /~l6w8/"..filename.." HTTP/1.1\r\nHost: ece.ubc.ca\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end
