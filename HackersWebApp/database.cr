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
value = JSON.parse(data.to_json)
puts value["users"]["u"]
