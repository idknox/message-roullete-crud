require "gschool_database_connection"

class Table_connection

  def initialize
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  def get_all
    @database_connection.sql(
      "SELECT * FROM messages"
    )
  end

  def get_msg(id)
    @database_connection.sql(
      "SELECT * FROM messages WHERE id=#{id}"
    )[0]
  end

  def add_msg(message)
    @database_connection.sql("INSERT INTO messages (message) VALUES ('#{message}')")
  end

  def update_msg(msg, id)
    @database_connection.sql(
      "UPDATE messages set message='#{msg}' WHERE id=#{id}"
    )
  end

  def del_msg(id)
    @database_connection.sql(
      "DELETE FROM messages WHERE id=#{id}"
    )
  end

  def insert_comment(comment, id)
    @database_connection.sql(
      "INSERT INTO messages (comment) VALUES " +
      "('#{comment}') WHERE id=#{id}"
    )
  end
end
