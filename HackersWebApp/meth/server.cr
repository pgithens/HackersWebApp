# require "http/server"
require "kemal"



get "/movies/api/:id" do |env|
    env.response.content_type = "application/json"
    puts env.response.headers["Content-Type"]
    {"movie": {"title": "National Treasure"}}.to_json
end

Kemal.run
