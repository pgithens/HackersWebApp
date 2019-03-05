
require "kemal"

module Meth

  def initialize
    @http_client = HTTP::Client.new(Host, ssl: true)
  end

  def getMovie(movieTitle : String)
    response = @http_client.get("/movies/api/#{movieTitle}")
  end

  get "/" do
    render "src/views/home.ecr", "src/views/layouts/layout.ecr"
  end

  Kemal.run
end
