import scrapy
from scrapy.selector import Selector
import requests
import json
from model import db, connect_to_db, Skirun, Lift, Category, SkirunLift, User, Rating, SkillLevel, CatUser, Food, FoodLift
from flask import Flask
# from seed_helper import food_parse
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
        # os.system('dropdb whistler')
        # os.system('createdb whistler')
        # db.create_all()
        # r = requests.get('https://www.whistlerblackcomb.com/the-mountain/mountain-conditions/terrain-and-lift-status.aspx')
        skiruns_str = Selector(response=response).xpath('//script/text()').extract()[8]
        skiruns = json.loads(skiruns_str.split("=")[1].split(";")[0])
        lifts = skiruns['Lifts']
        #add all lifts to the DB
        for lift_dict in lifts:
            liftname = lift_dict['Name']
            liftstatus = lift_dict['Status']
            mountain = lift_dict['Mountain']
            new_lift = Lift(name=liftname, status=liftstatus, mountain=mountain)
            # import pdb; pdb.set_trace()
            db.session.add(new_lift)
        db.session.commit()

        # a list of dictionaries, with all the data of ski runs, separated by lifts
        runs_list = skiruns['GroomingAreas']

        # lifts_dict is a dictionay where the key 'Runs' has a value of a
        # list with all ski runs that belong to the lift.  The key 'Name' has a value
        # of each lift that services those runs, split by "-"
        for lifts_dict in runs_list:
            #add all the runs to the DB
            skirun_list = lifts_dict['Runs']
            # list of lift names separated by '-'
            lift_names = lifts_dict['Name']
            if lift_names == 'The Peak - T-Bar':
                lift_names = ['The Peak', 'T-Bars']
            else:
                lift_names = lift_names.split(" - ")

            # each ski run list is a list of runs that belong to one lift
            for skirun in skirun_list:
                skirun_name = skirun['Name']
                if '/' in skirun_name:
                    skirun_name = skirun_name.replace('/', '-')
                skirun_status = skirun['IsOpen']
                skirun_groomed = skirun['IsGroomed']
                level = skirun['Type']

                new_run = Skirun(name=skirun_name, groomed=skirun_groomed,
                                     status=skirun_status, level=level)
                import pdb; pdb.set_trace()
                db.session.add(new_run)
            db.session.commit()

            #make the connections
            for lift_name in lift_names:
                # Change to the same lift names in the scrape
                if lift_name == 'Crystal Zone':
                    lift_name = 'Crystal Ridge Express'
                if lift_name == 'Freestyle Half-pipes':
                    lift_name = 'Catskinner Chair'
                if lift_name == 'Symphony Amphitheatre':
                    lift_name = 'Symphony Express'
                if lift_name == 'The Peak':
                    lift_name = 'Peak Express'
                if lift_name == 'Glacier':
                    lift_name = 'Showcase T-Bar'
                if lift_name == 'Habitat Terrain Park':
                    lift_name = 'Emerald Express'
                lift_obj = Lift.query.filter(Lift.name.contains(lift_name)).first()

                # adding relationship
                for run in skirun_list:
                    skirun_name = run['Name']
                    if '/' in skirun_name:
                        skirun_name = skirun_name.replace('/', '-')
                    run_obj = Skirun.query.filter(Skirun.name == skirun_name).first()
                    lift_obj.skiruns.append(run_obj)

            db.session.commit()

        categorieslst = ['tree', 'groomer', 'park', 'bowl']
        for category in categorieslst:
            add_category = Category(cat=category)
            db.session.add(add_category)
        db.session.commit()

        levels = ['green', 'blue', 'black']
        for level in levels:
            add_level = SkillLevel(level=level)
            db.session.add(add_level)
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
        users = open("../../../static/json/users.json").read()
        users = json.loads(users)
        for user in users:
            fname = user['fname']
            lname = user['lname']
            email = user['email']
            zipcode = user['zipcode']

            # check to see user selected categories
            if user.get('category'):
                category = user['category']

            # level for fake data
            rand_level = random.choice(levels)
            level = SkillLevel.query.filter(SkillLevel.level == rand_level).first()

            clients = User(fname=fname,
                           lname=lname,
                           email=email,
                           zipcode=zipcode,
                           level_id=level.level_id,
                           password='123')

            db.session.add(clients)

            #make the connections
            for cat in category:
                user_obj = User.query.filter(User.email == email).first()
                catusr = Category.query.filter(Category.cat == cat).first()
                catusr.users.append(user_obj)
            db.session.commit()

        ratings = open("../../../static/json/rating.txt").read()
        ratings = ratings.strip()
        ratings = ratings.split('|')

        #  loop through the list of comments
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

        restaurants = open("../../../static/json/food.txt")

        for restaurant in restaurants:
            restaurant = restaurant.strip()
            restaurant_data = restaurant.split('|')
            name = restaurant_data[0].title()
            description = restaurant_data[1][:200]
            location = restaurant_data[2]
            lift_id = int(restaurant_data[4])
            yelp_id = restaurant_data[5]

            # import pdb; pdb.set_trace()
            lift_obj = Lift.query.filter(Lift.lift_id == lift_id).first()

            new_restaurant = Food(name=name, description=description, location=location, yelp_id=yelp_id)
            db.session.add(new_restaurant)
            # adding relationship
            new_restaurant.lifts.append(lift_obj)

        db.session.commit()
