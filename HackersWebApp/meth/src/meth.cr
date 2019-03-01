
require "kemal"

module Meth

  get "/" do
    render "src/views/home.ecr", "src/views/layouts/layout.ecr"
  end

  Kemal.config.port = 8000
  Kemal.run
end
