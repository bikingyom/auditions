<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Modifier la date, l'heure et le lieu d'une audition - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-600">
				<div class="formulaire">
					<form action="auditiongestion" method="post" id="formannuler"></form>
					<form action="auditiongestion" method="post">
        				<header><h1>Modifier l'audition</h1></header>
        				<section>
        					<div class="bloc-tableau">
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="nom">Date&nbsp;: </label></div>
									<div class="elt-70pc"><input type="date" name="date" id="date" value="${ audition.date }" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
									<div class="elt-30pc"><label for="heure">Heure&nbsp;: </label></div>
									<div class="elt-70pc"><input type="time" name="heure" id="heure" value="${ audition.heure }" required /></div>
								</div>
								<div class="bloc-morceau contenu-morceau">
	               					<div class="elt-30pc"><label for="lieu">Lieu&nbsp;: </label></div>
               						<div class="elt-70pc"><input type="text" name="lieu" id="lieu" value="${ audition.lieu }" required /></div>
								</div>
							</div>
        				</section>
        				<footer>
							<input type="submit" name="bouton" value="Valider" />
							<input type="submit" name="bouton" value="Annuler" form="formannuler"/>
						</footer>
					</form>
    	    	</div>
    	    </div>
		</div>   
	</body>
</html>