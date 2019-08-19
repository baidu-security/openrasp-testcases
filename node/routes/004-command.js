"use strict";

var express = require('express');
var router = express.Router();
var fs = require("fs")
var cases = require('../helpers/case_index')


function readFile(dirName) {
  return fs.readFileSync(dirName)
}

function routeHandler(req, res, next) {
  var baseUrl = 'http://' + req.get('host') + req.baseUrl
  
  var params = {
    'name': cases[0]['name'],
    'linuxUrl': baseUrl + '/%2fetc%2fhosts',
    'linuxUrl': baseUrl + '/file:%2f%2f%2fetc%2fhosts',
	  'windowsUrl': baseUrl + 'C:\\Windows\\System32\\drivers\\etc\\hosts',
	  'windowsUrl': baseUrl + 'C:\\Windows\\System32\\drivers\\etc\\hosts'
  }

  try {
    if (req.params.dir !== undefined) {
      params.dirContent = readFile(req.params.dir)
    }
  }
  catch(e) {
    params.dirContent = 'Read dir failed! ' + e.message
  }

  res.render('002-file-read', params);
}

router.get('/:file?', routeHandler);
router.post('/', routeHandler);

module.exports = router;
