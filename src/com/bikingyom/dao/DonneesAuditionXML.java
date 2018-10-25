package com.bikingyom.dao;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.ListIterator;
import java.util.TreeSet;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

import com.bikingyom.beans.Audition;
import com.bikingyom.beans.Eleve;
import com.bikingyom.beans.Morceau;

public class DonneesAuditionXML implements DonneesAudition {
	private Audition audition;
	
	public DonneesAuditionXML(File fichier) {
		try {
			SAXBuilder builder = new SAXBuilder();
		    Document document = builder.build(fichier);
		    Element auditionXML = document.getRootElement();
		    
		    LocalDate nouvelleDate = LocalDate.parse(auditionXML.getChildText("date"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		    LocalTime nouvelleHeure = LocalTime.parse(auditionXML.getChildText("heure"), DateTimeFormatter.ofPattern("HH:mm"));
		    String nouveauLieu = auditionXML.getChildText("lieu");
		    
		    TreeSet<Morceau> nouveauxMorceaux = new TreeSet<>();
		    List<Element> morceauxXML = auditionXML.getChildren("morceau");
		    ListIterator<Element> it1 = morceauxXML.listIterator();
		    
		    Integer i = 0;
		    while (it1.hasNext()) {
		    	i++;
		    	Element morceauXML = (Element) it1.next();
		    	String nouveauTitre = morceauXML.getChildText("titre");
		    	String nouveauCompositeur = morceauXML.getChildText("compositeur");
		    	String nouvelArrangeur = morceauXML.getChildText("arrangeur");
		    	Duration nouvelleDuree = Duration.parse(morceauXML.getChildText("duree"));
		    	int nouvellesChaises = Integer.parseInt(morceauXML.getChildText("chaises"));
		    	int nouveauxPupitres = Integer.parseInt(morceauXML.getChildText("pupitres"));
		    	String nouveauMateriel = morceauXML.getChildText("materiel");

		    	TreeSet<Eleve> nouveauxEleves = new TreeSet<>();
		    	List<Element> elevesXML = morceauXML.getChildren("eleve");
		    	ListIterator<Element> it2 = elevesXML.listIterator();
		    	
		    	String nouveauNom = null, nouveauPrenom = null, nouvelInstrument = null;
		    	while (it2.hasNext()) {
		    		Element eleveXML = (Element) it2.next();
		    		nouveauPrenom = eleveXML.getChildText("prenom");
		    		nouveauNom = eleveXML.getChildText("nom");
		    		nouvelInstrument = eleveXML.getChildText("instrument");
		    		nouveauxEleves.add(new Eleve(nouveauNom, nouveauPrenom, nouvelInstrument));
		    	}
		    	nouveauxMorceaux.add(new Morceau(i, nouveauTitre, nouveauCompositeur, nouvelArrangeur, nouvelleDuree, nouvellesChaises, nouveauxPupitres, nouveauMateriel, nouveauxEleves));
		    	
		    }
		    audition = new Audition(nouvelleDate, nouvelleHeure, nouveauLieu, nouveauxMorceaux);
		      
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		}
	}

	@Override
	public Audition getAudition() {
		return this.audition;
	}

}
