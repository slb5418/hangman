
class Hangman
	attr_accessor :secret_word

	def initialize(dictionary)
		secret_word = get_secret_word(dictionary)
	end

	def get_secret_word(dictionary)
		secret_word = ""
		while secret_word.length < 5 || secret_word.length > 12
			secret_word = all_words[Random.rand(len_words)]
		end		
	end

	def draw_noose()
		# draw the noose
		noose = \
		"        ____________\n
		       |            |\n
		       |            |\n
		                    |\n
		                    |\n
		                    |\n
		                    |\n
		                    |\n
		                _________"

		puts noose
	end
end

puts "\nWelcome to hangman!"
puts "A random secret word will be selected from a large dictionary."
puts "Good Luck!"

all_words = File.readlines('5desk.txt')
len_words = all_words.length

