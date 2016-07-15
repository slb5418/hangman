
class Hangman
	attr_accessor :secret_word

	def initialize(dictionary)

		puts "\nWelcome to hangman!"
		puts "A random secret word will be selected from a large dictionary."
		puts "Good Luck!"

		secret_word = get_secret_word(dictionary)
		puts secret_word
	end

	def get_secret_word(dictionary)
		secret_word = dictionary.sample
		puts secret_word
		return secret_word if secret_word.length >= 5 && secret_word.length <= 12 : get_secret_word(dictionary) 
	end
end

dictionary = File.readlines('5desk.txt')
hangman = Hangman.new(dictionary)
