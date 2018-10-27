package com.bikingyom.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.TreeSet;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import com.bikingyom.beans.Audition;
import com.bikingyom.beans.Eleve;
import com.bikingyom.beans.Morceau;

public class DonneesAuditionXML implements DonneesAudition {
	public DonneesAuditionXML() {
		
	}
	
	@Override
	public Audition charger(File fichier) {
		Audition audition = null;
		try {
			SAXBuilder builder = new SAXBuilder();
		    Document document = builder.build(fichier);
		    Element auditionXML = document.getRootElement();
		    
		    LocalDate nouvelleDate = LocalDate.parse(auditionXML.getChildText("date"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		    LocalTime nouvelleHeure = LocalTime.parse(auditionXML.getChildText("heure"), DateTimeFormatter.ofPattern("HH:mm"));
		    String nouveauLieu = auditionXML.getChildText("lieu");
		    
		    ArrayList<Morceau> nouveauxMorceaux = new ArrayList<>();
		    List<Element> morceauxXML = auditionXML.getChildren("morceau");
		    ListIterator<Element> it1 = morceauxXML.listIterator();
		    
		    while (it1.hasNext()) {
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
		    	nouveauxMorceaux.add(new Morceau(nouveauTitre, nouveauCompositeur, nouvelArrangeur, nouvelleDuree, nouvellesChaises, nouveauxPupitres, nouveauMateriel, nouveauxEleves));
		    	
		    }
		    audition = new Audition(nouvelleDate, nouvelleHeure, nouveauLieu, nouveauxMorceaux);
		      
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return audition;
	}
	
	@Override
	public void enregistrer(Audition audition, File fichier) {
		Element racine = new Element("audition");
	    Document document = new Document(racine);
	    racine.addContent(new Element("date").setText(audition.getFormattedDate()));
	    racine.addContent(new Element("heure").setText(audition.getHeure().toString()));
	    racine.addContent(new Element("lieu").setText(audition.getLieu()));
	    Iterator<Morceau> it1 = audition.getMorceaux().iterator();
	    while (it1.hasNext()) {
	    	Morceau m = it1.next();
	    	Element morceauXML = new Element("morceau");
	    	racine.addContent(morceauXML);
	    	morceauXML.addContent(new Element("titre").setText(m.getTitre()));
	    	morceauXML.addContent(new Element("compositeur").setText(m.getCompositeur()));
	    	morceauXML.addContent(new Element("arrangeur").setText(m.getArrangeur()));
	    	morceauXML.addContent(new Element("duree").setText(m.getDuree().toString()));
	    	morceauXML.addContent(new Element("chaises").setText(Integer.toString(m.getChaises())));
	    	morceauXML.addContent(new Element("pupitres").setText(Integer.toString(m.getPupitres())));
	    	morceauXML.addContent(new Element("materiel").setText(m.getMateriel()));
	    	Iterator<Eleve> it2 = m.getEleves().iterator();
	    	while (it2.hasNext()) {
	    		Eleve e = it2.next();
	    		Element eleveXML = new Element ("eleve");
	    		morceauXML.addContent(eleveXML);
	    		eleveXML.addContent(new Element("nom").setText(e.getNom()));
	    		eleveXML.addContent(new Element("prenom").setText(e.getPrenom()));
	    		eleveXML.addContent(new Element("instrument").setText(e.getInstrument()));
	    	}
	    }

	    Format format = Format.getPrettyFormat();
	    format.setEncoding("UTF-8");
	    XMLOutputter sortie = new XMLOutputter(format);

	    FileOutputStream fos = null;
	    try {
	    	fos = new FileOutputStream(fichier); 
	    	OutputStreamWriter out = new OutputStreamWriter(fos, "UTF-8"); 
	    	sortie.output(document, out);
	    } catch (IOException e) {
	    	e.printStackTrace();
	    } finally {
	    	if (fos != null) {
	    		try {
	    			fos.close();
	    		} catch (IOException e) {
	    			e.printStackTrace();
	    		}
	    	}
	    }
	}
}
