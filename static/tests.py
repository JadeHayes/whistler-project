import unittest
import server.py
from model import db, example_data, connect_to_db

 class FlaskTests(unittest.TestCase):
    """Tests for Whistler MTN site."""

    def setUp(self):
        self.client = app.test_client()
        app.config['TESTING'] = True

    def test_login(self):
        result = self.client.get("/")
        self.assertIn("Log-in", result.data)

    def test_login(self):
        result = self.client.get("/home")
        self.assertIn("Daily Snowfall Accumulation", result.data)

    def test_lifts(self):
        result = self.client.get("/lifts")
        self.assertIn("7th Heaven Express", result.data)

    def test_rsvp(self):
        result = self.client.post("/register",
                                  data={"name": "Jade",
                                        "email": "jade.e.hayes@gmail.com"},
                                  follow_redirects=True)


class PartyTestsDatabase(unittest.TestCase):
    """Flask tests that use the database."""

    def setUp(self):
        """Stuff to do before every test."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        # Connect to test database (uncomment when testing database)
        # connect_to_db(app, "postgresql:///testdb")

        # Create tables and add sample data (uncomment when testing database)
        # db.create_all()
        # example_data()

    def tearDown(self):
        """Do at end of every test."""

        # (uncomment when testing database)
        # db.session.close()
        # db.drop_all()

    def test_games(self):
        #FIXME: test that the games page displays the game from example_data()
        print "FIXME"


if __name__ == "__main__":
    unittest.main()
