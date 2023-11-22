def main
  input = File
    .readlines("input/day04.txt")
    .map(&:strip)

  numbers = input[0].split(",")
  boards = []

  idx = 2
  while idx + 5 <= input.length
    b = input[idx...idx+5].map do |line|
      line.split(' ').select { |space| !space.empty? }
    end
    idx += 6
    boards << b
  end

  won_boards = []
  won_boards_scores = {}

  numbers.each do |n|
    boards.each_with_index do |board, i|
      board.each { |line| line.map! { |e| e == n ? "*#{e}" : e } }

      if !won_boards_scores.key?(i) && check_board(board)
        score = board_score(board, n)
        won_boards << i 
        won_boards_scores[i] = score
      end
    end
  end

  puts "First won board scores: #{won_boards_scores[won_boards[0]]}"
  puts "Last won board scores: #{won_boards_scores[won_boards[-1]]}"
end

def board_score(board, called_num)
  board_sum = board.sum do |line|
    line.sum { |v| v[0] != '*' ? v.to_i : 0 }
  end
  board_sum * called_num.to_i
end

def check_board(board)
  board_size = board.size

  board_size.times do |i|
    in_row = board[i].all? { |value| value.start_with?('*') } 
    in_col = board.all? { |value| value[i].start_with?('*') }

    return true if in_row || in_col
  end
  false
end

main()
