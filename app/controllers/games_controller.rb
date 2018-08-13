require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0..8).map {('a'..'z').to_a[rand(26)]}

  end

  def score
    @word = params["word"]
    @letters = params["letters"]
    @word_arr = @word.chars
    attempt = @word_arr.map do |letter|
      @letters.include?(letter)
    end

    if !attempt.include?(false)
      if english_word?
        @score = "Congratulations! #{@word} is a valid English word"
      else
        @score = "Sorry but #{@word} does not seem to be a valid English word"
      end
    else
      @score = "sorry but #{@word} cannot be built from #{@letters} "
    end
  end
end

private

def english_word?
  response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
  json = JSON.parse(response.read)
  json['found']
end
