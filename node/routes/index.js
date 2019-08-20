"use strict";

var express = require('express');
var router = express.Router();
var cases = require('../helpers/case_index')


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {'cases': JSON.stringify(Object.values(cases))});
});

module.exports = router;
