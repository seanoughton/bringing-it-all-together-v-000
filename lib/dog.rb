class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize (name,breed)
    #attributes.each {|key,value| self.send(("#{key}="),value)}
    @name = attributes["name"]
    @breed = breed
  end
end
