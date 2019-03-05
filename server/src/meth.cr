
require "kemal"

module Meth

  def initialize
    @http_client = HTTP::Client.new(Host, ssl: true)
  end

  def getMovie(movieTitle : String)
    response = @http_client.get("/movies/api/#{movieTitle}")

  get "/" do
    render "src/views/home.ecr", "src/views/layouts/layout.ecr"
  end

  Kemal.config.port = 8000
  Kemal.run
end
