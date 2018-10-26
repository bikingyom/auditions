package com.bikingyom.servlets;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bikingyom.beans.*;
import com.bikingyom.dao.*;

@WebServlet("/AuditionGestion")
public class AuditionGestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
    private Audition audition;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuditionGestion() {
        super();
        audition = new Audition();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("audition", audition);
		this.getServletContext().getRequestDispatcher("/WEB-INF/auditiongestion.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("bouton");
		HttpSession session = request.getSession();
		DonneesAudition donnees = new DonneesAuditionXML();

		switch (action) {
		case "Charger une audition":
	        audition = donnees.charger(new File(this.getServletContext().getRealPath("") + "/audition.xml"));
	        break;
		
		case "Créer une audition":
			audition.setDate(LocalDate.parse(request.getParameter("date"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
			audition.setHeure(LocalTime.parse(request.getParameter("heure"), DateTimeFormatter.ofPattern("HH:mm")));
			audition.setLieu(request.getParameter("lieu"));
			audition.setMorceaux(new ArrayList<Morceau>());
			break;
			
		case "Valider le morceau":
			if ((boolean) session.getAttribute("modif")) {
				Morceau morceauTmp = (Morceau) session.getAttribute("morceauEnCoursEdition");
				audition.getMorceaux().set(audition.getMorceaux().indexOf(morceauTmp), recupNouveauMorceau(request));
			}
			else
				audition.addMorceau(recupNouveauMorceau(request));
			
	        donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
			break;
			
		case "Supprimer un morceau":
			int hashCode = Integer.parseInt(request.getParameter("morceauchoisi"));
			Audition audition = (Audition) session.getAttribute("audition");
			Iterator<Morceau> it = audition.getMorceaux().iterator();
			Morceau m;
			do {
				m = it.next();
			} while (it.hasNext() && m.hashCode() != hashCode);
			audition.removeMorceau(m);
	        donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
			break;
			
		default:
			break;
			
		}
		
        session.setAttribute("audition", audition);
        this.getServletContext().getRequestDispatcher("/WEB-INF/auditiongestion.jsp").forward(request, response);
	}
	
	private Morceau recupNouveauMorceau(HttpServletRequest request) {
		String dureeString = "PT" + request.getParameter("minutes") + "M" + request.getParameter("secondes") + "S";
		HttpSession session = request.getSession();
        TreeSet<Eleve> listeEleves = (TreeSet<Eleve>) ((TreeSet<Eleve>)session.getAttribute("elevesEdites")).clone();
		return new Morceau(request.getParameter("titre"), request.getParameter("compositeur"), request.getParameter("arrangeur"), Duration.parse(dureeString), Integer.parseInt(request.getParameter("chaises")), Integer.parseInt(request.getParameter("pupitres")), request.getParameter("materiel"), listeEleves);
	}

}
