# Answer the following questions:
#
#  1. What is the Prototype Pattern?
#
#  2. How can we apply this pattern to the class Person?
#

class Person

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

end

maria = Person.new('Fräulein Maria')

maria << 'Raindrops on roses'
maria << 'Whiskers on kittens'
maria << 'Bright copper kettles'
maria << 'Warm woolen mittens'
maria << 'Brown paper packages tied up with strings'

maria.each {|x| p x}