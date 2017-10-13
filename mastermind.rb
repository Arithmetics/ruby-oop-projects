#welcome to mastermind!

class Game
	attr_accessor :player1, :board, :computer, :moves_left, :scoring
  def initialize(player1)
	  @player1 = Player.new(player1)
    @computer = Computer.new("The Mastermind")
		@board = Board.new
    @moves_left = 10
  end
end

class Player
  attr_accessor :name, :code
  def initialize(name, code = nil)
    @name = name
		@code = code
  end
end

class Computer
  attr_accessor :name
  def initialize(name)
    @name = name
  end

	def welcome(game, board)
		puts "Hello, I am the Mastermind! \n Think you can guess my code? \n You have #{game.moves_left} trys..."
	end


end

class Board
	attr_accessor :choices, :scoring
  def initialize
    @choices = ["red", "yellow", "green", "blue", "white", "purple", "black"]
    @code = [@choices.sample, @choices.sample, @choices.sample, @choices.sample]
		@scoring = "\n "
  end

	def player_win(guess)
    if @code == guess
			true
		else
			false
		end
	end

	def computer_win(guess, code)
    if code == guess
			true
		else
			false
		end
	end

	def answer
		puts "the code was #{@code} you dumb shit!"
	end

	def get_code
		code = []
		puts "please submit your code for the computer to guess, one color at a time"
		4.times do
			input = []
			until @choices.include? input
				puts "choices are #{@choices}"
				input = gets.chomp.to_s.downcase
			end
			code.push(input)
		end

		return code
	end

	def guess
		try = []
		puts "please submit a guess, one color at a time"
		4.times do
			input = []
			until @choices.include? input
				puts "choices are #{@choices}"
				input = gets.chomp.to_s.downcase
			end
			try.push(input)
		end
		@scoring << ("\n" + try.join(",")+ " => ")
		return try
	end


	def check(guess)
    #set up unicode symbols for graphics
    black_box = "\u25A0"
    white_box = "\u25A1"
    dot = "\u2022"
	  #set up arrays
    result = []
    code_copy = []
    guess_copy = []
    #do checks for pegs in the exact same spot (blacks)
    guess.each_with_index do |x,i|
      if x == @code[i]
    	  result.push(black_box)
      else
    	  code_copy.push(@code[i])
      	guess_copy.push(x)
      end
    end
    #now for white pegs and blanks
    guess_copy.each do |x|
    	if (code_copy.any? { |y| y == x  })
  	  	result.push(white_box)
        code_copy.delete(x)
      else
        result.push(dot)
      end
    end
    #show result
		@scoring << result.shuffle.join("  ")
    puts result.shuffle.join("  ")
  end


	def computer_guess()

	end



end


#post flow here


puts "To enter The Mastermind's chamber, please enter your name:"

player_name = gets.chomp.to_s

puts "Do you want to guess my code, or should I yours?"
puts "pick 'guess' or 'choose'"
choice = gets.chomp.to_s.downcase



if choice == "guess"

  #player will guess computer code

  new_game = Game.new(player_name)

  new_game.computer.welcome(new_game, new_game.board)

  until new_game.moves_left == 0
    puts "this is your scoring so far #{new_game.board.scoring}"
    x = new_game.board.guess

    if new_game.board.player_win(x)
      puts "oof, looks like you are the mastermind! good guess, you win!"
      break
      else
        new_game.moves_left -= 1
        puts "WRONG! (trump voice), you only have #{new_game.moves_left} moves left"
        puts "here is your score"
        new_game.board.check(x)
      end
  end

  if new_game.moves_left == 0
    puts new_game.board.answer
    else
      puts "thanks for playing!"
  end

elsif choice == "choose"

  #player will pick a code, computer will try to guess

  new_game = Game.new(player_name)

  new_game.player1.code = new_game.board.get_code

  puts "this shouldnt take long! give me 10 guesses..."

  first_guess = [new_game.board.choices.sample, new_game.board.choices.sample, new_game.board.choices.sample, new_game.board.choices.sample]
  #first_guess = ["red", "red", "red", "red"]
  puts "my first guess is #{first_guess}"

  if new_game.board.computer_win(first_guess, new_game.player1.code)
      puts "oh yeah, nice code. Humans are even more predicatable than computers! hahahaha! goodbye"
      sleep(5)

    else
     new_game.moves_left -= 1

     until new_game.board.computer_win(first_guess, new_game.player1.code) || new_game.moves_left == 0
       puts "I have #{new_game.moves_left} moves left"
			 first_copy = first_guess.clone
       save_code = [nil, nil, nil, nil]
       not_taken = [0,1,2,3]
       code_copy = new_game.player1.code.clone

       first_copy.each_with_index do |x, i|
         if x == code_copy[i]
           save_code[i] = x
           code_copy[i] = nil
           not_taken.delete(i)
					 first_copy[i] = "checked"
				end #if x == code_copy
       end #do |x,i|

			first_copy.each_with_index do |x,i|
				if code_copy.include? x
					spot = not_taken.sample
		 			save_code[spot] = x
		 			not_taken.delete(spot)
		 			code_copy.delete_at(code_copy.index(x))
			  end #new_game.player1
		  end #first_guess.each

       not_taken.each do |x|
         save_code[x] = new_game.board.choices.sample
       end #not_taken.each do


       first_guess = save_code.clone
       puts "my guess is #{first_guess}"
       new_game.moves_left -=1

       sleep(3)

     end #until

     if new_game.board.computer_win(first_guess, new_game.player1.code)
       puts "got it! you really thought you could stump the computer???"
       sleep(5)
       puts "goodbye!"
       sleep(4)
     else
       puts "ah i ran out of time.... I blame my programmer!"
     end #if new_game.board.computerwin


   end #new_game.board.computer







else
#if player doesnt choose either, the game will quit

  puts "well then I guess you should leave!"
  sleep(5)
end #paired with if that chooses to guess or make code
