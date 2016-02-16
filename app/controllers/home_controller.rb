class HomeController < ApplicationController
  
  #HW: use geocoder gem to get IP address and then use that location as the default location
  #have to push to heroku to test since no IP address in local host 3000
  #add more pictures for more conditions

  def index

    @result = Geocoder.search(request.ip)
    # @current_city = result[0].data["city"]
    # @current_state = result[0].data["region_code"]

   	@states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC )
  	@states.sort!

  	if params[:state] != nil && params[:city] != nil
  		params[:city].gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/#{params[:state]}/#{params[:city]}.json")["current_observation"]
  	else
  	  current_user.city.gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/#{current_user.state}/#{current_user.city}.json")["current_observation"]
  	end
  	#location, temp_f, temp_c, weather_icon, weather_word, forecast_link, feels_like

  	@location = response["display_location"]["city"]
  	@temp_f = response["temp_f"]
  	@temp_c = response["temp_c"]
  	@icon = response["icon_url"]
  	@weather_word = response["weather"]
  	
		@forecast_url = response["forecast_url"]
  	@feels_like = response["feelslike_f"]
  	

  	if @weather_word.downcase == "cloudy" || @weather_word.downcase == "overcast" || @weather_word.downcase == "mostly cloudy"
  		@url = "https://images.unsplash.com/photo-1415905534840-dcbeb98bc78e?crop=entropy&fit=crop&fm=jpg&h=675&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1325"
  	elsif @weather_word.downcase == "clear" || @weather_word.downcase == "sunny" || @weather_word == "mostly sunny"
  		@url = "https://images.unsplash.com/photo-1421091242698-34f6ad7fc088?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=36d7f4a57b95c194adaecac96d4fc395"
  	end



  end

  def test
  end
end
