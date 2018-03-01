import argparse
import json
import pprint
import requests
import sys
import urllib
import os
from model import connect_to_db, db, Category, Weather, Lift, Skirun, User, Rating, SkillLevel, CatUser, Food, FoodLift
from flask import (Flask, render_template, redirect, flash,
                   session, jsonify)
from flask_debugtoolbar import DebugToolbarExtension
from jinja2 import StrictUndefined

app = Flask(__name__)

connect_to_db(app)

try:
    # For Python 3.0 and later
    from urllib.error import HTTPError
    from urllib.parse import quote
    from urllib.parse import urlencode
except ImportError:
    # Fall back to Python 2's urllib2 and urllib
    from urllib2 import HTTPError
    from urllib import quote
    from urllib import urlencode

YELP_API_KEY= os.environ.get("YELP_API_KEY")

API_HOST = 'https://api.yelp.com'
SEARCH_PATH = '/v3/businesses/search'
BUSINESS_PATH = '/v3/businesses/'

app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "ABC"

# Normally, if you use an undefined variable in Jinja2, it fails
# silently. This is horrible. Fix this so that, instead, it raises an
# error.
app.jinja_env.undefined = StrictUndefined
#so we do not see the redirect 302 page

app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
# ###################################################################


def request(host, path, api_key, url_params=None):
    """Given your API_KEY, send a GET request to the API.
    Args:
        host (str): The domain host of the API.
        path (str): The path of the API after the domain.
        API_KEY (str): Your API Key.
        url_params (dict): An optional set of query parameters in the request.
    Returns:
        dict: The JSON response from the request.
    Raises:
        HTTPError: An error occurs from the HTTP request.
    """
    url_params = url_params or {}
    url = '{0}{1}'.format(host, quote(path.encode('utf8')))
    headers = {
        'Authorization': 'Bearer %s' % YELP_API_KEY,
    }

    print(u'Querying {0} ...'.format(url))

    response = requests.request('GET', url, headers=headers, params=url_params)

    return response.json()


def get_business(api_key, business_id):
    """Query the Business API by a business ID.
    Args:
        business_id (str): The ID of the business to query.
    Returns:
        dict: The JSON response from the request.
    """
    business_path = BUSINESS_PATH + business_id

    return request(API_HOST, business_path, api_key)


def sql_saver():
    restaurants = open("static/json/food.txt")

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
