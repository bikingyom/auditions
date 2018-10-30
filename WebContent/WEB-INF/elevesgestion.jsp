<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Edition d'un élève - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<form action="morceaugestion" method="post" id="formannuler"></form>
		<div class="limiter">
			<div class="conteneur-600">
				<c:if test="${ !(empty audition.morceaux || audition.morceaux == null) }">
	       			<div class="formulaire">
       					<form action="morceaugestion" method="post">
       						<header><h1>Sélection parmi les élèves déjà inscrits à l'audition</h1></header>
       						<section>
       							<p>Vous pouvez choisir un ou plusieurs élèves dans la liste ci-dessous :</p>
    	   						<p>
	       							<select name="listeeleves" size="${ tousEleves.size() < 5 ? tousEleves.size() : 5 }" class="eleves" multiple required>
       									<c:forEach var="eleve" items="${ tousEleves }">
       										<option value="${ eleve.hashCode() }"><c:out value="${ eleve.prenom }" /> <c:out value="${ eleve.nom }" /></option>
		       							</c:forEach>
    	    						</select>
    	    					</p>
	       					</section>
        					<footer><input type="submit" name="bouton" value="Valider la sélection"> <input type="submit" name="bouton" value="Annuler" form="formannuler"/></footer>
    	   				</form>
	       			</div>
       				<div class="formulaire">
       					<form action="morceaugestion" method="post">
        					<header><h1>Dupliquer les élèves d'un autre morceau</h1></header>
        					<section>
        						<div class="bloc-tableau">
        							<c:forEach var="morceau" items="${ audition.morceaux }">
	        							<c:set var="hashLocal" value="${ morceau.hashCode() }" scope="page" />
    	    							<div class="bloc-morceau">
	    	    							<label class="radiolabel" for="${ hashLocal }"></label>
    										<input type="radio" name="morceauchoisi" value="${ hashLocal }" id="${ hashLocal }" } />
    										<div class="contenu-morceau">
    											<div class="elt-60pc"><c:out value="${ morceau.titre }" /> <c:out value="${ empty morceau.compositeur || morceau.compositeur == null ? '' : '-' }" /> <c:out value="${ morceau.compositeur }" /></div>
    											<div class="elt-40pc">
    												<c:forEach var="eleve" items="${ morceau.eleves }">
   														<c:out value="${ eleve.prenom }"/> <c:out value="${ eleve.nom }" /><br />
   													</c:forEach>
    											</div>
	    									</div>
   										</div>
   									</c:forEach>
   								</div>
       						</section>
       						<footer><input type="submit" name="bouton" value="Dupliquer les élèves"> <input type="submit" name="bouton" value="Annuler" form="formannuler"/></footer>
   						</form>
	       			</div>
      			</c:if>
        		
				<div class="formulaire">
        	        <form action="morceaugestion" method="post">
						<header><h1>Saisie d'un nouvel élève</h1></header>
						<section>
							<div class="bloc-tableau">
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="nom">Nom&nbsp;: </label></div>
									<div class="elt-70pc"><input type="text" name="nom" id="nom" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="prenom">Prénom&nbsp;: </label></div>
									<div class="elt-70pc"><input type="text" name="prenom" id="prenom" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
	               					<div class="elt-30pc"><label for="instrument">Instrument&nbsp;: </label></div>
               						<div class="elt-70pc">
               							<select name="instrument" id="instrument">
	               							<option value="Flute">Flute</option>
    	           							<option value="Hautbois">Hautbois</option>
        	       							<option value="Clarinette">Clarinette</option>
            	   							<option value="Saxophone">Saxophone</option>
               								<option value="Basson">Basson</option>
            	   							<option value="Piano">Piano</option>
        	       							<option value="Guitare">Guitare</option>
        	       							<option value="Violon">Violon</option>
        	       							<option value="Alto">Alto</option>
        	       							<option value="Violoncelle">Violoncelle</option>
        	       							<option value="Contrebasse">Contrebasse</option>
	    	           						<option value="Trompette">Trompette</option>
		               						<option value="Trombone">Trombone</option>
        	       							<option value="Tuba">Tuba</option>
            	   							<option value="Chant">Chant</option>
               								<option value="Percussions">Percussions</option>
               								<option value="Batterie">Batterie</option>
               								<option value="Accordéon">Accordéon</option>
            	   						</select>
            	   					</div>
								</div>
							</div>
						</section>
						<footer>
							<input type="submit" name="bouton" value="Valider l'élève"> <input type="submit" name="bouton" value="Annuler" form="formannuler"/>
						</footer>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>