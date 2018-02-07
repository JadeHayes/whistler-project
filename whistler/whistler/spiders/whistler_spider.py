import scrapy
from scrapy.selector import Selector
import requests
import json
from model import db, connect_to_db, Lift, Category, LoadingPt
from flask import Flask

app = Flask(__name__)

connect_to_db(app)

class WhistlerSpider(scrapy.Spider):
    # Name our scrapper will refer to when starting
    name = "whistler"

    def start_requests(self):
        # urls we are going to scrape content from
        # urls = [
        #     'https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx',
        #     'https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/snow-and-weather-report.aspx',
        # ]
        # # Loop through each url and make a request and pass url & callack function
        # for url in urls:
        yield scrapy.Request(url='https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx', callback=self.parse)

    # Will parse through the page

    def parse(self, response):
            # r = requests.get('https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx')
            skiruns_str = Selector(response=response).xpath('//script/text()').extract()[10]
            skiruns = json.loads(skiruns_str.split("=")[1].split(";")[0])
            lifts = skiruns['Lifts']

            import pdb; pdb.set_trace()
            for lift_dict in lifts:
                liftname = lift_dict['Name']
                liftstatus = lift_dict['Status']
                mountain = lift_dict['Mountain']
                new_lift = Lift(name=liftname, status=liftstatus)
                db.session.add(new_lift)
            db.session.commit()

            # runs_dict = skiruns['GroomingAreas']
