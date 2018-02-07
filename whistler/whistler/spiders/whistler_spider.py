import scrapy
from scrapy.selector import Selector
import requests
import json
from model import db, connect_to_db, Skirun, Lift, Category, LoadingPt
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

            for lift_dict in lifts:
                liftname = lift_dict['Name']
                liftstatus = lift_dict['Status']
                mountain = lift_dict['Mountain']
                new_lift = Lift(name=liftname, status=liftstatus)
                db.session.add(new_lift)
            db.session.commit()

            runs_dict = skiruns['GroomingAreas']

            for lifts_obj in runs_dict:
                skirun_obj = lifts_obj['Runs']
                lift_name = lifts_obj['Name']
                new_lift_obj = Lift.query.filter(Lift.name.contains(lift_name)).first()
                import pdb; pdb.set_trace()
                for run in skirun_obj:
                    skirun_name = run['Name']
                    skirun_status = run['IsOpen']
                    skirun_groomed = run['IsGroomed']
                    level = run['Type']

                    new_run = Skirun(name=skirun_name, groomed=skirun_groomed,
                                     status=skirun_status, level=level,
                                     lift=new_lift_obj.lift_id)
                    db.session.add(new_run)


            categories = ['Trees', 'Groomer', 'Park']
            for category in categories:
                add_category = Category(cat=category)
                db.session.add(add_category)
            db.session.commit()










