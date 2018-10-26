package com.bikingyom.dao;

import java.io.File;

import com.bikingyom.beans.Audition;

public interface DonneesAudition {
	public Audition charger(File fichier);
	public void enregistrer(Audition audition, File fichier);
}
