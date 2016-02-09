class User

  # this line creates getter and setter methods for our instance variables
  attr_accessor :name, :email

  # this is the initialization method that gets called when you call .new() in Ruby
  # it has an empty hash as a default attribute, meaning the argument is optional:
  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
