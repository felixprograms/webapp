require 'sinatra'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/activerecord'
require_relative './models'
require "sinatra/cookies"
require 'faraday'
require 'bcrypt'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

class App < Sinatra::Base
	enable :sessions
	register Sinatra::ActiveRecordExtension
	register Sinatra::Flash
	helpers Sinatra::Cookies
  
	get '/logout' do
    user = User.find_by(session_hash: cookies[:session_hash])
    if user
      user.update(session_hash: SecureRandom.hex(16))
    end
    cookies.delete("session_hash")
    redirect '/'  
  end

  get '/' do
		flash[:success] = "hello"
    erb :index, layout: :layout
  end

  get '/login' do
    if user_logged_in?
       redirect '/'
    end
    erb :login, layout: :layout
  end

  post '/login' do
    username = params[:username]
    password = params[:password]
    user = User.find_by(name: username)
    return "BAD" unless user.present?
    return "BAD" unless BCrypt::Password.new(user.password) == password
    cookies[:session_hash] = user.session_hash
    redirect '/'
  end

  get '/weather' do
    redirect '/' unless user_logged_in?
    erb :weather, layout: :layout
  end

  post '/weather' do
    city = params[:city] || 'London'
    temperature = get_temperature(city)
    erb :weather_display, layout: :layout, locals: {city: city, temperature: temperature, toast: { title: 'Hello', body: 'some text' } }
  end	

  get '/feed' do
    tamagotchi_id = params[:id]
    tamagotchi = Tamagotchi.find_by(id:tamagotchi_id)
    tamagotchi.update({health: tamagotchi.health + 10})
    redirect '/tamagotchis'
  end

  get '/registration' do
    erb :registration, layout: :layout
  end

  post '/registration' do
    username = params[:username]
    password = params[:password]
    email = params[:email]
    User.create({name: username, password: password})
    redirect '/login'
  end
  
	def user_logged_in?
    session_hash = cookies[:session_hash]
  end

  def get_temperature(city_name)
    api_key = ENV['WEATHER_API_KEY'] 
    api_url = "http://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{api_key}&units=metric"
    response = Faraday.get(api_url)

    weather_data = JSON.parse(response.body)
    temperature = weather_data['main']['temp']
    temperature.to_s
  end

  get '/tamagotchis' do
    redirect '/' unless user_logged_in?
    tamagotchis = Tamagotchi.all
    erb :tamagotchis, layout: :layout, locals: {tamagotchis: tamagotchis}
  end
  
  get '/create_an_tamagotchi' do
    redirect '/' unless user_logged_in?
    erb :create_an_tamagotchi, layout: :layout
  end

  post '/create_an_tamagotchi' do
    tamagotchi_name = params[:username]
    Tamagotchi.create(name: tamagotchi_name, health:100, fun:100)
    redirect '/tamagotchis'
  end
end
