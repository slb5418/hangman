require 'yaml'

class Hangman
	attr_accessor :secret_word, :number_of_wrong_guesses, :guesses

	def initialize(dictionary)
		puts "\nA random secret word will be selected from a large dictionary."
		puts "Good Luck!"
		@secret_word = get_secret_word(dictionary)
		@number_of_wrong_guesses = 6
		@guesses = []
	end

	def play()
		while @number_of_wrong_guesses > 0
			#2. display the number of guesses remaining and the correct letters
			display_guesses_and_word()
			#3. allow the player to guess a letter
			input = get_input()
            while input == 'save'
                input = get_input()
            end
			if check_win()
				puts "\n#{@secret_word}"
				puts "\nYou have won the game!\n"
				exit()
			end
			@number_of_wrong_guesses -= 1 if not secret_word.split(//).include?(input)
		end
		puts "\nOH NO! you are out of guesses"
		puts "The secret word was:"
		puts @secret_word
		puts "\nYou have been hung!\n"
		show_noose()
	end

	def get_secret_word(dictionary)
		word = ""
		while word.length() < 5 || word.length() > 12
			word = dictionary.sample().strip().downcase()
		end
		return word
	end

	def display_guesses_and_word()
		puts "\nNumber of wrong guesses remaining: #{@number_of_wrong_guesses}"
		display = ""
		@secret_word.each_char do |letter|
			@guesses.include?(letter) ? display << letter+" " : display << "_ "
		end
		puts "\n",display
	end

	def player_guess()
		puts "\nPlease guess a letter!"
		guess = gets.chomp()
		@guesses << guess
		return guess
	end

	def get_input()
		puts "\nPlease guess a letter! (type 'save' at any time to save)"
		input = gets.chomp()
        if input == 'save'
            save_game()
        else
            @guesses << input
        end
        return input
	end

	def check_win()
		win = true
		@secret_word.split(//).each{|letter| win = false if not @guesses.include? letter}
		return win
	end

	def show_noose()
		puts "  --------"
		puts "  |      |"
		puts "  O      |"
		puts " `|`     |"
		puts "  ^      |"
		puts "         |"
		puts "         |"
    	puts "     ---------\n"
	end  
end

def load_game()
    content = File.open('saved_data/hangman_save.yaml', 'r') { |file| file.read }
    hangman = YAML.load(content)
    puts "\nFile loaded!"
    puts "Continuing play"
    return hangman
end

def save_game()
    Dir.mkdir("saved_data") unless Dir.exist? "saved_data"
    filename = 'saved_data/hangman_save.yaml'
    File.open(filename, 'w') do |file|
        file.puts YAML.dump(self)
    end
end

dictionary = File.readlines('5desk.txt')

puts "\n"*20 + "Welcome to hangman!"
puts "Would you like to start a new game or load a saved game?"
puts "Enter 'new' or 'load':"
input = gets.chomp()
until input == 'new' or input == 'load'
	input = gets.chomp()
end
hangman = input == 'load'? load_game() : Hangman.new(dictionary)

hangman.play()
