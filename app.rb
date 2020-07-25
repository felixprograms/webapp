
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require './models'
require "sinatra/cookies"
require 'faraday'

set :database, {adapter: "sqlite3", database: "foo.sqlite3"}

register Sinatra::ActiveRecordExtension

class App < Sinatra::Base
helpers Sinatra::Cookies
  get '/logout' do
    cookies.delete("user_name")
    redirect '/'  
  end

  get '/' do
    #erb :index, layout: :layout
    'hello'
  end

  get '/login' do
    erb :login, layout: :layout
  end

  post '/login' do
    username = params[:username]
    password = params[:password]
    user = User.find_by(name: username)
    return "BAD" unless user.present?
    return "BAD" unless user.password == password
    cookies[:user_name] = user.name
    redirect '/'
  end

  get '/weather' do
# use user_logged_in? to find out if the user is logged in 
# if user logged in then make an api call to the weather API and get the temperature
# display the temperature and the city inside the :weather template
    if user_logged_in?
       city = params[:city]
       temperature = get_temperature(city)
       erb :weather, layout: :layout, locals:{city: city,temperature: temperature}
    end
  end

  def user_logged_in?
    name = cookies[:user_name]
    User.find_by(name: name).present?
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
