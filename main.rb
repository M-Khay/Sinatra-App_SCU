	require 'sinatra'
	require 'sinatra/reloader' if development?
	require 'sass'

require'./student'


configure do
  enable :sessions
  
end
	get '/' do 
	erb :home
	end

	get '/about' do

	erb :about

	end


	get'/login' do
@user = session[:user]
if !@user 

	erb :login
else
	redirect "/"
	end
end

	post '/login' do 
	if params[:username]== 'kush' and params[:password] == "Test@1234"
session[:user] = "kush"
	redirect '/'

	else

	redirect '/login'
	end

	end

	get '/logout' do
session.clear
	erb :logout

	end

	



