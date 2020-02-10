require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ("A".."Z").to_a
    10.times do
      index = rand(0..25)
      letter = alphabet[index]
      @letters << letter
    end
    @letters
  end

  def score
    if word_is_in_grid? == false ||counts_same_number? == false
      @score = 1
    elsif wagon_dictionnary? == false
      @score = 2
    else
      @score = 3
    end
    return @score
  end

  def word_is_in_grid?
    word = params["attempt"].upcase.split("")
    word.each do |letter|
      if params["letters"].include?(letter)
        return true
      else
        return false
      end
    end
  end

  def counts_same_number?
    word = params["attempt"].upcase.split("")
    word.each do |letter|
      if word.count(letter) > params["letters"].count(letter)
        return false
      end
    end
  end

  def wagon_dictionnary?
    url = "https://wagon-dictionary.herokuapp.com/#{params["attempt"]}"
    serialized_word = open(url).read
    result = JSON.parse(serialized_word)
    return result["found"]

  end
end
# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
