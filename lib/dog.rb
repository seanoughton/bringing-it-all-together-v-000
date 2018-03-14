class Dog

  attr_accessor :name, :breed
  attr_reader :id

  def initialize (arguments)
    attributes.each {|key,value| self.send(("#{key}="),value)}
  end
end
