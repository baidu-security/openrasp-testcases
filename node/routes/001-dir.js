"use strict";

var express = require('express');
var router = express.Router();
var fs = require("fs")
var caseInfo = require('../helpers/case_index')['001']

function readdir(dirName) {
  return fs.readdirSync(dirName)
}

function routeHandler(req, res, next) {
  var baseUrl = 'http://' + req.get('host') + req.baseUrl
  
  var params = {
    'name': caseInfo['name'],
    'linuxUrl': baseUrl + '/%2fproc',
	  'windowsUrl': baseUrl + '/C:',
    'linuxJsonUrl': 'curl -d \'{"dir":"/proc"}\' -H "Content-Type: application/json" \'' + baseUrl + "'",
  }

  try {
    if (req.method == 'POST') {
      params.dirContent = readdir(req.body.dir)
    }
    else if (req.params.dir !== undefined) {
      params.dirContent = readdir(req.params.dir)
    }
  }
  catch(e) {
    params.dirContent = 'Read dir failed! ' + e.message
  }

  res.render(caseInfo['path'], params);
}

router.get('/:dir?', routeHandler);
router.post('/', routeHandler);

module.exports = router;
