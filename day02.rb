Instructions = Struct.new(:direction, :amount)
Position = Struct.new(:x, :y, :aim)

def main
  instructions = File
    .readlines("input/day02.txt")
    .map(&:strip)
    .select { |line| line.length > 0 }
    .map do |l|
      pts = l.split(" ")
      Instructions.new(pts[0], pts[1].to_i)
    end

  part1(instructions)
  part2(instructions)
end

def part1(instructions)
  pos = Position.new(0, 0, 0)

  instructions.each do |i|
    case i.direction
    when "forward"
      pos.x += i.amount
    when "down"
      pos.y += i.amount
    when "up"
      pos.y -= i.amount
    else 
      puts "Unknown instruction, #{i.direction}"
    end
  end

  puts "#{pos.x * pos.y}"

end

def part2(instructions)
  pos = Position.new(0, 0, 0)

  instructions.each do |i|
    case i.direction
    when "down"
      pos.aim += i.amount
    when "up"
      pos.aim -= i.amount
    when "forward"
      pos.x += i.amount
      pos.y += pos.aim * i.amount
    else
      puts "Unknown instruction, #{i.direction}"
    end
  end
  puts "#{pos.x * pos.y}"
end

main()
