require_relative('../db/sql_runner')

class Role

  attr_accessor :fee
  attr_reader :role_id, :actor_id, :movies_id

  def initialize(options)
    @id             = options['id'].to_i()
    @actor_id       = options["actor_id"]
    @movie_id       = options["movie_id"]
    @fee            = options["fee"]
  end

  def self.delete_all
    sql = "DELETE FROM roles"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO roles
    (
      actor_id,
      movie_id,
      fee
      )
      VALUES
      (
        $1,
        $2,
        $3
        )
        RETURNING id"

        values = [@actor_id, @movie_id, @fee]
        result = SqlRunner.run(sql, values)

        @id = result[0]['id'].to_i()
  end

  def self.all
    sql = "SELECT * FROM roles"

    order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Role.new(order_hash)
      end
  end

  def update()
    sql = "
      UPDATE roles
      SET
        actor_id = $1,
        movie_id = $2,
        fee = $3
        WHERE id = $4;
        "
      values = [
        @actor_id,
        @movie_id,
        @fee,
        @id
        ]

        SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM roles WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
