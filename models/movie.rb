require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @id          = options['id'].to_i()
    @title       = options["title"]
    @genre       = options["genre"]
  end

  def self.delete_all
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre
      )
      VALUES
      (
        $1,
        $2
        )
        RETURNING id"

        values = [@title, @genre]

        result = SqlRunner.run(sql, values)

        @id = result[0]['id'].to_i()
  end

  def self.all
    sql = "SELECT * FROM movies"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Movie.new(order_hash)
      end
  end

  def update()
      sql = "
        UPDATE movies
        SET title = $1, genre = $2
        WHERE id = $3;
      "
      values = [
        @title,
        @genre,
        @id
      ]

      SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def all_actors()
    sql = " SELECT * FROM actors
      INNER JOIN roles
      ON actors.id = roles.actor_id
      WHERE movie_id = $1;"

    actor_hash =   SqlRunner.run(sql, [@id])
    actor = actor_hash.map do |order_hash|
      Actor.new(order_hash)
    end
    return actor
  end
end
