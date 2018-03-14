class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize (id:nil,breed:,name:)
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = "CREATE TABLE dogs"
  end

  def self.drop_table
    sql = "DROP TABLE dogs"
    DB[:conn].execute(sql)
  end


end
