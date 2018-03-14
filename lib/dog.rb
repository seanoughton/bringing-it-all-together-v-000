class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize (id:nil,breed:,name:)
    @name = name
    @breed = breed
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        breed TEXT
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE dogs"
    DB[:conn].execute(sql)
  end


  def new_from_db
    #get the rows from the database
    #instantiate a new instance for each row, passing in the appropriate params
    sql = <<-SQL
      SELECT * FROM dogs
    SQL

    rows = DB[:conn].execute(sql)
    rows.each do |row|
      id: row[0]
      name: row[1]
      breed: row[2]
      Dog.new(:id,:name, :breed)
    end
  end

  def save
  end


end
