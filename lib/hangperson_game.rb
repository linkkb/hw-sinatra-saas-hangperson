class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word_with_guesses
    wwg = ''
    @word.split("").each do |letter|
      if @guesses.include? letter
        wwg = wwg + letter
      else
        wwg = wwg + '-'
      end
    end
    wwg
  end
  
  def guess(guess_list)
    new_guess = false
    if !/^[a-zA-Z]+$/.match(guess_list)
      raise ArgumentError
    end
    guess_list.downcase.split("").each do |guess|
      if !@guesses.include?(guess) and !wrong_guesses.include?(guess)
        new_guess = true
        if @word.include?(guess)
          @guesses = @guesses + guess
        else
          @wrong_guesses = @wrong_guesses + guess
        end
      end
    end
    return new_guess
  end
  
  def check_win_or_lose
    if(wrong_guesses.length>=7)
      return :lose
    end
    if(self.word_with_guesses==@word)
      return :win
    end
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
