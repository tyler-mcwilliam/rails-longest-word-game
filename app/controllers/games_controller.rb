require 'open-uri'

class GamesController < ApplicationController
  def new
    @total_score = 0
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    checker_serialized = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    checker = JSON.parse(checker_serialized)
    word_array = @word.split('')
    @letters.each do |letter|
      word_array.delete(letter)
    end
    return @result = 'No match!' unless word_array.empty?

    if checker['found'] == true
      @result = "Awesome! Your word has #{checker['length']} letters!"
      @total_score += checker['length']
    else
      @result = 'Word not found!'
    end
    @result
  end
end
