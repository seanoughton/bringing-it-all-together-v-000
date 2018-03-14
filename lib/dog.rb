class Dog

  attr_accessor :name, :breed, :id

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

=begin
  def new_from_db
    #get the rows from the database
    #instantiate a new instance for each row, passing in the appropriate params
    sql = <<-SQL
      SELECT * FROM dogs
    SQL

    rows = DB[:conn].execute(sql)
    rows.each do |row|
      Dog.new()
    end
  end
=end

  def save
    #check to see if the id EXISTS
    #add the instance to the database
    if self.id
      puts "already has id"
    else
      sql = <<-SQL
        INSERT INTO dogs (name,breed) VALUES (?,?)
      SQL
      DB[:conn].execute(sql,self.name,self.breed)
      sql = "SELECT last_insert_rowid() FROM dogs"
      DB[:conn].execute(sql).flatten.first
      self.id = DB[:conn].execute(sql).flatten.first
      self
    end

  end

  def self.create(name:,breed:)
    new_dog = self.new(name:name, breed:breed)
    new_dog.save
  end

  def self.new_from_db(row)
    dog = self.new(id:row[0],name:row[1],breed:row[2])
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE id = ?
      LIMIT 1
    SQL
    row = DB[:conn].execute(sql,id)
    new_dog = self.new_from_db(row.flatten)
  end

  def self.find_or_create_by(name:,breed:)
    sql = <<-SQL
      SELECT *
      FROM dogs
      WHERE name = ? AND breed = ?
      LIMIT 1
    SQL
    row = DB[:conn].execute(sql,name,breed)
    if row.empty? #if there is row for that dog in the db
      self.find_by_id(row[0][0])
    else
      self.create(name:name, breed:breed)
    end


  end


end
