require('pg')
require_relative('../models/actor')
require_relative('../models/movie')
require_relative('../models/role')

class SqlRunner

  def self.run(sql, values = [])
    db = PG.connect({ # connects to db
      dbname: 'imdb', #db name
      host: 'localhost' #db location
    })
    db.prepare('query', sql)

    results = db.exec_prepared('query', values)

    db.close()
    return results
  end

end
