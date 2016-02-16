class HomeController < ApplicationController

  def index

    @result = Geocoder.search(request.ip)
    @current_city = @result[0].data["city"]
    @current_state = @result[0].data["region_code"]

   	@states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC )
  	@states.sort!

  	if params[:state] != nil && params[:city] != nil
  		params[:city].gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/#{params[:state]}/#{params[:city]}.json")["current_observation"]
  	else
  	  @current_city.gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV["wunderground_api_key"]}/conditions/q/#{@current_state}/#{@current_city}.json")["current_observation"]
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
    elsif @weather_word.downcase == "chance of a thunderstorm" || @weather_word.downcase == "chance of thunderstorms" || @weather_word.downcase == "thunderstorm" || @weather_word.downcase == "thunderstorms"
      @url = "https://images.unsplash.com/photo-1427507791254-e8d2fe7db7c0?crop=entropy&fit=crop&fm=jpg&h=675&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1325"
    elsif @weather_word.downcase == "fog" || @weather_word.downcase == "haze"
      @url = "https://images.unsplash.com/reserve/2UiWkCi7TAKfuSlY5L9g_IMG_3579.JPG?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=a63b55fba5f2756e5508162e1a7b1f24"
    elsif @weather_word.downcase == "chance rain" || @weather_word.downcase == "chance of rain" || @weather_word == "rain"
      @url = "https://images.unsplash.com/photo-1428592953211-077101b2021b?crop=entropy&fit=crop&fm=jpg&h=675&ixjsv=2.1.0&ixlib=rb-0.3.5&q=80&w=1325"
    elsif @weather_word.downcase == "chance of flurries" || @weather_word.downcase == "chance of freezing rain" || @weather_word == "chance of sleet" || @weather_word == "flurries" || @weather_word == "freezing rain" || @weather_word == "sleet"
      @url = "https://images.unsplash.com/25/snow-light.JPG?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=346e7570c1549b5f1b48e54bc03935f5"
    elsif @weather_word.downcase == "chance of snow" || @weather_word.downcase == "snow"
      @url = "https://images.unsplash.com/photo-1431036101494-66a36de47def?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=56cdaadbf92590359edea1972024429a"
    else
      @url = "https://images.unsplash.com/photo-1443479579455-1860f114bf77?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=7bef5513fef774c78af3d88e63ab9baf"      
  	end





  end

  def test
  end
end
