"""Movie Ratings."""

from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, flash,
                   session)
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, LoadingPt, Category, Weather, Lift, Skirun
from random import sample

app = Flask(__name__)

# Required to use Flask sessions and the debug toolbar
app.secret_key = "ABC"

# Normally, if you use an undefined variable in Jinja2, it fails
# silently. This is horrible. Fix this so that, instead, it raises an
# error.
app.jinja_env.undefined = StrictUndefined
#so we do not see the redirect 302 page
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False

##############################################################################
# App routes for project


@app.route('/')
def index():
    """Homepage."""
    weather_obj = Weather.query.all()
    category_objs = Category.query.all()
    skirun_objs = Skirun.query.all()
    # Grab the weather object so you can pass it through jinja

    for weather in weather_obj:
        total_snow = float(weather.daily_snowfall) + float(weather.overnight_snowfall)
        # Calculate ideal riding category based on the weather
        if total_snow >= 6 and weather.wind_forcast == 'Calm':
            daily_cat = 'bowl'
        elif total_snow > 12:
            daily_cat = 'tree'
        elif total_snow < 6 and weather.wind_forcast == 'Calm':
            daily_cat = 'park'

    for run in skirun_objs:
        if run.name == "18' Half Pipe":
            pipe = run
    # run_objs = db.session.query(Skirun).join(Category).filter(Category.cat ==daily_cat).all()
    cat_id = Category.query.filter_by(cat=daily_cat).first().category_id
    # Can do .limit(3)
    run_objs = Skirun.query.filter(Skirun.category_id == cat_id).all()
    # Query for a list of all of the runs that are groomed groomers, choose 3 random
    groomers = Skirun.query.filter(Skirun.category_id == 2 and Skirun.groomed == True).all()
    groomed_runs = sample(groomers,  3)

    return render_template("homepage.html", weather_obj=weather_obj,
                           categories=category_objs, skiruns=skirun_objs,
                           total_snow=total_snow, weather=weather, daily_cat=daily_cat.title(),
                           run_objs=run_objs, groomed_runs=groomed_runs, pipe=pipe)





##############################################################################

if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True
    # make sure templates, etc. are not cached in debug mode
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # Use the DebugToolbar
    DebugToolbarExtension(app)
    DEBUG_TB_INTERCEPT_REDIRECTS = False

    app.run(port=5000, host='0.0.0.0')
