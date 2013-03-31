if development?
  require 'sinatra/reloader'
end
enable :sessions
def prosess()
  button=params[:button]
  mode_Form=params[:mode_Form]
  link=params[:link]

  if(session[:game].nil? || button=="GIVEUP") then
    g=Puzzle.new(9)
    session[:game]=g
  else
    g=session[:game]
  end
  
  if(button=="START")then
    g.status=1
    g.mode=mode_Form
    if(mode_Form==1)then
      shfull=3
    elsif(mode_Form==2)then
      shfull=6
    elsif(mode_Form=3)then
      shfull=10
    end
    (g.souwaku*shfull).times do
      g.random_move()
      
    end
    if(g.chk_complate())then
      g.random_move()
    end
    g.move(link)

  end 
  return g
end 
post '/' do
  @g=prosess()
  erb :app  
 end
get '/' do
  link=params[:link]
  @g=prosess()
  erb :app
end



