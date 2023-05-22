require "json"
require "open-uri"


class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @input = params[:input]
    score =["Congrats #{@input} is an English word", "sorry"]
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    web = URI.open(url).read
    word = JSON.parse(web)
      if word["found"]
        @score = score[0]
      else
      @score = score[1]

  #   elsif word
  #   else
  #     return "Sorry but #{@input} does not seem to be a valid English word..."
      end
  end
end
