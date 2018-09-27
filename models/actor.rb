require_relative('../db/sql_runner')

class Actor

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id          = options['id'].to_i() if options['id']
    @name        = options["name"]
  end

  def self.delete_all
    sql = "DELETE FROM actors"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO actors
    (
      name
      )
      VALUES
      ($1)
      RETURNING id;
      "
      values = [@name]

      result = SqlRunner.run(sql, values)

      @id = result[0]['id'].to_i()
  end

  def self.all
    sql = "SELECT * FROM actors"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Actor.new(order_hash)
      end
  end

  def update()
      sql = "
        UPDATE actors
        SET name = $1
        WHERE id = $2;
      "
      values = [
        @name,
        @id
      ]

      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM actors WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def all_movies()
    sql = " SELECT * FROM movies
      INNER JOIN roles
      ON movies.id = roles.movie_id
      WHERE actor_id = $1;"

    movie_hash =   SqlRunner.run(sql, [@id])
    movie = movie_hash.map do |order_hash|
      Movie.new(order_hash)
    end
    return movie
  end

end
