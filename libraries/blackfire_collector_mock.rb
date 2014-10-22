require 'socket'
require 'uri'

module Blackfire
  class CollectorMock
    @response = <<EOS
{
  "publicKey":"RWTZMyTkp\/ZMEwdZQRRpANepfi5+3i9Kex2f89EYv7o9KHaIPC\/THc19",
  "signature":"RWTZMyTkp\/ZME54jWsRriZrRqXgdoVKLT47AFsuf+gywfgjldfkcnx",
  "expires":"20480101"
}
EOS
    @headers = "HTTP/1.1 200 OK\r\n" \
"Content-Type: application/json\r\n" \
"Content-Length: #{@response.bytesize}\r\n" \
"Connection: close\r\n" \
"\r\n"

    def self.run(endpoint = nil)
      uri = URI.parse(endpoint)
      server = TCPServer.new(uri.host, uri.port)

      Thread.new { listen(server) }
    end

    def self.listen(server)
      loop do
        socket = server.accept
        socket.gets
        socket.print @headers
        socket.print @response
        socket.close
      end
    end
  end
end
