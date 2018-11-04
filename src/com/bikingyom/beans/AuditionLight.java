package com.bikingyom.beans;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class AuditionLight implements Comparable<AuditionLight> {
	private File fichier;
	private LocalDate date;
    private LocalTime heure;
    private String lieu;
    
    public AuditionLight(File fichier, LocalDate date, LocalTime heure, String lieu) {
    	this.fichier = fichier;
        this.date = date;
        this.heure = heure;
        this.lieu = lieu;
    }

    public File getFichier() {
		return fichier;
	}

	public void setFichier(File fichier) {
		this.fichier = fichier;
	}

	public String getFormattedDate() {
    	return this.date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    
	public LocalDate getDate() {
		return date;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + ((heure == null) ? 0 : heure.hashCode());
		result = prime * result + ((lieu == null) ? 0 : lieu.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AuditionLight other = (AuditionLight) obj;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (heure == null) {
			if (other.heure != null)
				return false;
		} else if (!heure.equals(other.heure))
			return false;
		if (lieu == null) {
			if (other.lieu != null)
				return false;
		} else if (!lieu.equals(other.lieu))
			return false;
		return true;
	}

	@Override
	public int compareTo(AuditionLight autre) {
		if (this.date.compareTo(autre.getDate()) != 0)
			return this.date.compareTo(autre.getDate());
		else {
			if (this.heure.compareTo(autre.getHeure()) != 0)
				return this.heure.compareTo(autre.getHeure());
			else
				return this.lieu.compareTo(autre.lieu);
		}
	}
}
