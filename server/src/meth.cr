# require "http/server"
require "kemal"
require "json"
require "db"
require "mysql"



# class Comment
#   include JSON::Serializable
#   property user : String
#   property com : String
# end
#
# class COMMENTS
#   JSON.mapping({cm: Array(Comment?)})
# end
#
# class FILM
#   include JSON::Serializable
#   property name : String
#   property rev : Int32
#   property revs : Int32
#   property comments : COMMENTS?
# end
#
# class Movies
#   JSON.mapping({fm: Array(FILM?)})
# end
#
# class User
#   include JSON::Serializable
#
#   property name : String
#   property mv : Movies?
#   property uid : Int32
# end
#
# class Users
#   JSON.mapping({u: Array(User?)})
# end
#
# class DATA
#   include JSON::Serializable
#   property users : Users?
#   property mv : Movies?
# end
#
# ## End Class Designation ##
#
# data = DATA.from_json(%({
#    "users": {
#        "u": [{
#             "name": "paul",
#             "uid": 1,
#             "mv": {
#             "fm": [{
#                    "name": "The Avengers",
#                    "rev": 9,
#                    "revs": 1,
#                    "comments": {
#                            "cm": [{
#                                "user": "paul",
#                                "com": "GREAT"
#                             }]
#                     }
#
#              }]
#              }
#          }]
#      },
#       "mv": {
#           "fm": [{
#                "name": "The Avengers",
#                "rev": 9,
#                "revs": 1,
#                "comments": {
#                "cm": [{
#                   "user": "paul",
#                   "com": "GREAT"
#                   }, {
#                   "user": "marcus",
#                   "com": "Too Much"
#                }]
#                }
#
#            }]
#       }
#       }))
#
#   ## READ IN DATA END ##
#
#   value = JSON.parse(data.to_json)
#
# u = JSON.parse("{\"user\": \"Jin\", \"com\": \"dissapointed\"}")



get "/" do |env|
  # env.response.headers["Access-Control-Allow-Origin"] = "*"
  # env.response.content_type = "application/json"
  # u.to_json
  "Nothing here! Go to the 'movies/search/:title' endpoint!"
end

get "/movies/search/:title" do |env|
  #"/movies/api/:id"
    env.response.headers["Access-Control-Allow-Origin"] = "*"
    env.response.content_type = "application/json"
    #puts env.response.headers["Content-Type"]
    #{"movie": {"title": "National Treasure"}}.to_json
    # id = env.params.url["id"]
    #value["mv"]["fm"][0]["comments"][id].to_json    # the get request for a string in the json
    # value["mv"]["fm"][0]["comments"]["cm"][id.to_i].to_json
    title = env.params.url["title"]
    JSON.parse("{\"user\": \"Jin\", \"com\": \"dissapointed\"}").to_json
end
#
# get "/movie/comments/" do |env|
#   env.response.content_type = "application/json"
#   value["mv"]["fm"][0]["comments"]["cm"].to_json
# end
#
# put "/" do |env|
#   #user = User.from_json env.request.body.not_nil!
#   #{username: user.username, password: user.password}.to_json
#   value["mv"]["fm"][0]["comments"]["cm"].as_a.push(u)
#   value["mv"]["fm"][0]["comments"]["cm"].to_json
# end

Kemal.config.port = 8080
Kemal.run
