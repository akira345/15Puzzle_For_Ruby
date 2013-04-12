if development?
  require 'sinatra/reloader'
end
enable :sessions

def prosess()
  return init_game if session[:puzzle].nil?
  redirect '/play/'
end
def play()
  link=params[:link] || 0
  redirect '/' if session[:puzzle].nil?
  puzzle=session[:puzzle]
  puzzle.move(link)
  return puzzle
end
def init_game()
  puzzle=Puzzle.new(9)
  session[:puzzle]=puzzle
  return puzzle
end
def start()
  difficult=(params[:difficult] || :Normal).to_sym
  redirect '/' if session[:puzzle].nil?
  puzzle=session[:puzzle]
  puzzle.difficult=difficult
  puzzle.generate_question()
  return puzzle
end
def giveup()
  session[:puzzle]=nil
  redirect '/'
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
get '/play/' do
  @puzzle=play()
  erb :app
end
post '/giveup/' do
  @puzzle=giveup()
  erb :app
end
post '/start/' do
  @puzzle=start()
  erb :app
end
