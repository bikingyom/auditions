<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Gestion des auditions - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-600">
	        	<div class="formulaire">
	        		<c:if test="${ erreur != null }">
	        			<p id="tempo"><c:out value="${ erreur }" /></p>
	        		</c:if>
    	    		<header><h1>Charger une audition</h1></header>
        			<section>
        				<p>Ici se trouvera la liste des auditions existantes</p>
        			</section>
	        		<footer>
    	    			<form action="auditiongestion" method="post">
							<input type="submit" name="bouton" value="Charger une audition" />
						</form>
					</footer>
	        	</div>
				<div class="formulaire">
					<form action="auditiongestion" method="post">
        				<header><h1>Nouvelle audition</h1></header>
        				<section>
        					<div class="bloc-tableau">
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="nom">Date&nbsp;: </label></div>
									<div class="elt-70pc"><input type="date" name="date" id="date" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="heure">Heure&nbsp;: </label></div>
									<div class="elt-70pc"><input type="time" name="heure" id="heure" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
	               					<div class="elt-30pc"><label for="lieu">Lieu&nbsp;: </label></div>
               						<div class="elt-70pc"><input type="text" name="lieu" id="lieu" required /></div>
								</div>
							</div>
        				</section>
        				<footer>
							<input type="submit" name="bouton" value="Créer une audition" />
						</footer>
					</form>
    	    	</div>
    	    </div>
		</div>   
	</body>
</html>