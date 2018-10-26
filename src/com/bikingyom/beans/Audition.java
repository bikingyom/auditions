package com.bikingyom.beans;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.TreeSet;

public class Audition {
    private LocalDate date;
    private LocalTime heure;
    private String lieu;
    private ArrayList<Morceau> morceaux, morceauxSuppr;

    public Audition() {
    	this.date = LocalDate.parse("01/01/1901", DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    	this.heure = LocalTime.parse("00:00", DateTimeFormatter.ofPattern("HH:mm"));
    	this.lieu = "";
    	this.morceaux = new ArrayList<>();
    	this.morceauxSuppr = new ArrayList<>();
    }
    
    public Audition(LocalDate date, LocalTime heure, String lieu, ArrayList<Morceau> morceaux) {
        this.date = date;
        this.heure = heure;
        this.lieu = lieu;
        this.morceaux = morceaux;
        this.morceauxSuppr = new ArrayList<>();
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

	public ArrayList<Morceau> getMorceaux() {
		return morceaux;
	}

	public void setMorceaux(ArrayList<Morceau> morceaux) {
		this.morceaux = morceaux;
	}

    public void addMorceau(Morceau morceau) {
    	if (!this.morceaux.contains(morceau))
    		this.morceaux.add(morceau);
    }
    
    public void removeMorceau(Morceau morceau) {
    	this.morceauxSuppr.add(morceau);
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

	public void swapMorceaux(int i, int j) {
		Collections.swap(this.morceaux, i, j);
	}
}
