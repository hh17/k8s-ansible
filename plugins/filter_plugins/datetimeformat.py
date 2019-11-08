#!/usr/bin/env python
#-*- coding:utf-8 -*-
 

from ansible import errors
import time
def date_to_format(value):
    try:
        return  time.strftime(value,time.localtime())
    except Exception, e:
        raise errors.AnsibleFilterError("to date format error: %s" %str(e))

class FilterModule(object):
    def filters(self):
        return {
                'date_to_format': date_to_format
                }
