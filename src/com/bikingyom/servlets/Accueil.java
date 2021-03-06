package com.bikingyom.servlets;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bikingyom.beans.AuditionLight;
import com.bikingyom.dao.DonneesAudition;
import com.bikingyom.dao.DonneesAuditionXML;
import com.bikingyom.dao.DonneesAuditionsXML;

/**
 * Servlet implementation class Accueil
 */
@WebServlet("/Accueil")
public class Accueil extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TreeSet<AuditionLight> auditions;
	private int maxID;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Accueil() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession(true);
		String err = request.getParameter("err");
		if (err == null)
			err = "vide";
		switch (err) {
		case "accesdirect":
			request.setAttribute("erreur", "Il est impossible d'accéder directement à la page demandée. Vous avez donc été redirigé à la page d'accueil.");
			break;
			
		case "sessionexp":
			request.setAttribute("erreur", "Votre session a expiré. Vous avez donc été redirigé à la page d'accueil.");
			break;
			
		default:
			break;
		}
		
		File fl = new File(this.getServletContext().getRealPath(""));
		FilenameFilter fnf = new FilenameFilter()
	    { 
			@Override
			public boolean accept(File dir, String name)
			{
				if(name.endsWith(".xml"))
					return true;
				else
					return false;
	        }
	    };

	    File[] files = fl.listFiles(fnf);
	    request.setAttribute("files", files);
      
		DonneesAuditionsXML donnees = new DonneesAuditionsXML();
		auditions = donnees.charger(files);
		request.setAttribute("auditions", auditions);
		this.getServletContext().getRequestDispatcher("/WEB-INF/accueil.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
