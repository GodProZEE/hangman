require_relative "lib/dictionary"
require_relative "lib/game_area"

def create_dict_choose_word
  dictionary = Dictionary.new("google-10000-english-no-swears.txt")
  dictionary.choose_word
end

word = create_dict_choose_word
game = GameArea.new(word)

def looping_through_game(game)
  game.display_blanks(game.blank_lines_for_word)
  loop do
    guess_letter = game.make_guess
    game.update_display(game.blank_lines_for_word, game.random_word, guess_letter)
  end
end

looping_through_game(game)
