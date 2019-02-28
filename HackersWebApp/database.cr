require "json"

#database = JSON.build do |json|#
#  json.object do
#    json.field "name", "foo"
#    json.field "values" do
#      json.array do
#        json.number 1
#        json.number 2
#        json.number 3
#      end
#    end
#  end
#end
class Comment
  include JSON::Serializable
  property user : String
  property com : String

class FILM
  include JSON::Serializable
  property name : String
  property rev : Int32
  property revs : Int32
  property comments : Array(Comment?)

class Movies
  include JSON::Serializable
  JSON.mapping({fm: Array(FILM?)})

class User
  include JSON::Serializable

  property name : String
  property mv : Movies?

  @[JSON::Field(key: "uid")]
  property userID : Int32
end

class database
  include JSON::Serializable
  property user : User?
  property mv : Movies?
end

data = database.from_json(%<{"user": {"name": "paul", "userID": 1, "mv": {[{"name": "The Avengers", "rev": 9, "revs": 1, "comments":["usr": "paul", "com": "GREAT"]}]}}, "mv": {"a":1, "b": "2"}}>)
