require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @time = Time.now
  end

  def score
    @word = params[:word]
    time_end = Time.now
    time_begin = Time.new(params[:time])
    time = time_end - time_begin
    @grid = params[:grid].split(' ')
    a = true
    h = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    @word.upcase.split('').each do |w|
      if @grid.include?(w)
        @grid.delete_at(@grid.index(w))
      else
        a = false
      end
    end

    if a == false
      @result_phrase = "Your word isn't in the grid.."
      @score = 0
    elsif h['found']
      @result_phrase = "Well done!"
      @score = ((@word.size / time) * 100_000_000_000).round
    else
      @result_phrase = "Not an english word.."
      @score = 0
    end
  end
end
