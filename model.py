from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

################################################################################
# Defining our db

# given a skirun, we can get skirun.lifts (this is because we call it lifts on the Skirun object)
# from skirun.lifts, then we have list of all lifts
# iterate through skirun.lifts, for each lift, you can do lift.loading_pt.location (loading_pt is from definition on Lift object)


class Skirun(db.Model):
    """information about each ski run"""

    # Lets SQL alchemy know there is a table named 'skiruns'
    __tablename__ = "skiruns"

    # Lets SQL alchemy know which columns to add
    skirun_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    category_id = db.Column(db.Integer, db.ForeignKey('categories.category_id'))
    groomed = db.Column(db.Boolean)
    status = db.Column(db.Boolean)
    name = db.Column(db.String(200))
    level = db.Column(db.String(200))

   # Defining the relationship between the skirun class and the lift table
    lifts = db.relationship("Lift", secondary="skiruns_lifts")

   # Defining the relationship between the skirun class and the category table
    category = db.relationship("Category")

    def __repr__(self):
        """ Provide helpful information about each skirun"""

        return "< Skirun name={} skirun_id={}>".format(self.name, self.skirun_id)


class Lift(db.Model):
    """information about each lift """

    # Lets SQL alchemy know there is a table named 'lifts'
    __tablename__ = "lifts"

    # Lets SQL alchemy know which columns to add
    lift_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    name = db.Column(db.String(150))
    status = db.Column(db.String(150))
    mountain = db.Column(db.String(200))

   # Defining the realtionship between the lift class and the skirun table
    skiruns = db.relationship("Skirun", secondary="skiruns_lifts")

    def __repr__(self):
        """ Provide helpful information about each lift"""

        return "<name={} lift_id={}>".format(self.name, self.lift_id)


class SkirunLift(db.Model):
    __tablename__ = 'skiruns_lifts'

    skirun_lift_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    lift_id = db.Column(db.Integer,
                        db.ForeignKey('lifts.lift_id'),
                        nullable=False)
    skirun_id = db.Column(db.Integer,
                          db.ForeignKey('skiruns.skirun_id'),
                          nullable=False)


class Category(db.Model):
    """information about the differnt riding categories """

    # Lets SQL alchemy know there is a table named 'levels'
    __tablename__ = "categories"

    # Lets SQL alchemy know which columns to add
    category_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    cat = db.Column(db.String(150))

    # Defining the relationship between the skirun class and the category table
    skiruns = db.relationship("Skirun")

    # Defining the relationship between the user class and the category table
    users = db.relationship("User", secondary='catusers')

    def __repr__(self):
        """ Provide helpful information about each category"""

        return "<category={} cat_id={}>".format(self.cat, self.category_id)


class User(db.Model):
    """User of WhistlerMTN."""

    # Lets SQL alchemy know there is a table named 'Users'
    __tablename__ = "users"

    #Creating the table
    # Lets SQL alchemy know this is an integer pk
    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    fname = db.Column(db.String(200), nullable=False)
    lname = db.Column(db.String(200), nullable=False)
    email = db.Column(db.String(200), nullable=False)
    zipcode = db.Column(db.String(200))
    password = db.Column(db.String(64), nullable=True)
    # category_id = db.Column(db.Integer,
    #                         db.ForeignKey('categories.category_id'))
    level_id = db.Column(db.Integer,
                         db.ForeignKey('skill_levels.level_id'))

    # Defining the relationship with skilllevel class
    skills = db.relationship('SkillLevel')

    # Defining the realtionship with category class
    categories = db.relationship('Category', secondary='catusers')

    def __repr__(self):
        """ Provide helpful information about this class"""

        return "<User user_id={} email={}>".format(self.user_id, self.email)


# FIXME USER <--> CATEGORIES
class CatUser(db.Model):
    __tablename__ = 'catusers'

    # An associative table connecting users to categories
    catuser_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    category_id = db.Column(db.Integer,
                            db.ForeignKey('categories.category_id'),
                            nullable=False)
    user_id = db.Column(db.Integer,
                        db.ForeignKey('users.user_id'),
                        nullable=False)


class SkillLevel(db.Model):
    """Green, Blue, Black"""

    # Lets SQL alchemy know there is a table named 'Users'
    __tablename__ = "skill_levels"

    #Creating the table
    # Lets SQL alchemy know this is an integer primary key that auto increments
    level_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    level = db.Column(db.String(20), nullable=False)

    # Defining the relationship between the user class and the skilllevel table
    users = db.relationship("User")

    def __repr__(self):
        """ Provide helpful information about this class"""

        return "<ID: skill_id={} level={}>".format(self.level_id, self.level)


class Rating(db.Model):
    """Ratings information for each skirun"""

    # Lets SQL alchemy know there is a table named 'Ratings'
    __tablename__ = "ratings"

    #Creating the table
    # Lets SQL alchemy know this is an integer primary key that auto increments
    rating_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    rating = db.Column(db.Integer, nullable=False)
    comment = db.Column(db.String(250))
    # define skirun relationship to ratings through skirun id
    skirun_id = db.Column(db.Integer,
                          db.ForeignKey('skiruns.skirun_id'),
                          nullable=False)

    #Define user_id as a FK to the users table passed in as "table.column_name"
    user_id = db.Column(db.Integer,
                        db.ForeignKey('users.user_id'),
                        nullable=False)

    # Defining the relationship between the user class and the ratings table
    user = db.relationship("User",
                           backref=db.backref("ratings"))

    # Defining a relationship to the Skirun class from the ratings table
    skirun = db.relationship("Skirun",
                             backref=db.backref("ratings"))

    def __repr__(self):
        """ Provide helpful information about this class"""

        return "<User rating_id={} for skirun_id={}>".format(self.rating_id, self.skirun_id)


class Weather(db.Model):
    """information about weather on Blackcomb & Whistler mountain """

    # Lets SQL alchemy know which columns to add
    weather_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    daily_snowfall = db.Column(db.Integer)
    overnight_snowfall = db.Column(db.String(150))
    forcast_icon = db.Column(db.String(150))
    wind_forcast = db.Column(db.String(150))
    snow_forcast = db.Column(db.String(150))

    def __repr__(self):
        """ Provide helpful information about each loading location"""

        return "<dailysnow={} snowforcast={}>".format(self.daily_snowfall, self.snow_forcast)

##############################################################################
# Helper functions


def connect_to_db(app):
    """Connect the database to our Flask app."""

    # Configure to use our PstgreSQL database
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///whistler'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.app = app
    db.init_app(app)


if __name__ == "__main__":
    # As a convenience, so we can run this module interactively,
    # and work with the database directly.

    from flask import Flask
    app = Flask(__name__)
    connect_to_db(app)
    print "Connected to DB."
    db.create_all()
