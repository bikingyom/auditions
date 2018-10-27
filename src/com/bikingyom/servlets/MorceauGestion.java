package com.bikingyom.servlets;

import java.io.IOException;
import java.util.Iterator;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bikingyom.beans.*;

@WebServlet("/MorceauGestion")
public class MorceauGestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TreeSet<Eleve> elevesEdites;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MorceauGestion() {
		super();
		elevesEdites = new TreeSet<>();
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
			switch (action) {
			case "Supprimer un élève":
				if (request.getParameter("elevechoisi") == null || request.getParameter("elevechoisi").isEmpty())
				{
					request.setAttribute("erreur", "Choisissez d'abord un élève à supprimer, puis cliquez sur le bouton Supprimer.");
				}
				else {
					int hashCode = Integer.parseInt(request.getParameter("elevechoisi"));
					Iterator<Eleve> it1 = elevesEdites.iterator();
					Eleve e1;
					do {
						e1 = it1.next();
					} while (it1.hasNext() && e1.hashCode() != hashCode);
					if (e1.hashCode() == hashCode) {
						elevesEdites.remove(e1);
						session.setAttribute("elevesEdites", elevesEdites);
					}
				}
				break;

			case "Valider l'élève":
				if (request.getParameter("nom").isEmpty() || request.getParameter("nom") == null || request.getParameter("prenom").isEmpty() || request.getParameter("prenom") == null || request.getParameter("instrument").isEmpty() || request.getParameter("instrument") == null) {
					request.setAttribute("erreur", "Soit vous avez un vieux navigateur, soit vous êtes très fort. Dans les deux cas, vous n'avez pas entré toutes les informations concernant l'élève à ajouter, merci de recommencer");
				}
				else {
					Eleve nouvelEleve = new Eleve((String) request.getParameter("nom"), (String) request.getParameter("prenom"), (String) request.getParameter("instrument"));
					elevesEdites.add(nouvelEleve);
					session.setAttribute("elevesEdites", elevesEdites);
				}
				break;

			case "Valider la sélection":
				String[] hashCodes = request.getParameterValues("listeeleves");
				Audition audition = (Audition) session.getAttribute("audition");
				TreeSet<Eleve> tousEleves = audition.getTousEleves();
				for(String s : hashCodes) {
					Iterator<Eleve> it = tousEleves.iterator();
					Eleve e;
					do {
						e = it.next();
					} while (it.hasNext() && e.hashCode() != Integer.parseInt(s));
					elevesEdites.add(e);
				}
				session.setAttribute("elevesEdites", elevesEdites);
				break;

			case "Dupliquer les élèves":
				if (request.getParameter("morceauchoisi") == null || request.getParameter("morceauchoisi").isEmpty()) {
					request.setAttribute("erreur", "Vous n'avez pas choisi le morceau dont vous voulez dupliquer les élèves. Merci de recommencer, ou pas, c'est vous qui voyez...");
				}
				else {
					Morceau m = recupMorceau(session, request);
					elevesEdites.addAll(m.getEleves());
					session.setAttribute("elevesEdites", elevesEdites);
				}
				break;

			case "Ajouter un morceau":
				session.setAttribute("modif", false);
				morceauReset(session);
				break;

			case "Editer un morceau":
				session.setAttribute("modif", true);
				morceauReset(session);
				Morceau m = recupMorceau(session, request);
				session.setAttribute("morceautmp", m); // mémoriser les infos en cas d'appel à la page elevesgestion
				session.setAttribute("morceauEnCoursEdition", m); // identifier le morceau modifié dans son état initial pour le retrouver dans la liste des morceaux et pouvoir lui assigner les nouvelles valeurs
				elevesEdites.addAll(m.getEleves());
				session.setAttribute("elevesEdites", elevesEdites);
				break;

			default:
				break;
			}

			this.getServletContext().getRequestDispatcher("/WEB-INF/morceaugestion.jsp").forward(request, response);
		}
	}

	private Morceau recupMorceau(HttpSession session, HttpServletRequest request) {
		int hashCode = Integer.parseInt(request.getParameter("morceauchoisi"));
		Audition audition = (Audition) session.getAttribute("audition");
		Iterator<Morceau> it = audition.getMorceaux().iterator();
		Morceau m;
		do {
			m = it.next();
		} while (it.hasNext() && m.hashCode() != hashCode);
		return m;
	}

	private void morceauReset(HttpSession session) {
		elevesEdites.clear();
		session.removeAttribute("elevesEdites");
		session.removeAttribute("morceautmp");
	}

}
