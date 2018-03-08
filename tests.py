from unittest import TestCase
import unittest
from flask import Flask, session
from server import app
from model import db, connect_to_db
import yelp
import os

YELP_API_KEY= os.environ.get("YELP_API_KEY")

class FlaskTests(TestCase):
    """Tests for Whistler MTN site."""

    def setUp(self):
        app.config['SECRET_KEY'] = 'ABC'
        self.client = app.test_client()
        app.config['TESTING'] = True


        # add sample data
        os.system("psql testdb < test_db.sql > /dev/null")

        connect_to_db(app, "postgresql:///testdb")

        with self.client as c:
            with c.session_transaction() as sess:
                sess['logged_in'] = 1

    def tearDown(self):
        """Do at end of every test."""

        connect_to_db(app, "postgresql:///testdb")
        db.session.close()
        db.drop_all()

    def test_login(self):
        result = self.client.get("/")
        self.assertEqual(result.status_code, 200)
        self.assertIn("Welcome", result.data)

    def test_loggedin(self):
        result = self.client.post("/login",
                                  data={"email": "JT123@gmail.com",
                                      "password":123},
                                  follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("Logged in", result.data)

    def test_password_fail(self):
        result = self.client.post("/login",
                                  data={"email": "dolor@Maurisvel.org",
                                        "password": 876},
                                  follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("failed", result.data)

    def test_failed(self):
        result = self.client.post("/login",
                                  data={"email": "ja@gmail.com",
                                      "password": 1243},
                                  follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("login", result.data)

    def test_registration_route(self):
        result = self.client.get("/register")
        self.assertIn("Register", result.data)

    def test_login_form(self):
        result = self.client.post('/login',
                                  data={"email": "imnewhere@gmail.com",
                                        "password":123},
                                  follow_redirects=True)
        self.assertIn("new friend", result.data)


    def test_register_input(self):
        result = self.client.post("/register",
                                  data={"fname": "Johnny",
                                        "lname": "Tsunami",
                                        "zipcode": 94610,
                                        "level_id": 2,
                                        "email": "test478@email.com",
                                        "password": "123"},
                                  follow_redirects=True)

        self.assertIn("A quick MTN report", result.data)

    def test_home(self):
        result = self.client.get("/home", follow_redirects=True)
        self.assertIn("Daily Snowfall Accumulation", result.data)

    def twitter_widget(self):
        result = self.client.get("/home", follow_redirects=True)
        self.assertIn("Tweets from Whistler Blackcomb", result.data)

    def test_lifts(self):
        result = self.client.get("/lifts", follow_redirects=True)
        self.assertIn("Lifts & Skiruns", result.data)

    def test_profile(self):
        result = self.client.get("/profile", follow_redirects=True)
        self.assertIn("Welcome Back", result.data)

    def test_twilio(self):
        result = self.client.get("/twilio", follow_redirects=True)
        self.assertIn("Favorites list sent!", result.data)

    def test_skiruns(self):
        result = self.client.get("/Nintendo%20Terrain%20Park,%20sz.%20M,L", follow_redirects=True)
        self.assertIn("Blackcomb", result.data)

    def test_lift_page(self):
        result = self.client.get("/Whistler%20Village%20Gondola", follow_redirects=True)
        self.assertIn("Skiruns", result.data)

    def test_flare_json(self):
        result = self.client.get("/myflare.json", follow_redirects=True)
        self.assertIn("Gondola", result.data)

    def test_logout(self):
        result = self.client.get("/logout", follow_redirects=True)
        self.assertIn("out", result.data)

    def test_current_user(self):
        result = self.client.post("/register",
                                 data={"fname": "Johnny",
                                       "lname": "Tsunami",
                                       "zipcode": 94610,
                                       "level_id": 2,
                                       "email": "JT123@gmail.com",
                                       "password": "123"},
                                 follow_redirects=True)
        self.assertIn("already", result.data)

    def test_failed_login(self):
        result = self.client.post("/login",
                                  data={"email": "jag@gmail.com",
                                        "password": 1243},
                                  follow_redirects=True)
        self.assertEqual(result.status_code, 200)
        self.assertIn("please register here", result.data)


    def test_categories(self):
        result = self.client.post("/register",
                                 data={"fname": "Johnny",
                                       "lname": "Tsunami",
                                       "zipcode": 94610,
                                       "level_id": 2,
                                       "email": "JT12365@gmail.com",
                                       "password": "123",
                                       "checkboxes": 1},
                                 follow_redirects=True)
        self.assertIn("MTN", result.data)

    def add_rating(self):
        result = self.client.post("/add-rating.json",
                                 data={"skirun_id": 1,
                                       "new_score": 5,
                                       "user_id": 105,
                                       "description": "best run ever"},
                                 follow_redirects=True)
        self.assertIn("new_rating", result.data)

    def test_json_wD3(self):
        result = self.client.get("/whistler.json", follow_redirects=True)
        self.assertIn("Crabapple", result.data)

    def test_json_bD3(self):
        result = self.client.get("/myflare.json", follow_redirects=True)
        self.assertIn("Home Run", result.data)

    def test_livecam(self):
        result = self.client.get("/livecam", follow_redirects=True)
        self.assertIn("Olympic", result.data)

    def test_lifts_search(self):
        result = self.client.get("/lifts_search.json", follow_redirects=True)
        self.assertIn("Wizard Express", result.data)

    def test_skirun_search(self):
        result = self.client.get("/skiruns_search.json", follow_redirects=True)
        self.assertIn("7th Avenue", result.data)

    def test_map(self):
        result = self.client.get("/trailmap", follow_redirects=True)
        self.assertIn("zoom", result.data)

class SessionRedirects(TestCase):
    """Tests for Whistler MTN site."""

    def setUp(self):
        app.config['SECRET_KEY'] = 'ABC'
        self.client = app.test_client()
        app.config['TESTING'] = True


        # add sample data
        os.system("psql testdb < test_db.sql > /dev/null")

        connect_to_db(app, "postgresql:///testdb")

    def tearDown(self):
        """Do at end of every test."""

        connect_to_db(app, "postgresql:///testdb")
        db.session.close()
        db.drop_all()

    def test_home_fail(self):
        result = self.client.get("/home", follow_redirects=True)
        self.assertIn("Please log in first!", result.data)

    def test_lift_fail(self):
        result = self.client.get("/lifts", follow_redirects=True)
        self.assertIn("login", result.data)

    def test_profile_fail(self):
        result = self.client.get("/profile", follow_redirects=True)
        self.assertIn("login", result.data)

#################################################################################

if __name__ == "__main__":
    unittest.main()
