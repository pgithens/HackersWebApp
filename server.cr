# require "http/server"
require "kemal"
require "option_parser"



get "/movies/api/:id" do |env|
    env.response.content_type = "application/json"
    puts env.response.headers["Content-Type"]
    {"movie": {"title": "National Treasure"}}.to_json
end

server_port = 8080
OptionParser.parse! do |opts|
  opts.on("-p PORT", "--port PORT", "define port to run server") do |port|
    server_port = port.to_i
  end
end

Kemal.config.port = server_port
Kemal.run
