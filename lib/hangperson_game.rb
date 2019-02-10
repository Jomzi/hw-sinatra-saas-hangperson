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

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(characters)
    if characters==nil || characters=='' || !characters.match("[a-zA-Z]")
      raise ArgumentError
    end
    characters.downcase!
    
    if @guesses.include?(characters) || @wrong_guesses.include?(characters)
      return false
    end  
    if !@word.include?(characters)
      @wrong_guesses += characters
    else  
      @guesses += characters
    end  
    true
  end
  
  def word_with_guesses
    ret = ''
    @word.each_char do |ch|
      ret += @guesses.include?(ch) ? ch : '-'
    end
    return ret
  end
  
  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    end  
    if @word == word_with_guesses
      return :win
    end
    
    
  end  

end  