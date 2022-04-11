require 'pg'

class DatabaseConnection
  def self.setup(db_name)
    @connection = PG.connect(dbname: db_name)
  end

  class << self
    attr_reader :connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end
end