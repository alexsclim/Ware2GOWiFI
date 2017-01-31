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

function send_post_request()

  location = {
    name = "MacLeod Building",
    latitude = "49.2617596",
    longitude = "-123.2493528"
  }

  socket = net.createConnection(net.TCP,0)
   socket:on("receive",display)
   socket:connect(3000, "172.20.10.11")

   socket:on("connection",function(sck)
        post_request = build_post_request(HOST,URI,location)
        sck:send(post_request)
   end)
end
