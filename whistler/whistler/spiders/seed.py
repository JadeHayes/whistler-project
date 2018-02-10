import scrapy
from scrapy.selector import Selector
import requests
import json
from model import db, connect_to_db, Skirun, Lift, Category, SkirunLift, User, Rating
from flask import Flask
import os
import random

app = Flask(__name__)

connect_to_db(app)


class WhistlerSpider(scrapy.Spider):
    # Name our scrapper will refer to when starting
    name = "whistler"

    def start_requests(self):
        yield scrapy.Request(url='https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx', callback=self.parse)

    # Will parse through the page

    def parse(self, response):
        os.system('dropdb whistler')
        os.system('createdb whistler')
        db.create_all()
        # r = requests.get('https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx')
        skiruns_str = Selector(response=response).xpath('//script/text()').extract()[10]
        skiruns = json.loads(skiruns_str.split("=")[1].split(";")[0])
        lifts = skiruns['Lifts']

        #add all lifts to the DB
        for lift_dict in lifts:
            liftname = lift_dict['Name']
            liftstatus = lift_dict['Status']
            mountain = lift_dict['Mountain']
            new_lift = Lift(name=liftname, status=liftstatus, mountain=mountain)
            db.session.add(new_lift)
        db.session.commit()

        runs_list = skiruns['GroomingAreas']

        for lifts_dict in runs_list:

            #add all the runs to the DB
            skirun_list = lifts_dict['Runs']
            lift_names = lifts_dict['Name']
            lift_names = lift_names.split(" - ")

            for skirun in skirun_list:
                skirun_name = skirun['Name']
                skirun_status = skirun['IsOpen']
                skirun_groomed = skirun['IsGroomed']
                level = skirun['Type']

                #check here if run is already in DB, only add if it's not *

                new_run = Skirun(name=skirun_name, groomed=skirun_groomed,
                                 status=skirun_status, level=level)
                db.session.add(new_run)
            db.session.commit()

            #make the connections
            for lift_name in lift_names:
                # Cahnge to the same lift names in the scrape
                if lift_name == 'Crystal Zone':
                    lift_name = 'Crystal Ridge Express'
                if lift_name == 'Freestyle Half-pipes' or lift_name == 'Habitat Terrain Park':
                    lift_name = 'Catskinner Chair'
                if lift_name == 'Symphony Amphitheatre':
                    lift_name = 'Symphony Express'
                if lift_name == 'The Peak':
                    lift_name = 'Peak Express'
                lift_obj = Lift.query.filter(Lift.name.contains(lift_name)).first()

                # adding relationship
                for run in skirun_list:
                    skirun_name = run['Name']
                    run_obj = Skirun.query.filter(Skirun.name == skirun_name).first()
                    lift_obj.skiruns.append(run_obj)
            db.session.commit()

        categories = ['tree', 'groomer', 'park', 'bowl']
        for category in categories:
            add_category = Category(cat=category)
            db.session.add(add_category)
        db.session.commit()

        # add category to each run
        skiruns = Skirun.query.all()
        categories = {category.cat: category for category in Category.query.all()}

        for skirun in skiruns:
            parks = ['Habitat Terrain Park',
                     'Big Easy Terrain Garden, Sz S', 'Nintendo Terrain Park, sz. M,L',
                     'Highest Level Park, Sz XL']
            bowls = ['Jersey Cream Bowl', 'Rhapsody Bowl', 'Ego Bowl - Lower',
                     'Ego Bowl - Upper']
            trees = ['7th Heaven', 'Enchanted Forest', 'Rock & Roll',
                     "Franz's - Upper", "Franz's - Lower"]
            # skirun.category relationship
            if skirun.name in parks:
                skirun.category = categories['park']
            elif skirun.name in bowls:
                skirun.category = categories['bowl']
            elif skirun.name in trees:
                skirun.category = categories['tree']
            else:
                skirun.category = categories['groomer']
            db.session.commit()

        # Add users to our db
        users = open("../../../static/users.json").read()
        users = json.loads(users)
        for user in users:
            fname = user['fname']
            lname = user['lname']
            email = user['email']
            zipcode = user['zipcode']

            clients = User(fname=fname,
                           lname=lname,
                           email=email,
                           zipcode=zipcode)

            db.session.add(clients)

        # commit work to the db
        db.session.commit()

        ratings = open("../../../static/rating.txt").read()
        ratings = ratings.strip()
        ratings = ratings.split('|')
        # import pdb; pdb.set_trace();

        for comment in ratings:
            comment = comment[:140]
            user_id = random.randint(1, 100)
            rating = random.randint(1, 5)
            skirun_id = random.randint(1, 142)

            comments = Rating(user_id=user_id,
                              rating=rating,
                              skirun_id=skirun_id,
                              comment=comment)
            db.session.add(comments)

        # commit work to the db
        db.session.commit()
