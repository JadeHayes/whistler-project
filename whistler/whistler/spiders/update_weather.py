import scrapy
from scrapy.selector import Selector
import requests
import json
from model import db, connect_to_db, Skirun, Lift, Category, SkirunLift, Weather
from flask import Flask
import os


app = Flask(__name__)

connect_to_db(app)


class WeatherSpider(scrapy.Spider):
    # Name our scrapper will refer to when starting
    name = "update_weather"

    def start_requests(self):
        yield scrapy.Request(url='https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/snow-and-weather-report.aspx', callback=self.parse)

    # Will parse through the page
    def parse(self, response):
        """ Parse through Whistlers weather page """
            # Extract the current weather report
        daily_rept = Selector(response=response).xpath('//script/text()').extract()[8]
        snowfall_rept = json.loads(daily_rept.split("=")[2].split(";")[0])

        # Extract the forcast weather report
        forcast_rept = Selector(response=response).xpath('//script/text()').extract()[11]
        forcast = json.loads(forcast_rept.split("=")[2].split(";")[0])

        # Calculate and convert snow to inches
        daily_snow_inches = snowfall_rept['TwentyFourHourSnowfall']['Inches']
        daily_snow_centimeters = snowfall_rept['TwentyFourHourSnowfall']['Centimeters']
        daily_snowfall = (int(daily_snow_centimeters) * 0.39) + int(daily_snow_inches)

        # extract overnight snowfall information
        overnight_snowfall_inches = snowfall_rept['OvernightSnowfall']['Inches']
        overnight_snowfall_centimeters = snowfall_rept['OvernightSnowfall']['Centimeters']
        overnight_snowfall = (int(overnight_snowfall_centimeters) * 0.39) + int(overnight_snowfall_inches)

        if overnight_snowfall < 1:
            overnight_snowfall = 0
        # import pdb; pdb.set_trace()

        # extract forcast information
        long_forcast = forcast[0]['ForecastData'][0]['WeatherLongDescription']
        wind_forcast = forcast[0]['Wind']
        forcast_icon = forcast[0]['WeatherIconStatus']

        #  query the db for the weater obj
        weather = Weather.query.filter(Weather.weather_id == 1).first()

        #  update weather conditions
        weather.wind_forcast = wind_forcast
        weather.daily_snowfall = daily_snowfall
        weather.overnight_snowfall = overnight_snowfall
        weather.snow_forcast = long_forcast
        weather.forcast_icon = forcast_icon

        db.session.commit()
