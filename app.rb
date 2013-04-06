if development?
  require 'sinatra/reloader'
end
enable :sessions
def prosess()
  button=params[:button]
  difficult=params[:difficult] || "Normal"
  link=params[:link] || 0

  if(session[:puzzle].nil? || button=="GIVEUP") then
    puzzle=Puzzle.new(9)
    session[:puzzle]=puzzle
  else
    puzzle=session[:puzzle]
  end
  
  if(button=="START")then
    puzzle.difficult=difficult
    puzzle.generate_question()
  end

  #リンクから動かす
  puzzle.move(link)
  return puzzle
end
require './view_helper.rb'
helpers do
  include ViewHelper
end
post '/' do
  @puzzle=prosess()
  erb :app  
 end
get '/' do
   @puzzle=prosess()
  erb :app
end



