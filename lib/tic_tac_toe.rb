# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
    ]

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip

  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end  

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
empty_check = board.all? { |x|
  x == " " }
draw_check = board.none? { |x|
  x == " " }
win_check = WIN_COMBINATIONS.each { |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
  
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    else
      false
    end
}
  if empty_check == true
    return false
  elsif draw_check == true && win_check == false
    return false
  else 
    return false
end 
end

def full?(board)
  if board.any? { |x| x == " " } == false
    return true
  end
end


#def draw?(board)
#numbers = [0,3,4,5,6,8]
#if won?(board) != false
 # if won?(board) == true || won?(board) == nil
  #  return false
 # elsif won?(board).any?{|i| i = numbers} == true
#    return false
#  end  
#else    
#  if full?(board) == true
#    return true
#  elsif full?(board) != true
#    return false
#  end  
#end  
#end

def draw?(board)
  return (!won?(board) && full?(board))
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if won?(board) != false
    if board[won?(board)[0]] == "X"
      return "X"
    elsif board[won?(board)[0]] == "O"  
      return "O"
    end  
  else
    nil
  end
end  


def play(board)
  count = 0
  until over?(board) == true
    turn(board)
    count += 1
  end
  
  if won?(board) != false
    puts "Congratulations " + winner(board) + "!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end
