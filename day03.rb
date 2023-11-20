def main
  report = File
    .readlines("input/day03.txt")
    .map(&:strip)
    .select {|line| line.length > 0 }
  
  puts power_consumption(report)
  puts life_support_rating(report)
end

def power_consumption(report)
  bit_length = report.first.length
  oc = Array.new(bit_length, 0) 

  report.each do |n|
    n.each_char.with_index do |c, i|
      oc[i] += 1 if c == '1'
    end
  end

  gr = ''
  er = ''

  oc.each do |c|
    if c > report.length/2
      gr << '1'
      er << '0'
    else 
      gr << '0'
      er << '1'
    end
  end

  gr.to_i(2) * er.to_i(2)
end

# part II 
=begin 
- Start with all 12 numbers and consider only the first bit of each number.
There are more 1 bits (7) than 0 bits (5), so keep only the 7 numbers with a 1
in the first position: 11110, 10110, 10111, 10101, 11100, 10000, and 11001.
- Then, consider the second bit of the 7 remaining numbers: there are more 0
bits (4) than 1 bits (3), so keep only the 4 numbers with a 0 in the second
position: 10110, 10111, 10101, and 10000. 
- In the third position, three of the four numbers have a 1, so keep those
three: 10110, 10111, and 10101. In the fourth position, two of the three
numbers have a 1, so keep those two: 10110 and 10111. 
- In the fifth position, there are an equal number of 0 bits and 1 bits (one
each). So, to find the oxygen generator rating, keep the number with a 1 in
that position: 10111. 
- As there is only one number left, stop; the oxygen generator rating is 10111,
or 23 in decimal. 

Then, to determine the CO2 scrubber rating value from the same example above:

- Start again with all 12 numbers and consider only the first bit of each
number. There are fewer 0 bits (5) than 1 bits (7), so keep only the 5 numbers
with a 0 in the first position: 00100, 01111, 00111, 00010, and 01010. 
- Then, consider the second bit of the 5 remaining numbers: there are fewer 1
bits (2) than 0 bits (3), so keep only the 2 numbers with a 1 in the second
position: 01111 and 01010. 
- In the third position, there are an equal number of 0 bits and 1 bits (one
each). So, to find the CO2 scrubber rating, keep the number with a 0 in that
position: 01010. 
- As there is only one number left, stop; the CO2 scrubber rating is 01010, or
10 in decimal.
=end

def filter_by(report, most_common)
  bit_length = report.first.length
  filtered_rpt = report

  (0...bit_length).each do |i|
    break if filtered_rpt.length <= 1

    ones, zeros = filtered_rpt.partition { |n| n[i] == '1' }
    filtered_rpt = if ones.length >= zeros.length
                     most_common ? ones : zeros
                   else 
                     most_common ? zeros : ones
                   end
  end
  filtered_rpt.first
end

def life_support_rating(report)
  oxy = filter_by(report, true).to_i(2)   # most common bit will be '1's
  co2 = filter_by(report, false).to_i(2)  # least common bit will be '0's
  oxy * co2
end
main()
