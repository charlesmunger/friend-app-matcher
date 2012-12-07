import unittest
from funkload.FunkLoadTestCase import FunkLoadTestCase

class FriendAppMatcherTest(FunkLoadTestCase):
    def setUp(self):
        self.server_url = self.conf_get('main', 'url')
        self.login_url = self.server_url + self.conf_get('main', 'sign_in')
        self.email = self.conf_get('main', 'email')
        self.password = self.conf_get('main', 'password')

    def test_home_page(self):
        section = 'test_home_page'
        self.test_get_target(section,
                             self.conf_get(section, 'description'))

    def test_topapps(self):
        section = 'test_topapps'
        self.test_get_target(section,
                             self.conf_get(section, 'description'))

    def test_recommendations(self):
        section = 'test_recommendations'
        self.test_get_target(section,
                             self.conf_get(section, 'description'))

    def test_friends(self):
        section = 'test_friends'
        self.test_get_target(section,
                             self.conf_get(section, 'description'))

    def test_like_app(self):
        self.assertTrue(True)

    def login(self):
        res = self.get(self.login_url, description='Login page')
        self.assertEqual(res.code, 200)

        res = self.post(self.login_url,
                        params={ 'user[email]': self.email,
                                 'user[password]': self.password,
                                 'commit': 'Login' },
                        description='Login to home page')
        self.assertEqual(res.code, 200)

    def test_get_target(self, section, description):
        self.login()
        target = self.server_url + self.conf_get(section, 'target')

        res = self.get(target, description=description)
        self.assertEqual(res.code, 200)

if __name__ in ('main', '__main__'):
    unittest.main()
