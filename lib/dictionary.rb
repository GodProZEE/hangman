# This class is used to initiate a dictionary object, that takes in a text file and
# converts all its words to an array, then reduces the array to only include words
# that are 5-12 characters long.
class Dictionary
  attr_accessor :word_hash

  def initialize(path)
    @word_array = []
    @file = File.open(path)
    reduce_words
    @file.close
  end

  def reduce_words
    while @file.eof? == false
      current_word = @file.gets.chomp

      # Words must only be between 5 and 12 characters long for this game
      @word_array << current_word if current_word.size.between?(5, 12)
    end
  end

  def choose_word
    @word_array.sample
  end
end
