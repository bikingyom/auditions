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
import com.bikingyom.beans.AuditionLight;
import com.bikingyom.beans.Eleve;
import com.bikingyom.beans.Morceau;

public class DonneesAuditionsXML {
	private TreeSet<AuditionLight> auditions;
	
	public DonneesAuditionsXML() {
		auditions = new TreeSet<>();
	}
	
	public TreeSet<AuditionLight> charger(File[] files) {
		try {
			for(File file : files) {
				SAXBuilder builder = new SAXBuilder();
			    Document document = builder.build(file);
			    Element auditionXML = document.getRootElement();
		    	LocalDate nouvelleDate = LocalDate.parse(auditionXML.getChildText("date"), DateTimeFormatter.ofPattern("dd/MM/yyyy"));
		    	LocalTime nouvelleHeure = LocalTime.parse(auditionXML.getChildText("heure"), DateTimeFormatter.ofPattern("HH:mm"));
		    	String nouveauLieu = auditionXML.getChildText("lieu");
		    	auditions.add(new AuditionLight(file, nouvelleDate, nouvelleHeure, nouveauLieu));
			    }
		} catch (JDOMException e) {
			e.printStackTrace();
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return auditions;
	}
		
}
