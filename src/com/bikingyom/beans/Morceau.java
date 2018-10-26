package com.bikingyom.beans;

import java.time.Duration;
import java.util.TreeSet;

public class Morceau {
	private String titre, compositeur, arrangeur;
    private Duration duree;
    private int chaises, pupitres;
    private String materiel;
    private TreeSet<Eleve> eleves;
    private boolean suppr;

    @Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((arrangeur == null) ? 0 : arrangeur.hashCode());
		result = prime * result + chaises;
		result = prime * result + ((compositeur == null) ? 0 : compositeur.hashCode());
		result = prime * result + ((duree == null) ? 0 : duree.hashCode());
		result = prime * result + ((eleves == null) ? 0 : eleves.hashCode());
		result = prime * result + ((materiel == null) ? 0 : materiel.hashCode());
		result = prime * result + pupitres;
		result = prime * result + ((titre == null) ? 0 : titre.hashCode());
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
		Morceau other = (Morceau) obj;
		if (arrangeur == null) {
			if (other.arrangeur != null)
				return false;
		} else if (!arrangeur.equals(other.arrangeur))
			return false;
		if (chaises != other.chaises)
			return false;
		if (compositeur == null) {
			if (other.compositeur != null)
				return false;
		} else if (!compositeur.equals(other.compositeur))
			return false;
		if (duree == null) {
			if (other.duree != null)
				return false;
		} else if (!duree.equals(other.duree))
			return false;
		if (eleves == null) {
			if (other.eleves != null)
				return false;
		} else if (!eleves.equals(other.eleves))
			return false;
		if (materiel == null) {
			if (other.materiel != null)
				return false;
		} else if (!materiel.equals(other.materiel))
			return false;
		if (pupitres != other.pupitres)
			return false;
		if (titre == null) {
			if (other.titre != null)
				return false;
		} else if (!titre.equals(other.titre))
			return false;
		return true;
	}

	public Morceau(String titre, String compositeur, String arrangeur, Duration duree, int chaises, int pupitres, String materiel, TreeSet<Eleve> eleves) {
		this.titre = titre;
        this.compositeur = compositeur;
        this.arrangeur = arrangeur;
        this.duree = duree;
        this.chaises = chaises;
        this.pupitres = pupitres;
        this.materiel = materiel;
        this.eleves = eleves;
        this.suppr = false;
    }

    public boolean isSuppr() {
		return suppr;
	}

	public void setSuppr(boolean suppr) {
		this.suppr = suppr;
	}

	public String getMateriel() {
		return materiel;
	}

	public void setMateriel(String materiel) {
		this.materiel = materiel;
	}

	public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getCompositeur() {
        return compositeur;
    }

    public void setCompositeur(String compositeur) {
        this.compositeur = compositeur;
    }

    public String getArrangeur() {
        return arrangeur;
    }

    public void setArrangeur(String arrangeur) {
        this.arrangeur = arrangeur;
    }

    public Duration getDuree() {
        return duree;
    }

    public void setDuree(Duration duree) {
        this.duree = duree;
    }

    public int getChaises() {
        return chaises;
    }

    public void setChaises(int chaises) {
        this.chaises = chaises;
    }

    public int getPupitres() {
        return pupitres;
    }

    public void setPupitres(int pupitres) {
        this.pupitres = pupitres;
    }

    public TreeSet<Eleve> getEleves() {
        return eleves;
    }

    public void setEleves(TreeSet<Eleve> eleves) {
        this.eleves = eleves;
    }

    public void addEleve(Eleve eleve) {
        this.eleves.add(eleve);
    }

	/*@Override
	public int compareTo(Morceau m) {
		if (this.hashCode() == m.hashCode())
			return 0;
		else {
			return this.numero.compareTo(m.numero);
		}
	}*/
}
