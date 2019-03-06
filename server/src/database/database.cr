require "db"
require "mysql"
require "json"
require "csv"


require "../config"

def safeConvertStringToInt64(x)
  if x.size > 0
    x.to_i64
  else
    0
  end
end

def safeConvertStringToFloat(x)
  if x.size > 0
    x.to_f
  else
    0
  end
end

# read in local file
movies = File.read("src/data/tmdb_5000_movies.csv")
csv = CSV.parse(movies)

DB.open DATABASE_STRING do |db|
    db.exec "drop table if exists movies"
    db.exec "create table movies (title varchar(30), overview varchar(300), budget bigint, revenue bigint, runtime float, tagline varchar(50))"

    csv.each do |x|
      db.exec "insert into movies values (?, ?, ?, ?, ?, ?)", x[17].downcase, x[7], safeConvertStringToInt64(x[0]), safeConvertStringToInt64(x[12]), safeConvertStringToFloat(x[13]), x[16]
      puts x[17]
    end
end

# DB.open DATABASE_STRING do |db|
#   db.query "select title, overview, budget from movies where title='Avatar'" do |rs|
#     rs.each do
#       puts rs.read(String)
#       puts rs.read(String)
#     end
#   end
# end
