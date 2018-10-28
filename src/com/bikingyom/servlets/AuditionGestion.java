package com.bikingyom.servlets;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
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
		response.sendRedirect("accueil?err=accesdirect");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession(false) == null) {
			response.sendRedirect("accueil?err=sessionexp");
		}
		else {
			String action = request.getParameter("bouton");
			HttpSession session = request.getSession(false);
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
				if ((boolean) session.getAttribute("modif")) { // s'il s'agit d'une modification
					Morceau morceauTmp = (Morceau) session.getAttribute("morceauEnCoursEdition");
					int index = audition.getMorceaux().indexOf(morceauTmp);
					if (index != -1) // pour éviter le cas où la page est rechargée et la requête renvoyée
						audition.getMorceaux().set(index, recupNouveauMorceau(request));
				}
				else // s'il s'agit d'un nouveau morceau
					audition.addMorceau(recupNouveauMorceau(request));

				donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
				request.setAttribute("displaySaveOk", true);
				break;
				
			case "Changer l'ordre":
				request.setAttribute("ordre", true);
				request.setAttribute("hashChoisi", Integer.parseInt(request.getParameter("morceauchoisi")));
				break;
				
			case "haut":
				Morceau m3 = recupMorceauChoisi(request);
				if (m3 != null) {
					int ind = audition.getMorceaux().indexOf(m3);
					if (ind > 0) {
						Collections.swap(audition.getMorceaux(), ind, ind-1);
					}
					request.setAttribute("hashChoisi", Integer.parseInt(request.getParameter("morceauchoisi")));
					request.setAttribute("isauve", ind-2);
				}
				request.setAttribute("ordre", true);
				break;
				
			case "bas":
				Morceau m4 = recupMorceauChoisi(request);
				if (m4 != null) {
					int ind = audition.getMorceaux().indexOf(m4);
					if (ind < audition.getMorceaux().size()-1) {
						Collections.swap(audition.getMorceaux(), ind, ind+1);
					}
					request.setAttribute("hashChoisi", Integer.parseInt(request.getParameter("morceauchoisi")));
					request.setAttribute("isauve", ind);
				}
				request.setAttribute("ordre", true);
				break;
				
			case "Valider l'ordre":
				donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
				request.setAttribute("displaySaveOk", true);
				request.setAttribute("ordre", false);
				break;
				
			case "Supprimer un morceau":
				int hashCode = Integer.parseInt(request.getParameter("morceauchoisi"));
				Iterator<Morceau> it = audition.getMorceaux().iterator();
				Morceau m;
				do {
					m = it.next();
				} while (it.hasNext() && m.hashCode() != hashCode);
				if (m.hashCode() == hashCode) {
					audition.removeMorceau(m);
					donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
					request.setAttribute("displaySaveOk", true);
				}
				break;
				
			case "Restaurer":
				String[] hashCodes = request.getParameterValues("morceauxchoisis");
				ArrayList<Morceau> morceauxSuppr = audition.getMorceauxSuppr();
				if(hashCodes != null && hashCodes.length != 0 && morceauxSuppr != null) {
					for(String s : hashCodes) {
						Iterator<Morceau> it2 = morceauxSuppr.iterator();
						Morceau m2;
						do {
							m2 = it2.next();
						} while (it2.hasNext() && m2.hashCode() != Integer.parseInt(s));
						audition.addMorceau(m2);
						audition.removeMorceauSuppr(m2);
						donnees.enregistrer(audition, new File(this.getServletContext().getRealPath("") + "/audition.xml"));
						request.setAttribute("displaySaveOk", true);
					}
				}
				break;

			default:
				break;

			}
			if(!action.equals("Annuler"))
				session.setAttribute("audition", audition);
			this.getServletContext().getRequestDispatcher("/WEB-INF/auditiongestion.jsp").forward(request, response);
		}
	}

	private Morceau recupNouveauMorceau(HttpServletRequest request) {
		String dureeString = "PT" + request.getParameter("minutes") + "M" + request.getParameter("secondes") + "S";
		HttpSession session = request.getSession(false);
		@SuppressWarnings("unchecked")
		TreeSet<Eleve> listeEleves = (TreeSet<Eleve>) ((TreeSet<Eleve>)session.getAttribute("elevesEdites")).clone();
		return new Morceau(request.getParameter("titre"), request.getParameter("compositeur"), request.getParameter("arrangeur"), Duration.parse(dureeString), Integer.parseInt(request.getParameter("chaises")), Integer.parseInt(request.getParameter("pupitres")), request.getParameter("materiel"), listeEleves);
	}
	
	private Morceau recupMorceauChoisi(HttpServletRequest request) {
		int hashCode = Integer.parseInt(request.getParameter("morceauchoisi"));
		Iterator<Morceau> it = audition.getMorceaux().iterator();
		Morceau m;
		do {
			m = it.next();
		} while (it.hasNext() && m.hashCode() != hashCode);
		if (m.hashCode() == hashCode)
			return m;
		else
			return null;
	}

}
