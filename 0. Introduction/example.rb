# A simple Ruby program that uses OO Basics:
# - Abstraction
# - Encapsulation
# - Polymorphism
# - Inheritance

class Player

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm a player, my name is #{ @name }."
  end

end

p = Player.new('Ender')
a = ["hello", 42, p]
a.each { |x| puts x.to_s }