class GameArea
  attr_accessor :random_word, :blank_lines_for_word

  def initialize(random_word)
    @random_word = random_word
    @blank_lines_for_word = new_display(random_word)
  end

  def new_display(random_word)
    blank_lines_for_word = ""
    (0..random_word.size - 1).each do
      blank_lines_for_word.concat("_ ")
    end
    blank_lines_for_word
  end

  def make_guess
    puts "Please guess ONE letter"
    gets.chomp
  end

  def check_guess(word, guess_letter)
    word.include?(guess_letter)
  end

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

  def update_display(blank_lines_for_word, word, guess_letter)
    if check_guess(word, guess_letter)

      numbers_to_replace = locate_letters(word, guess_letter)
      numbers_to_replace.each do |value|
        blank_lines_for_word[value * 2] = guess_letter
      end
    end

    display_blanks(blank_lines_for_word)
  end
end
