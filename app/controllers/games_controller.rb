require "json"
require "open-uri"


class GamesController < ApplicationController
  VOWELS = %w(a e i o u)

  def new
    @letters = Array.new(4) { VOWELS.sample }
    @letters += Array.new(6) { (('a'..'z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @input = params[:input]
    @letters = params[:letters]
    @included = included?(@input, @letters)
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    web = URI.open(url).read
    word = JSON.parse(web)
    score =["Congrats #{@input.upcase} is an English word", "Sorry but #{@input.upcase} does not seem to be a valid English word...", "Sorry but #{@input.upcase} can't be built out of #{@letters}"]
    if @included
      if word["found"]
        @score = score[0]
      else
        @score = score[1]
      end
    else
        @score = score[2]
    end
  end

  def included?(input, letters)
  input.chars.all? { |i| input.count(i) <= letters.split.count(i) }
  end
end
