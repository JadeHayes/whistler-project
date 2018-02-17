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

    def test_home(self):
        result = self.client.get("/home")
        self.assertIn("Daily Snowfall Accumulation", result.data)

    def test_lifts(self):
        result = self.client.get("/lifts")
        self.assertIn("7th Heaven Express", result.data)

    def test_rsvp(self):
        result = self.client.post("/register",
                                  data={"fname": "Jaye",
                                        "lname": "hayze"
                                        "email": "jadeEhayes@gmail.com",
                                        "password": "123",
                                        "zipcode": 94610},
                                  follow_redirects=True)


class WhistlerTestsDatabase(unittest.TestCase):
    """Flask tests that use the database."""

    def setUp(self):
        """Stuff to do before every test."""

        self.client = app.test_client()
        app.config['TESTING'] = True

        # Connect to test database (uncomment when testing database)
        connect_to_db(app, "postgresql:///whistler")

        # Create tables and add sample data (uncomment when testing database)
        db.create_all()
        example_data()

    def tearDown(self):
        """Do at end of every test."""

        # (uncomment when testing database)
        db.session.close()
        db.drop_all()


if __name__ == "__main__":
    unittest.main()
