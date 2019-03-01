require "http/server"
require "./database"

server = HTTP::Server.new do |context|
  context.response.content_type = "text/plain"
  context.response.print "Hello world! The time is #{Time.now}"
  #db =  database.data
  data = Comment.from_json(%({"user": "Jin", "com": "dissapointed"}))
  value = JSON.parse(data.to_json)
  context.response.print value
end

address = server.bind_tcp 8080
puts "Listening on http://#{address}"
server.listen
