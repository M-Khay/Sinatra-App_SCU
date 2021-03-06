require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require 'dm-core'
require 'dm-migrations'
# require 'sass'
# require './student.rb'

configure :development do
  DataMapper.setup :default, "sqlite3://#{Dir.pwd}/model/development.db"
end

configure :production do
  DataMapper.setup :default, ENV['DATABASE_URL']
end

configure do
  enable :sessions
class Student

	puts"Calling Studnet calass"

	include DataMapper::Resource
	property :id, Serial
	property :name, String
	# 0 for Female and 1 for Male.
	property :gender, Integer 
	property :rank, Integer
	property :score, Float


end

DataMapper.finalize					# Validity/Integrity check
# DataMapper.auto_migrate!	# Development will wipe existing data
DataMapper.auto_upgrade!		# Upgrading existing database
  

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


get '/add' do
	puts"Calling add method"

	erb :add
end

post '/add' do 
	students = Student.new
	students.name = params[:name]
	students.gender = params[:gender]
	students.rank = params[:rank]
	students.score = params[:score]
	students.save
	redirect '/students'
end

#  Display all students rgistered and stored 
# in our student dtabase
get '/students' do
@students = Student.all
erb :students
end

get '/students/edit/:id' do
@student = Student.get params[:id]
erb :add

end

post '/students/edit/:id' do

student = Student.get params[:id]
student.update :name => params[ :name],
:gender => params[ :gender],
:score => params[ :score],
:rank => params[ :rank]
redirect "/students"
end

get '/students/delete/:id' do
Student.get(params[:id]).destroy
redirect "/students"

end

	



