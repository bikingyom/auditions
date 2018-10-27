<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurer des morceaux - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/stylesmorceau.css" />
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script type="text/javascript">
			function lancer(elt) {
				if(elt.value == 'Supprimer un morceau')
					document.forms[0].action='auditiongestion';
				else if(elt.value == 'Restaurer des morceau')
					document.forms[O].action='restaurermorceaux';
				else
					document.forms[0].action='morceaugestion';
			}
  		</script>
	</head>
	<body>
		<div class="limiter">
			<div class="conteneur-1200">
        		<div class="formulaire">
        			<header><h1>Sélectionnez les morceaux à restaurer&nbsp;:</h1></header>
        			<section>
						<table>
        					<thead>
   	    						<tr>
       								<th>&nbsp;</th>
       								<th>Titre de l'oeuvre</th>
       								<th>Compositeur</th>
       								<th>Arrangeur</th>
       								<th>Durée</th>
       								<th>Chaises</th>
       								<th>Pupitres</th>
       								<th>Matériel</th>
       								<th>Élèves</th>
        						</tr>
   	    					</thead>
       						<tbody>
       							<c:forEach var="morceau" items="${ sessionScope.audition.morceauxSuppr }">
       								<tr>
       									<td class="column-radio">
											<input type="checkbox" name="morceauxchoisis" value="${ morceau.hashCode() }" id="${ morceau.hashCode() }" form="formmorceau" />
										</td>
       									<td class="column1"><c:out value="${ morceau.titre }" /></td>
       									<td class="column2"><c:out value="${ morceau.compositeur }" />&nbsp;</td>
       									<td class="column3"><c:out value="${ morceau.arrangeur }" />&nbsp;</td>
       									<td class="column4"><c:out value="${ morceau.duree.toMinutes() }" />&apos;<c:out value="${ morceau.duree.getSeconds()%60 == 0 ? '00' : morceau.duree.getSeconds()%60 }" /></td>
       									<td class="column5"><c:out value="${ morceau.chaises }" /></td>
       									<td class="column6"><c:out value="${ morceau.pupitres }" /></td>
        								<td class="column7"><c:out value="${ morceau.materiel }" />&nbsp;</td>
   	    								<td class="column7">
       										<c:forEach var="eleve" items="${ morceau.eleves }">
       											<c:out value="${ eleve.prenom }"/> <c:out value="${ eleve.nom }"/> (<c:out value="${ eleve.instrument }"/>)<br />
       										</c:forEach>
       									</td>
       								</tr>
       							</c:forEach>
        					</tbody>
   	    				</table>
        			</section>
        			<footer>
        				<form action="auditiongestion" method="post" id="formmorceau">
							<input type="submit" name="bouton" value="Restaurer" />
							<input type="submit" name="bouton" value="Annuler" />
						</form>
					</footer>
        		</div>
			</div>
		</div>   
	</body>
</html>