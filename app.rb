require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require "sinatra/cookies"
require 'sinatra/flash'
require 'faraday'
require 'bcrypt'
require_relative './models'
require_relative './stock_api'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

class App < Sinatra::Base
	enable :sessions
	register Sinatra::Flash
	register Sinatra::ActiveRecordExtension
	helpers Sinatra::Cookies
  
	get '/logout' do
    if current_user
      current_user.update(session_hash: SecureRandom.hex(16))
    end
    cookies.delete("session_hash")
		flash[:notice] = "You are logged out"
    redirect '/'  
  end

  get '/' do
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
    redirect '/login' unless user.present?
    redirect '/login' unless BCrypt::Password.new(user.password) == password
    cookies[:session_hash] = user.session_hash
		flash[:notice] = "You are logged in"
    redirect '/'
  end

  get '/weather' do
    redirect '/' unless user_logged_in?
    erb :weather, layout: :layout
  end

  post '/weather' do
    city = params[:city]
    temperature = get_temperature(city)
    erb :weather_display, layout: :layout, locals: {city: city, temperature: temperature, toast: { title: 'Hello', body: 'some text' } }
  end	

  get '/feed' do
    tamagotchi_id = params[:id]
    tamagotchi = Tamagotchi.find_by(id:tamagotchi_id)
    tamagotchi.update({health: tamagotchi.health + 10})
    redirect '/tamagotchis'
  end

  get '/play' do
    tamagotchi_id = params[:id]
    tamagotchi = Tamagotchi.find_by(id:tamagotchi_id)
    tamagotchi.update({fun: tamagotchi.fun + 10})
    redirect '/tamagotchis'
  end


  get '/registration' do
    erb :registration, layout: :layout
  end

  post '/registration' do
    username = params[:username]
    password = params[:password]
    email = params[:email]
    User.create({name: username, password: BCrypt::Password.create(password), session_hash: SecureRandom.hex(16), email: email}) unless User.find_by(name: username) == false and User.find_by(email: email) == false
    redirect '/login'
    
  end
  
  get '/reset_password' do
    erb :reset_password, layout: :layout
  end
  
  post '/reset_password' do
    reset_token = params[:reset_token]
    user = User.find_by(reset_token: reset_token)
    new_password = params[:new_password]
    user.update(password: BCrypt::Password.create(new_password))
    p 'ok'
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
    Tamagotchi.create(name: tamagotchi_name, health: 100, fun: 100)
    redirect '/tamagotchis'
  end

  get '/buy_stocks/new' do
    erb :buy_stocks, layout: :layout
  end

  post '/buy_stocks' do
    redirect '/' unless user_logged_in?
    price = StockApi.get_stock_price(params[:ticker])
    amount = Float(params[:stock_amount])
    total_amount = price * amount
    user = current_user
    monies = user.my_monies

    if monies < total_amount
      flash[:notice] = "You don't have enough money"
      redirect '/buy_stocks/new'
    end

    exchange = Exchange.create(description: "Bought #{amount} of #{params[:ticker]}", amount: -total_amount, user_id: user.id)
    Stock.create(exchange_id: exchange.id, ticker: params[:ticker], stocks: params[:stock_amount])
    flash[:notice] = "You successfully bought #{amount} of #{params[:ticker]}, you have #{monies} left."
    redirect '/'
  end

  def current_user
    User.find_by(session_hash: cookies[:session_hash])
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

end
