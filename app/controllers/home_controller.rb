class HomeController < ApplicationController
  def index
   	@states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC )
  	@states.sort!
  	if params[:state] != nil && params[:city] != nil
  		params[:city].gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/#{params[:state]}/#{params[:city]}.json")["current_observation"]
  	else
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/FL/Jacksonville.json")["current_observation"]
  	end
  	#location, temp_f, temp_c, weather_icon, weather_word, forecast_link, feels_like
  	
  	@location = response["display_location"]["city"]
  	@temp_f = response["temp_f"]
  	@temp_c = response["temp_c"]
  	@icon = response["icon_url"]
  	@weather_word = response["weather"]
  	
		@forecast_url = response["forecast_url"]
  	@feels_like = response["feelslike_f"]
  end

  def test
  end
end
