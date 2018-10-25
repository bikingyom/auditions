<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Edition d'un élève - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/stylesmorceau.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-600">
				<c:if test="${ audition.morceaux.size() != 0 && audition.morceaux != null }">
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
        					<footer><input type="submit" name="bouton" value="Valider la sélection"> <a href="morceaugestion" class="bouton">Annuler</a></footer>
    	   				</form>
	       			</div>
       				<div class="formulaire">
       					<form action="morceaugestion" method="post">
        					<header><h1>Dupliquer les élèves d'un autre morceau</h1></header>
        					<section>
	    	    				<table>
   			    					<c:forEach var="morceau" items="${ audition.morceaux }">
	   									<tr>
											<td class="column-radio">
												<input type="radio" name="morceauchoisi" value="${ morceau.hashCode() }" id="${ morceau.hashCode() }">
											</td>
    										<td>
    											<label for="${ morceau.hashCode() }">
    												<c:out value="${ morceau.titre }" /> de <c:out value="${ morceau.compositeur }" />
    											</label>
    										</td>
   											<td>
   												<label for="${ morceau.hashCode() }">
   													<c:forEach var="eleve" items="${ morceau.eleves }">
   														<c:out value="${ eleve.prenom }"/> <c:out value="${ eleve.nom }" /><br />
   													</c:forEach>
   												</label>
   											</td>
   										</tr>
       								</c:forEach>
	        					</table>
       						</section>
       						<footer><input type="submit" name="bouton" value="Dupliquer les élèves"> <a href="morceaugestion" class="bouton">Annuler</a></footer>
   						</form>
	       			</div>
      			</c:if>
        		
				<div class="formulaire">
        	        <form action="morceaugestion" method="post">
						<header><h1>Saisie d'un nouvel élève</h1></header>
						<section>
                			<table>
            		   				<tr><td><label for="nom">Nom : </label><input type="text" name="nom" id="nom" required /></td></tr>
        	       				<tr><td><label for="prenom">Prénom : </label><input type="text" name="prenom" id="prenom" required /></td></tr>
    	           				<tr><td>
	               					<label for="instrument">Instrument : </label>
               						<select name="instrument" id="instrument">
               							<option value="Flute">Flute</option>
               							<option value="Clarinette">Clarinette</option>
               							<option value="Saxophone">Saxophone</option>
               							<option value="Basson">Basson</option>
            	   						<option value="Piano">Piano</option>
        	       						<option value="Guitare">Guitare</option>
    	           						<option value="Trompette">Trompette</option>
	               						<option value="Trombone">Trombone</option>
               							<option value="Tuba">Tuba</option>
               							<option value="Chant">Chant</option>
               							<option value="Percussions">Percussions</option>
               							<option value="Batterie">Batterie</option>
               							<option value="Accordéon">Accordéon</option>
            	   					</select>
        	       				</td></tr>
    	            		</table>
						</section>
						<footer><input type="submit" name="bouton" value="Valider l'élève"> <a href="morceaugestion" class="bouton">Annuler</a></footer>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>