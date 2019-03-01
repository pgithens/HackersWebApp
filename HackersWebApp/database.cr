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
end

class COMMENTS
  JSON.mapping({cm: Array(Comment?)})
end

class FILM
  include JSON::Serializable
  property name : String
  property rev : Int32
  property revs : Int32
  property comments : COMMENTS?
end

class Movies
  JSON.mapping({fm: Array(FILM?)})
end

class User
  include JSON::Serializable

  property name : String
  property mv : Movies?
  property uid : Int32
end

class Users
  JSON.mapping({u: Array(User?)})
end

class DATA
  include JSON::Serializable
  property users : Users?
  property mv : Movies?
end


data = DATA.from_json(%({
	"users": {
		"u": [{
			"name": "paul",
			"uid": 1,
			"mv": {
				"fm": [{
					"name": "The Avengers",
					"rev": 9,
					"revs": 1,
					"comments": {
						"cm": [{
							"user": "paul",
							"com": "GREAT"
						}]
					}

				}]
			}
		}]
	},
	"mv": {
		"fm": [{
			"name": "The Avengers",
			"rev": 9,
			"revs": 1,
			"comments": {
				"cm": [{
					"user": "paul",
					"com": "GREAT"
				}, {
					"user": "marcus",
					"com": "Too Much"
				}]
			}

		}]
	}
}))


#puts data["users"]
#puts data
value = JSON.parse(data.to_json)
#u = JSON.parse("{"user": "Jin", "com": "dissapointed"}")
#u = JSON.build do |json|
#  json.object do
#    json.field "user", "Jin"
#    json.field "com", "dissapointed"
#  end
#end
#u = Comment.from_json(%({
#	"user": "Jin",
#	"com": "dissapointed"
#}))
u = JSON.parse("{\"user\": \"Jin\", \"com\": \"dissapointed\"}")
puts u
#value = value["mv"]["fm"]["comments"]
#value["mv"]["fm"][0]["comments"].json_array do |array|
#         array << u
#end
puts value["mv"]["fm"][0]["comments"]["cm"].as_a.push(u)
#puts value["mv"]["fm"]["comments"]
#value["mv"]["fm"]["comments"].push({"user": "Jin", "com": "dissapointed"})
#puts value["mv"]["fm"]["comments"]
