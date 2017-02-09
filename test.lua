-- This information is used by the Wi-Fi dongle to make a wireless connection to the router in the Lab
-- or if you are using another router e.g. at home, change ID and Password appropriately
-- SSID = "bh7"
-- SSID_PASSWORD = "88888888"

-- -- configure ESP as a station
-- wifi.setmode(wifi.STATION)
-- wifi.sta.config(SSID,SSID_PASSWORD)
-- wifi.sta.autoconnect(1)

-- alternatively you could do it this way
-- wifi.sta.config("M112-PD","aiv4aith2Zie4Aeg", 1)
-- wifi.sta.connect()

-- pause for connection to take place - adjust time delay if necessary or repeat until connection made
tmr.delay(1000000) -- wait 1,000,000 us = 1 second

function test_data()
  -- ip = wifi.sta.getip()

  -- if(ip==nil) then
  --   print("Connecting...")
  -- else
  --   tmr.stop(0)
  --   print("Connected to AP!")
  --   print(ip)
  -- end

  string = "{ name: 'MacLeod Buliding' }"
  print(string)
end
