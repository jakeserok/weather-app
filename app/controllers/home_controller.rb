require 'net/http'
class HomeController < ApplicationController
  def index
    @cities = cities
    if params['commit'] == 'Find your weather'
      redirect_to weather_path
    end
  end
  
  def weather
    return unless params

    cities_arr = params['Cities'].split(', ')
    @city = cities.key(params['Cities'])
    return unless cities || @city

    lon = cities_arr.first
    lat = cities_arr.last
    uri = URI("https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&units=imperial&appid=4122bf69c370c6031644365f82abe143")
    res = Net::HTTP.get_response(uri)
    @data = JSON.parse(res.body)
    @data_weather = @data['weather'].first
  end

  private

  def cities
    YAML.load_file('config/cities.yml')
  end
end