class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize (id:nil,breed:,name:)
    @name = name
    @breed = breed
  end

  def self.create_table
  end

  def self.drop_table
  end


end
