require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    vowels = ['a', 'e', 'i', 'o', 'u']
    consonants = ('a'..'z').to_a - vowels

    3.times do
      @letters << vowels.sample
    end

    7.times do
      @letters << consonants.sample
    end

    @letters = @letters.shuffle
    session[:letters] = @letters

  end

  def score
    result = URI.open("https://dictionary.lewagon.com/#{params[:word]}").read
    result = JSON.parse(result)
    @letters = session[:letters]
    @word = params[:word].chars
    valid_word = @word.all? { |letter| @letters.include?(letter) }

    if valid_word == false
      @score = 'Sorry'
    elsif valid_word == true && result['found'] == true
      @score = 'This is a valid word'
    else
      @score = 'This is not an English word'
    end
  end
end
