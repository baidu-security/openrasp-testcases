package com.example.controller;

import com.ql.util.express.*;
import com.ql.util.express.config.QLExpressRunStrategy;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping(value = "/qlexpress")
public class QLExpressController {
    @RequestMapping(value = "/parse")
    public String parseJson(@RequestParam(name="expression", required=true) String expression) throws Exception {
        QLExpressRunStrategy.setForbidInvokeSecurityRiskMethods(true);
        ExpressRunner runner = new ExpressRunner();
        DefaultContext<String, Object> context = new DefaultContext<String, Object>();

        Object result = runner.execute(expression, context, null, false, true);
        return result.toString();
    }
}
