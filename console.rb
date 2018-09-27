require('pg')
require_relative('./models/actor')
require_relative('./models/movie')
require_relative('./models/role')

#C
#R
#U
#D

actor1 = Actor.new({
  "name" => "Brad Pit"
  })

actor2 = Actor.new({
  "name" => "Christoph Waltz"
  })

actor1.save()
actor2.save()

movie1 = Movie.new({
  "title" => "Inglorious Bastards",
  "genre" => "Comedy"
  })

movie2 = Movie.new({
  "title" => "Catch Me If You Can",
  "genre" => "Horror"
  })

movie1.save()
movie2.save()

role1 = Role.new({
  "actor_id" => actor1.id,
  "movie_id" => movie1.id,
  "fee"      => 200000
  })

role2 = Role.new({
  "actor_id" => actor2.id,
  "movie_id" => movie2.id,
  "fee"      => 150000
  })

role1.save()
role2.save()

actor1.all_movies()
movie1.all_actors()

# # Actor.all
# # Movie.all
# # Role.all
# # actor1.update()
# # movie1.update()
# # role1.update()
# #
# # actor1.delete
# # movie1.delete()
# # role1.delete()
#
# Actor.delete_all
# # Movie.delete_all
# # Role.delete_all
