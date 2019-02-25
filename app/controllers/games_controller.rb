require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    letters = params[:letters].split(' ')
    word = params[:word]
    if !in_the_grid?(word, letters)
      @score = 0
      @message = "CHEATER, #{word} IS NOT IN THE GRID"
    elsif !an_english_word?(word)
      @score = 0
      @message = "Sorry, #{word} isn't an english word..."
    else
      @score = word.length
      @message = 'Good job!'
    end
  end

  private

  def in_the_grid?(word, array)
    word_array = word.upcase.split('')
    word_array.all? do |letter|
      array.include?(letter) && word_array.count(letter) <= array.count(letter)
    end
  end

  def an_english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    data = JSON.parse(open(url).read)
    data['found']
  end
end
