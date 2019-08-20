"use strict";

var express = require('express');
var router = express.Router();
var execSync = require('child_process').execSync;
var caseInfo = require('../helpers/case_index')['004']

function commandExec(cmd) {
  return execSync(cmd)
}

function routeHandler(req, res, next) {
  var baseUrl = 'http://' + req.get('host') + req.baseUrl
  
  var params = {
    'name': caseInfo['name'],
    'linuxUrl': baseUrl + '?cmd=cat+/etc/resolv.conf',
	  'windowsUrl': baseUrl + '?cmd=cmd+/c+whoami'
  }

  try {
    if (req.query.cmd !== undefined) {
      params.result = commandExec(req.query.cmd)
    }
  }
  catch(e) {
    params.result = e.message
  }

  res.render(caseInfo['path'], params);
}

router.get('/', routeHandler);

module.exports = router;
