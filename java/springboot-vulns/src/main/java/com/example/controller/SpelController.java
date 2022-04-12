package com.example.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.expression.*;
import org.springframework.expression.spel.standard.*;
import org.springframework.expression.spel.support.*;

@RestController
@RequestMapping(value = "/spel")
public class SpelController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="expression", required=true) String name) {
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(name);
        EvaluationContext context = new StandardEvaluationContext();
        context.setVariable("end", "!");
        
        return expression.getValue(context).toString();
    }
}