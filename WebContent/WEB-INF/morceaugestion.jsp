<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Edition d'un morceau - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script type="text/javascript">
			function lancer(elt) {
				if(elt.value == 'Valider le morceau')
					document.forms[0].action='auditiongestion';
				else if(elt.value == 'Supprimer un �l�ve')
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
	        				<p class="warning"><c:out value="${ erreuredition }" /></p>
	        			</c:if>
						<form action="" onsubmit="" method="post" id="formmorceau">
							<div class="bloc-tableau">
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="titre">Titre de l'oeuvre&nbsp;: </label></div>
									<div class="elt-70pc"><input type="text" name="titre" id="titre" required value="${ morceautmp.titre }" autofocus /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="compositeur">Compositeur&nbsp;: </label></div>
									<div class="elt-70pc"><input type="text" name="compositeur" id="compositeur" value="${ morceautmp.compositeur }" /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="minutes">Dur�e&nbsp;: </label></div>
									<div class="elt-70pc">
										<input type="number" name="minutes" id="minutes" value="${ morceautmp.duree == null ? 0 : morceautmp.duree.toMinutes() }" min="0" max="59" step="1"> min
										<!-- <input type="number" name="secondes" id="secondes" value="${ morceautmp.duree == null ? 0 : morceautmp.duree.getSeconds()%60 }" min="0" max="59" step="15"> s -->
										<c:set var="sec" value="${ morceautmp.duree == null ? 0 : morceautmp.duree.getSeconds()%60 }" scope="page" />
										<c:set var="sel" value="selected='selected'" scope="page" />
										<select name="secondes" id="secondes">
											<option value="0" ${ sec == 0 ? sel : '' }>00</option>
											<option value="15" ${ sec == 15 ? sel : '' }>15</option>
											<option value="30" ${ sec == 30 ? sel : '' }>30</option>
											<option value="45" ${ sec == 45 ? sel : '' }>45</option>
										</select> s
										<c:remove var="sec" scope="page" />
										<c:remove var="sel" scope="page" />
									</div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="chaises">Chaises&nbsp;: </label></div>
									<div class="elt-70pc"><input type="number" name="chaises" id="chaises" min="0" max="100" step="1" value="${ morceautmp.chaises == null ? 0 : morceautmp.chaises }"></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="pupitres">Pupitres&nbsp;: </label></div>
									<div class="elt-70pc"><input type="number" name="pupitres" id="pupitres" min="0" max="100" step="1" value="${ morceautmp.pupitres == null ? 0 : morceautmp.pupitres }"></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="titre">Mat�riel&nbsp;: </label></div>
									<div class="elt-70pc"><input type="text" name="materiel" id="materiel" value="${ morceautmp.materiel }" /></div>
								</div>
							</div>
    	           		
                		</form>
					</section>
					<footer>
						<form action="auditiongestion" method="post" id="formannuler"></form>
						<input type="submit" name="bouton" value="Valider le morceau" ${ empty elevesEdites || elevesEdites == null ? 'disabled' : '' } onclick="lancer(this)" form="formmorceau" />
						<input type="submit" name="bouton" value="Annuler" form="formannuler"/>
					</footer>
				</div>
				
				<div class="formulaire">
					<header><h1>�l�ves concern�s par ce morceau</h1></header>
					<section>
						<c:if test="${ empty elevesEdites || elevesEdites == null }">
							<p>Il n'y a pas encore d'�l�ve pour ce morceau, veuillez en ajouter.</p>
						</c:if>
						<c:if test="${ !(empty elevesEdites || elevesEdites == null) }">
    		  				<div class="bloc-tableau">
       							<c:forEach var="eleve" items="${ elevesEdites }">
       								<c:set var="hashLocal" value="${ eleve.hashCode() }" scope="page" />
        								<div class="bloc-morceau">
	        								<label class="radiolabel" for="${ hashLocal }"></label>
   	    									<input type="radio" name="elevechoisi" value="${ hashLocal }" id="${ hashLocal }" form="formmorceau" />
   	    									<div class="contenu-morceau">
   	    										<div class="elt-40pc"><c:out value="${ eleve.nom }" /></div>
   	    										<div class="elt-30pc"><c:out value="${ eleve.prenom }" /></div>
   	    										<div class="elt-30pc"><c:out value="${ eleve.instrument }" /></div>
   	    									</div>
   	    								</div>
	       						</c:forEach>
    	    				</div>
        				</c:if>
        				<c:if test="${ !(empty erreur || erreur == null) }">
	        				<p><c:out value="${ erreur }" /></p>
	        			</c:if>
    	    		</section>
        			<footer>
        				<input type="submit" name="bouton" value="Ajouter un �l�ve" onclick="lancer(this)" form="formmorceau" title="Ajouter un ou plusieurs �l�ves � ce morceau" />
        				<input type="submit" name="bouton" value="Supprimer un �l�ve" onclick="lancer(this)" form="formmorceau" ${ elevesEdites.size() == 0 || elevesEdites == null ? 'class="display-none"' : '' } title="Supprimer l'�l�ve s�lectionn�" />
					</footer>
				</div>
			</div>
		</div> 
	</body>
</html>