import scrapy
from scrapy.selector import Selector
import requests
import json
from flask import Flask
import os

import sys
sys.path.append('../../..')
from model import db, connect_to_db, Skirun, Lift, SkirunLift


app = Flask(__name__)

connect_to_db(app)


class WhistlerSpider(scrapy.Spider):
    # Name our scrapper will refer to when starting
    name = "update_spider"

    def start_requests(self):
        """ Will request an object from the url below"""
        # Will get a respomnse with data from website below
        yield scrapy.Request(url='https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx',
                             callback=self.parse)

    #  parse through the page and separate the data into a dict,
    # then parse through for keyword args.

    def parse(self, response):
        """ Parsing through our data returned from webscraping """
        skiruns_str = Selector(response=response).xpath('//script/text()').extract()[10]
        skiruns = json.loads(skiruns_str.split("=")[1].split(";")[0])
        lifts = skiruns['Lifts']

        # update lift status information in the db
        for lift_dict in lifts:
            liftname = lift_dict['Name']
            liftstatus = lift_dict['Status']
            lift = Lift.query.filter(Lift.name==liftname).first()

            lift.status = liftstatus

        db.session.commit()

        runs_list = skiruns['GroomingAreas']

        for lifts_dict in runs_list:

            # Seperate the data from the webbscrapper
            skirun_list = lifts_dict['Runs']
            lift_names = lifts_dict['Name']
            lift_names = lift_names.split(" - ")

            # Loop over and update the run information
            for skirun in skirun_list:
                skirun_name = skirun['Name']
                skirun_status = skirun['IsOpen']
                skirun_groomed = skirun['IsGroomed']
                # import pdb; pdb.set_trace()
                skirun2 = Skirun.query.filter(Skirun.name == skirun_name).first()

                skirun2.status = skirun_status
                skirun2.groomed = skirun_groomed

            db.session.commit()
