class Pow2
  def each
    current = 1
    while current < 100
      yield current
      current *= 2
    end
  end
end

# Pow2.new.each {|e| puts e}

# puts

# it = Pow2.new.to_enum

# begin
#   10.times do
#     puts it.next
#   end
# rescue StopIteration
#   puts 'Stopped!'
# end

generator = Enumerator.new do |yielder|
  n = 1
  10.times do
    yielder << n
    n *= 10
  end
end

puts generator.next
puts generator.next
puts generator.next
puts generator.next

p generator.to_a
