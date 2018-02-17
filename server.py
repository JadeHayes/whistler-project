"""WhistlerMTN"""

from jinja2 import StrictUndefined

from flask import (Flask, render_template, redirect, request, flash,
                   session, jsonify)
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, Category, Weather, Lift, Skirun, User, Rating, SkillLevel, CatUser
from random import sample
from server_function import create_my_flare_json

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
def login():
    """Log-in"""
    return render_template("login.html")


@app.route('/login', methods=['POST'])
def check_login():
    """Checks user login information against the db"""
    #Get POST request information from the /login page
    email = request.form.get('email')
    password = request.form.get('password')

    # Make a query to see if the users email and password are in the db
    user = User.query.filter_by(email=email, password=password).first()

    # If they are in the db, add them to a session and redirect home
    if user:
        if password == user.password:
            session['logged_in'] = user.user_id
            flash("Logged in")
            return redirect("/home")
        else:
            flash("Login failed")
            return redirect("/log-in")
    else:
        flash("Hello there new friend, please register here")
        return redirect("/register")


@app.route('/register')
def register():
    """renders registration template"""
    return render_template("registration.html")


@app.route('/register', methods=['POST'])
def add_info():
    """Saves users registration information in the db"""

    # Get user information from registration form input
    #  FIXME: need to add users level & ride pref
    fname = request.form.get('fname')
    lname = request.form.get('lname')
    email = request.form.get('email')
    password = request.form.get('password')
    zipcode = request.form.get('zipcode')
    level_id = request.form.get('level')
    checkboxes = request.form.getlist('category')

    # Query to see if users email and password are already in the db
    user = User.query.filter_by(email=email).first()

    # If they are in the db redirect to log in. If not save info to db
    if user:
        flash('User email already has an account')
        return redirect('/')
    else:
        new_user = User(fname=fname, lname=lname,
                        email=email, password=password,
                        zipcode=zipcode, level_id=level_id)
        flash('Welcome to WhistlerMTN')
        db.session.add(new_user)
        db.session.commit()
        session['logged_in'] = new_user.user_id

        for category_id in checkboxes:
            new_cat = CatUser(user_id=new_user.user_id, category_id=category_id)
            db.session.add(new_cat)
        db.session.commit()

        return redirect('/home')


@app.route('/logout')
def log_out_user():
    """Log out user"""

    session.clear()
    flash("Logged out")
    return redirect("/")


@app.route('/home')
def index():
    """Homepage, shows the best conditions for the day"""
    if session.get('logged_in'):
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

        # Creating a list of groomers whose id matches the choosen idfor the day, are groomed and are open.
        groomers = Skirun.query.filter(Skirun.category_id == 2 and Skirun.groomed == True and Skirun.status == True).all()
        groomed_runs = sample(groomers,  3)

        return render_template("homepage.html", weather_obj=weather_obj,
                               categories=category_objs, skiruns=skirun_objs,
                               total_snow=total_snow, weather=weather, daily_cat=daily_cat.title(),
                               run_objs=run_objs, groomed_runs=groomed_runs, pipe=pipe)
    else:
        flash("Please log in first!")
        return redirect("/")


@app.route('/lifts')
def show_lifts():
    """Lifts & skiruns associated with"""
    # If the user is in the session, show lifts.  If not, redirect to login
    if session.get('logged_in'):
        lifts = Lift.query.all()
        return render_template("lifts.html", lifts=lifts)
    else:
        flash("Please log in first!")
        return redirect("/")


@app.route('/profile')
def profile():
    """user's profile page"""
    # if user is in the session, show profile page.  If not, redirect home
    if session.get('logged_in'):
        userid = session['logged_in']
        user = User.query.filter(User.user_id == userid).first()

        # grab all of the users ratings
        ratings = Rating.query.filter(Rating.user_id == userid).first()

        # query all the lift and runs obj
        lifts = Lift.query.all()
        runs = Skirun.query.all()

        # get the skirun_id on the ski run table that equals the skirun id on the ratings table
        try:
            skirun_id = Skirun.query.filter(Skirun.skirun_id == ratings.skirun_id).first()
        except:
            skirun_id = None

        user_skill = user.skills.level.title()

        whistler = []
        blackcomb = []

        for lift in lifts:
            if lift.mountain == 'Whistler':
                whistler.append(lift)
            else:
                blackcomb.append(lift)
        mountains = [whistler, blackcomb]

        cat_obj = user.categories

        # match the categories to the open skiruns
        # user runs are lift object with skiruns attached
        user_runs = []
        groomers = []
        for run in runs:
            for cat in cat_obj:
                if cat.category_id == 2:
                    groomers.append(run)
                elif run.category_id == cat.category_id and run.status:
                    user_runs.append(run)
        groomers = sample(groomers,  3)
        [user_runs.append(groomer) for groomer in groomers]

        return render_template("profile.html", user=user, cat_obj=cat_obj,
                               user_runs=user_runs, user_skill=user_skill,
                               ratings=ratings, run=run, skirun_id=skirun_id,
                               mountains=mountains)

    else:
        flash("Please log in first!")
        return redirect("/")

@app.route("/favicon.ico")
def do_nothing():
    return "nope"


@app.route('/<name>')
def skiruns(name):
    """Display skirun Ratings."""
    rating = Rating.query.join(Skirun).filter(Skirun.name == name).first()

    # get the skirun object run
    skirun = Skirun.query.filter(Skirun.name == name).first()
    # user_id = session.get('logged_in')

    return render_template("skirun_ratings.html",
                           rating=rating, skirun=skirun)


@app.route('/add-rating.json', methods=['POST'])
def add_rating():
    """Adding Skirun rating."""

    skirun_id = request.form.get('skirun_id')
    new_score = int(request.form.get('rating'))
    user_id = session.get('logged_in')
    description = request.form.get('description')

    rating = Rating.query.filter(Rating.user_id == user_id,
                                 Rating.skirun_id == skirun_id).first()

    # if the user rating for the skirun is already in the system, update rating
    # if not, add a new rating to the skirun page
    if rating:
        rating.rating = new_score
        rating.comment = description
        db.session.commit()
    else:
        rating = Rating(skirun_id=skirun_id,
                            user_id=user_id,
                            rating=new_score,
                            comment=description)
        db.session.add(rating)
        db.session.commit()

    user_rating = rating.to_dict()

    return jsonify({'new_rating': user_rating})


@app.route('/get-ratings.json')
def get_ratings():
    """ get the ratings"""

    skirun_id = int(request.args.get('skirun_id'))
    skirun = Skirun.query.get(skirun_id)

    #  list of rating dictionaries
    ratings = [rating.to_dict() for rating in skirun.ratings]

    return jsonify({'ratings': ratings})


@app.route('/trailmap')
def show_trailmap():
    """ Display trailmap."""

    return render_template("trail_map.html")


@app.route('/myflare.json')
def create_my_flare():
    """Returns json data for cicle packing route"""

    master_dict = create_my_flare_json()
    return jsonify(master_dict)

##############################################################################

if __name__ == "__main__":
    # We have to set debug=True here, since it has to be True at the
    # point that we invoke the DebugToolbarExtension
    app.debug = True
    # make sure templates, etc. are not cached in debug mode
    app.jinja_env.auto_reload = app.debug

    connect_to_db(app)

    # Use the DebugToolbar
    # DebugToolbarExtension(app)
    # DEBUG_TB_INTERCEPT_REDIRECTS = False

    app.run(port=5000, host='0.0.0.0')
