from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

################################################################################
# Defining our db


class Skirun(db.Model):
    """information about each ski run"""

    # Lets SQL alchemy know there is a table named 'skiruns'
    __tablename__ = "skiruns"

    # Lets SQL alchemy know which columns to add
    skirun_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    lift_id = db.Column(db.Integer, db.ForeignKey('lifts.lift_id'))
    category_id = db.Column(db.Integer, db.ForeignKey('categories.category_id'))
    # level_id = db.Column(db.Integer, db.ForeignKey('levels.level_id'))
    groomed = db.Column(db.Boolean)
    status = db.Column(db.Boolean)
    name = db.Column(db.String(200))
    level = db.Column(db.String(200))
    # min_snow = db.Column(db.Integer, nullable=True)
    # max_snow = db.Column(db.Integer, nullable=True)

   # Defining the relationship between the skirun class and the lift table
    lift = db.relationship("Lift")

   # Defining the relationship between the skirun class and the category table
    category = db.relationship("Category")

    # Defining the relationship between the skirun class and the level table
    # level = db.relationship("Level")

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
    loading_pt_id = db.Column(db.Integer, db.ForeignKey('loading_pts.loading_pt_id'), nullable=True)

   # Defining the realtionship between the lift class and the skirun table
    skiruns = db.relationship("Skirun")

    # Defining the relationship between the lift class and the loading table
    # loading_pt = db.relationship("LoadingPt")

    def __repr__(self):
        """ Provide helpful information about each lift"""

        return "<name={} lift_id={}>".format(self.name, self.lift_id)

class LoadingPt(db.Model):
    """information about the differnt loading points on the mountain """
    # Lets SQL alchemy know there is a table named 'levels'
    __tablename__ = "loading_pts"

    # Lets SQL alchemy know which columns to add
    loading_pt_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    location = db.Column(db.String(150))

    # Defining the relationship between the lift class and the loading_pts table
    lifts = db.relationship("Lift")

    # Connect to skiruns through lifts
    skiruns = db.relationship("Skirun", secondary="lifts")

    def __repr__(self):
        """ Provide helpful information about each loading location"""

        return "<location={} loading_pt_id={}>".format(self.location, self.loading_pt_id)


# class Level(db.Model):
#     """information about the differnt levels of difficulty """

#     # Lets SQL alchemy know there is a table named 'levels'
#     __tablename__ = "levels"

#     # Lets SQL alchemy know which columns to add
#     level_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
#     level = db.Column(db.String(150))

#     # Defining the relationship between the skirun class and the level table
#     skiruns = db.relationship("Skirun")

#     # Defining the relationship between the lift class and the level table
    # lifts = db.relationship("Lift", secondary="skiruns")

#     def __repr__(self):
#         """ Provide helpful information about each level of difficulty"""

#         return "<level={} level_id={}>".format(self.lift_id, self.level)


class Category(db.Model):
    """information about the differnt riding categories """

    # Lets SQL alchemy know there is a table named 'levels'
    __tablename__ = "categories"

    # Lets SQL alchemy know which columns to add
    category_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    cat = db.Column(db.String(150))

    # Defining the relationship between the skirun class and the category table
    skiruns = db.relationship("Skirun")

    def __repr__(self):
        """ Provide helpful information about each category"""

        return "<category={} cat_id={}>".format(self.cat, self.cat_id)



class Weather(db.Model):
    """information about weather on Blackcomb & Whistler mountain """
    def __repr__(self):
        """ Provide helpful information about each loading location"""

        return "<location={} newsnow={}>".format(self.location, self.new_snow)

    # Lets SQL alchemy know which columns to add
    weather_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    location = db.Column(db.String(150))
    wind = db.Column(db.String(150))
    new_snow = db.Column(db.Integer)
    snow_forcast = db.Column(db.String(150))

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
