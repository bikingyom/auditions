package com.bikingyom.beans;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.TreeSet;

public class Audition {
    private LocalDate date;
    private LocalTime heure;
    private String lieu;
    private TreeSet<Morceau> morceaux;

    public Audition() {
    	this.date = LocalDate.parse("01/01/1901", DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    	this.heure = LocalTime.parse("00:00", DateTimeFormatter.ofPattern("HH:mm"));
    	this.lieu = "";
    	this.morceaux = new TreeSet<>();
    }
    
    public Audition(LocalDate date, LocalTime heure, String lieu, TreeSet<Morceau> morceaux) {
        this.date = date;
        this.heure = heure;
        this.lieu = lieu;
        this.morceaux = morceaux;
    }
    
    public LocalDate getDate() {
		return date;
	}
    
    public String getFormattedDate() {
    	return this.date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

	public void setDate(LocalDate date) {
		this.date = date;
	}

	public LocalTime getHeure() {
		return heure;
	}

	public void setHeure(LocalTime heure) {
		this.heure = heure;
	}

	public String getLieu() {
		return lieu;
	}

	public void setLieu(String lieu) {
		this.lieu = lieu;
	}

	public TreeSet<Morceau> getMorceaux() {
		return morceaux;
	}

	public void setMorceaux(TreeSet<Morceau> morceaux) {
		this.morceaux = morceaux;
	}

    public void addMorceau(Morceau morceau, Integer numero) {
    	morceau.setNumero(numero);
        this.morceaux.add(morceau);
    }
    
    public void removeMorceau(Morceau morceau) {
    	this.morceaux.remove(morceau);
    }
    
    public TreeSet<Eleve> getTousEleves() {
    	TreeSet<Eleve> eleves = new TreeSet<Eleve>();
    	if (morceaux != null && !morceaux.isEmpty()) {
    		for (Morceau morceau : morceaux) {
        		for (Eleve eleve : morceau.getEleves()) {
        			eleves.add(eleve);
        		}
        	}	
    	}
    	return eleves;
    }
}
