depths = File
  .readlines("input/day01.txt")
  .map(&:strip)
  .select { |line| line.length > 0 }
  .map(&:to_i)


def increases(depths, window_size)
  increase = 0
  decrease = 0

  prev_window = depths[0, window_size]
  curr_window = depths[1, window_size]

  (2..depths.length).each do |i|
    prev_sum = prev_window.sum
    curr_sum = curr_window.sum

    if prev_sum < curr_sum
      increase += 1
    elsif prev_sum > curr_sum
      decrease += 1
    end

    break if i + window_size > depths.length

    prev_window = curr_window
    curr_window = depths[i, window_size]
  end

  puts increase 
end

increases(depths, 1)
increases(depths, 3)
