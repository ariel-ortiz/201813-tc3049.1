# Answer the following questions:
#
#  1. What is the Prototype Pattern?
#
#  2. How can we apply this pattern to the class Person?
#

class Person

  attr_accessor :name, :favorite_things

  def initialize(name)
    @name = name
    @favorite_things = []
  end

  def <<(thing)
    @favorite_things << thing
  end

  def each(&block)
    @favorite_things.each(&block)
  end

  def clone
    other = super
    other.name = @name.clone
    other.favorite_things = @favorite_things.clone
    other
  end

end

maria = Person.new('Fräulein Maria')

maria << 'Raindrops on roses'
maria << 'Whiskers on kittens'
maria << 'Bright copper kettles'
maria << 'Warm woolen mittens'
maria << 'Brown paper packages tied up with strings'

maria.each {|x| p x}

maria_clone = maria.clone
maria_clone << 'Rock music'
p maria_clone.to_enum.to_a
p maria.to_enum.to_a

class HappyPerson < Person
  def say_hi
    puts "Hi!"
  end
end

happy_person = HappyPerson.new('Bob')
happy_person.say_hi
happy_person_clone = happy_person.clone
puts happy_person.class.name
puts happy_person_clone.class.name
happy_person_clone.say_hi
