<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Gestion des auditions - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/stylesmorceau.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-600">
	        	<div class="formulaire">
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
        					<table>
            		   			<tr><td><label for="nom">Date : </label><input type="date" name="date" id="date" required /></td></tr>
        	       				<tr><td><label for="heure">Heure : </label><input type="time" name="heure" id="heure" required /></td></tr>
	    	           			<tr><td><label for="lieu">Lieu : </label><input type="text" name="lieu" id="lieu" required /></td></tr>
    		           		</table>
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