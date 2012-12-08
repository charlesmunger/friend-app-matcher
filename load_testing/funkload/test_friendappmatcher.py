import unittest
from random import randint
from funkload.FunkLoadTestCase import FunkLoadTestCase
from funkload.utils import Data

class FriendAppMatcherTest(FunkLoadTestCase):
    def setUp(self):
        self.server_url = self.conf_get('main', 'url')
        self.login_url = self.server_url + self.conf_get('main', 'sign_in')
        self.user = self.conf_get('main', 'user')
        self.email = self.conf_get('main', 'email')
        self.num_users = self.conf_get('main', 'num_users')
        self.num_apps = self.conf_get('main', 'num_apps')
        self.password = self.conf_get('main', 'password')

    def test_home_page(self):
        self.login()

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
	section = 'test_like_app'
        target = self.server_url + self.conf_get(section, 'target')
        target.replace('id', str(randint(1, int(self.num_apps))))
        self.test_put_target(section,
                             self.conf_get(section, 'description'),
                             target)

    def login(self):
        res = self.get(self.login_url, description='Login page')
        self.assertEqual(res.code, 200)

        email = (self.user + str(randint(1, int(self.num_users))) + 
                 '@' + self.email)
        res = self.post(self.login_url,
                        params={ 'user[email]': email,
                                 'user[password]': self.password,
                                 'commit': 'Login' },
                        description='Login to home page')
        self.assertEqual(res.code, 200)

    def test_get_target(self, section, description):
        self.login()
        target = self.server_url + self.conf_get(section, 'target')

        res = self.get(target, description=description)
        self.assertEqual(res.code, 200)

    def test_put_target(self, section, description, target):
        self.login()

        res = self.put(target,  params = Data('text', 'fake'), \
            description=description)
        self.assertEqual(res.code, 200)


if __name__ in ('main', '__main__'):
    unittest.main()
