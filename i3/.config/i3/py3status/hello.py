# -*- coding: utf-8 -*-
"""
Example module that says 'Hello World!'

This demonstrates how to produce a simple custom module.
#import keyboard
#class Py3status:
#    format = 'Number {number}'
#    def hello(self):

#        full_text = self.py3.safe_format(self.format, {'number': counter})

#        if keyboard.wait('alt'):
#            counter = '1'
#        else:
#            counter = '0'
#        return {
#            'full_text': 'full_text',
#            'cached_until': self.py3.time_in()
#        }
"""
class Py3status:

    def hello(self):
        return {
            'full_text': 'Hello World!',
            'cached_until': self.py3.CACHE_FOREVER
        }

