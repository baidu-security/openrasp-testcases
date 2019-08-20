"use strict";

var express = require('express');
var router = express.Router();
var fs = require("fs");
var caseInfo = require('../helpers/case_index')['005'];

function writeFile(filePath, data) {
  fs.writeFileSync("./public/upload/" + filePath, data);
  return "/upload/" + filePath
}

function routeHandler(req, res, next) {
  var baseUrl = 'http://' + req.get('host') + req.baseUrl;
  
  var params = {
    'name': caseInfo['name'],
    'legalUrl': baseUrl + '?name=user.txt&data=123',
    'illegalUrl': baseUrl + '?name=user.pug&data=test',
  }

  try {
    if (req.query.name !== undefined) {
      var data = req.query.data | "empty";
      var path = writeFile(req.query.name, data);
      params.result = path;
    }
  }
  catch(e) {
    params.error = e.message;
  }

  res.render(caseInfo['path'], params);
}

router.get('/', routeHandler);
router.post('/', routeHandler);

module.exports = router;
