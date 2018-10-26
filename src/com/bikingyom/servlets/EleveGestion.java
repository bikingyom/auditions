package com.bikingyom.servlets;

import java.io.IOException;
import java.time.Duration;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bikingyom.beans.*;

@WebServlet("/EleveGestion")
public class EleveGestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EleveGestion() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.getServletContext().getRequestDispatcher("/WEB-INF/elevesgestion.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Audition audition = (Audition) session.getAttribute("audition");
		TreeSet<Eleve> tousEleves = audition.getTousEleves();
		request.setAttribute("tousEleves", tousEleves);
		String dureeString = "PT" + request.getParameter("minutes") + "M" + request.getParameter("secondes") + "S";
		Morceau morceautmp = new Morceau(request.getParameter("titre"), request.getParameter("compositeur"), request.getParameter("arrangeur"), Duration.parse(dureeString), Integer.parseInt(request.getParameter("chaises")), Integer.parseInt(request.getParameter("pupitres")), request.getParameter("materiel"), null);
		session.setAttribute("morceautmp", morceautmp);
        this.getServletContext().getRequestDispatcher("/WEB-INF/elevesgestion.jsp").forward(request, response);
	}

}
