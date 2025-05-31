require_relative "lib/dictionary"
require_relative "lib/game_area"
require "json"

dictionary = Dictionary.new("google-10000-english-no-swears.txt")

def looping_through_game(game, word)
  game.display_blanks(game.blank_lines_for_word)
  puts "If at any point you wanna save, type 'save'"
  p "Guesses remaining: #{game.guesses_remaining}, blank_counter: #{game.blank_counter}"
  while !game.blank_counter.zero? && !game.guesses_remaining.zero?
    guess_letter = game.make_guess
    p "Guess letter: #{guess_letter}"
    p guess_letter == "save"
    if guess_letter == "save"
      game.to_json
      break
    else
      game.update_display(game.blank_lines_for_word, game.random_word, guess_letter, game.blank_counter)
      p "Guesses remaining: #{game.guesses_remaining}, blank_counter: #{game.blank_counter}"
    end
    if game.guesses_remaining.zero?
      puts "You kinda actually technically lost booooo"
      break
    elsif game.blank_counter.zero?
      puts "Yayyy you won!"
      break
    end
  end
end

def play_game(dictionary)
  p "do you wanna play?"
  answer = gets.chomp
  return unless answer == "yes"

  word = dictionary.choose_word
  game = if ask_to_load_data == true
           GameArea.from_json(choose_number)
         else
           GameArea.new(word, word.size + 10, GameArea.new_display(word), "")
         end
  looping_through_game(game, word)
end

def ask_to_load_data
  puts "Do you wanna restore a save?"
  answer = gets.chomp
  answer.downcase == "yes"
end

def choose_number
  puts "Please enter the number of the save you wanna restore"
  gets.chomp.to_i
end
play_game(dictionary)
