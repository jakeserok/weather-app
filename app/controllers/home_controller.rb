require 'net/http'
class HomeController < ApplicationController
  def index
    if params['commit'] == 'Find your weather'
      redirect_to weather_path
    end
  end
  
  def weather
    @params = params
    uri = URI("https://api.openweathermap.org/data/2.5/weather?lat=#{@params['lat']}&lon=#{@params['lon']}&units=imperial&appid=4122bf69c370c6031644365f82abe143")
    res = Net::HTTP.get_response(uri)
    @data = JSON.parse(res.body)
    @data_weather = @data['weather'].first
  end
end