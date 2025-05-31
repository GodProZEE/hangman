require "json"
class GameArea
  attr_accessor :random_word, :blank_lines_for_word, :guesses_remaining, :blank_counter

  def initialize(random_word, guesses_remaining, blank_lines_for_word, _blank_counter)
    @random_word = random_word
    @guesses_remaining = guesses_remaining
    @blank_lines_for_word = blank_lines_for_word
    @blank_counter = blank_lines_for_word.count("_")
  end

  def self.new_display(random_word)
    blank_lines_for_word = ""
    (0..random_word.size - 1).each do
      blank_lines_for_word.concat("_ ")
    end

    blank_lines_for_word
  end

  def make_guess
    puts "Please guess ONE letter"

    guess = gets.chomp.downcase
    @guesses_remaining -= 1 if guess.size == 1
    guess
  end

  def check_guess(word, guess_letter)
    word.include?(guess_letter)
  end

  # Create an array to note the lcoatiosn of the letters (due to repititions) to update them later
  def locate_letters(word, guess_letter)
    array = []
    word.chars.each_with_index do |value, index|
      array << index if value == guess_letter
    end
    array
  end

  def display_blanks(blank_lines_for_word)
    p blank_lines_for_word
  end

  def update_display(blank_lines_for_word, word, guess_letter, blank_counter)
    if check_guess(word, guess_letter) && !blank_lines_for_word.include?(guess_letter)

      numbers_to_replace = locate_letters(word, guess_letter)

      numbers_to_replace.each do |value|
        # value*2 because each blank is at index: index_of_character*2 due to spaces.

        blank_lines_for_word[value * 2] = guess_letter
      end

      @blank_counter -= numbers_to_replace.size
    end
    p blank_counter
    display_blanks(blank_lines_for_word)
  end

  def reset_game
    @random_word = random_word
    @blank_lines_for_word = new_display(random_word)
    @guesses_remaining = 7
    @blank_counter = blank_lines_for_word.count("_")
  end

  def to_json(*_args)
    fls = Dir.entries "lib/"

    # There are 4 files intially, removal of 3 means file1 will be created. Add a new file
    # and file2 will be created, and so on
    number = fls.size - 3
    file = File.new("lib/file#{number}.json", "w")
    file.print JSON.dump({
                           random_word: @random_word,
                           blank_lines_for_word: @blank_lines_for_word,
                           guesses_remaining: @guesses_remaining,
                           blank_counter: @blank_counter
                         })
  end

  def self.from_json(number)
    file = File.open("lib/file#{number}.json", "r")
    data = JSON.load file
    p data
    new(data["random_word"], data["guesses_remaining"], data["blank_lines_for_word"], data["blank_counter"])
  end
end
