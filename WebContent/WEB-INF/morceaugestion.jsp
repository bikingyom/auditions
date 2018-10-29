<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Edition d'un morceau - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/stylesmorceau.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script type="text/javascript">
			function lancer(elt) {
				if(elt.value == 'Valider le morceau')
					document.forms[0].action='auditiongestion';
				else if(elt.value == 'Supprimer un élève')
					document.forms[0].action='morceaugestion';
				else
					document.forms[0].action='elevesgestion';
			}
  		</script>
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-600">
				<div class="formulaire">
					<header><h1>Edition d'un morceau</h1></header>
					<section>
						<c:if test="${ !(empty erreuredition || erreuredition == null) }">
							<img style="float:left; margin: 15px;" src="images/warning.png" />
	        				<p><c:out value="${ erreuredition }" /></p>
	        			</c:if>
						<form action="" onsubmit="" method="post" id="formmorceau">
    	           			<table>
        	        			<tr><td><label for="titre">Titre de l'oeuvre : </label> <input type="text" name="titre" id="titre" required value="${ morceautmp.titre }" autofocus /></td></tr>
            	    			<tr><td><label for="compositeur">Compositeur : </label> <input type="text" name="compositeur" id="compositeur" value="${ morceautmp.compositeur }" /></td></tr>
                				<tr><td><label for="minutes">Durée : </label> <input type="number" name="minutes" id="minutes" value="${ morceautmp.duree == null ? 0 : morceautmp.duree.toMinutes() }" min="0" max="59" step="1"> min <input type="number" name="secondes" id="secondes" value="${ morceautmp.duree == null ? 0 : morceautmp.duree.getSeconds()%60 }" min="0" max="59" step="15"> s</td></tr>
                				<tr><td><label for="chaises">Chaises : </label> <input type="number" name="chaises" id="chaises" min="0" max="50" step="1" value="${ morceautmp.chaises == null ? 0 : morceautmp.chaises }"></td></tr>
                				<tr><td><label for="pupitres">Pupitres : </label> <input type="number" name="pupitres" id="pupitres" min="0" max="50" step="1" value="${ morceautmp.pupitres == null ? 0 : morceautmp.pupitres }"></td></tr>
                				<tr><td><label for="titre">Matériel : </label> <input type="text" name="materiel" id="materiel" value="${ morceautmp.materiel }" /></td></tr>
	                		
	                		</table>
                		</form>
					</section>
					<footer>
						<form action="auditiongestion" method="post" id="formannuler"></form>
						<input type="submit" name="bouton" value="Valider le morceau" ${ empty elevesEdites || elevesEdites == null ? 'disabled' : '' } onclick="lancer(this)" form="formmorceau" />
						<input type="submit" name="bouton" value="Annuler" form="formannuler"/>
					</footer>
				</div>
				
				<div class="formulaire">
					<header><h1>Élèves concernés par ce morceau</h1></header>
					<section>
						<c:if test="${ empty elevesEdites || elevesEdites == null }">
							<p>Il n'y a pas encore d'élève pour ce morceau, veuillez en ajouter.</p>
						</c:if>
						<c:if test="${ !(empty elevesEdites || elevesEdites == null) }">
    		  				<table>
       							<c:set var="i" value="0" scope="page" />
       							<c:forEach var="eleve" items="${ elevesEdites }">
       								<c:set var="i" value="${ i+1 }" scope="page" />
       								<tr>
       									<td class="column-radio">
											<input type="radio" name="elevechoisi" value="${ eleve.hashCode() }" id="${ eleve.hashCode() }" form="formmorceau" />
										</td>
       									<td class="column1"><c:out value="${ eleve.nom }" /></td>
       									<td class="column2"><c:out value="${ eleve.prenom }" /></td>
       									<td class="column3"><c:out value="${ eleve.instrument }" /></td>
       								</tr> 
	       						</c:forEach>
	       						<c:remove var="i" scope="page" />
    	    				</table>
        				</c:if>
        				<c:if test="${ !(empty erreur || erreur == null) }">
	        				<p><c:out value="${ erreur }" /></p>
	        			</c:if>
    	    		</section>
        			<footer>
        				<input type="submit" name="bouton" value="Ajouter un élève" onclick="lancer(this)" form="formmorceau" title="Ajouter un ou plusieurs élèves à ce morceau" />
        				<input type="submit" name="bouton" value="Supprimer un élève" onclick="lancer(this)" form="formmorceau" ${ elevesEdites.size() == 0 || elevesEdites == null ? 'class="display-none"' : '' } title="Supprimer l'élève sélectionné" />
					</footer>
				</div>
			</div>
		</div> 
	</body>
</html>