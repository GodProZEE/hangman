class Dictionary
  attr_accessor :word_hash

  def initialize(path)
    @word_array = []
    @file = File.open(path)
    reduce_words
  end

  def reduce_words
    while @file.eof? == false
      current_word = @file.gets.chomp
      @word_array << current_word if current_word.size.between?(5, 12)
    end
  end

  def choose_word
    word = @word_array.sample
  end
end
