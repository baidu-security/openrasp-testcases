package person;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class FastJsonServlet extends HttpServlet 
{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        PrintWriter out = response.getWriter();
        
      	// ldap://127.0.0.1:1389/ExportObject
        String sourceURL = request.getParameter("url");
        if (sourceURL != null)
        {
        	out.println("Execute POC");
        	try {
                Poc.run(sourceURL);
            } catch (Exception e) {
                e.printStackTrace(out);
            }

            out.println("Poc DONE");
        }
        else
        {
        	out.println("Missing required paraemter: url");
        }
    }

}
