<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Gestion des auditions - Conservatoire Haut-Jura-Saint-Claude</title>
		<link rel="stylesheet" href="css/stylesmorceau.css" />
		<link rel="stylesheet" href="css/styles.css" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<script type="text/javascript">
			function lancer(elt) {
				if(elt.value == 'Supprimer un morceau')
					document.forms[0].action='auditiongestion';
				else if(elt.value == 'Restaurer des morceaux')
					document.forms[0].action='restaurermorceaux';
				else
					document.forms[0].action='morceaugestion';
			}
  		</script>
	</head>
	<body>
		<!-- <header class="menu">
			<form action="auditiongestion" method="post">
				<input type="submit" name="bouton" value="Charger une audition"/>
			</form>
		</header> -->
		<div class="limiter">
			<div class="conteneur-1200">
        		<div class="formulaire">
        			<c:if test="${ displaySaveOk }">
        				<p id="tempo">Vos modifications ont bien été enregistrées.</p>
        			</c:if>
        			<header><h1>Audition du <c:out value="${ audition.getFormattedDate() }" /> à <c:out value="${ audition.heure }" /><br /><c:out value="${ audition.lieu }" /></h1></header>
        			<section>
        				<c:choose>
	        				<c:when test="${ empty sessionScope.audition.morceaux || sessionScope.audition.morceaux == null }">
								<p>Il n'y a pas encore de morceau pour cette audition, veuillez en ajouter.</p>
							</c:when>
							<c:otherwise>
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
        								<c:set var="i" value="0" scope="page" />
        								<c:forEach var="morceau" items="${ sessionScope.audition.morceaux }">
        									<c:set var="i" value="${ i+1 }" scope="page" />
	        								<tr>
    	    									<td class="column-radio">
													<input type="radio" name="morceauchoisi" value="${ morceau.hashCode() }" id="${ morceau.hashCode() }" form="formmorceau" ${ i == 1 ? 'checked="checked"' : '' } />
												</td>
        										<td class="column1"><c:out value="${ morceau.titre }" /></td>
        										<td class="column2"><c:out value="${ morceau.compositeur }" />&nbsp;</td>
        										<td class="column3"><c:out value="${ morceau.arrangeur }" />&nbsp;</td>
        										<td class="column4"><c:out value="${ morceau.duree.toMinutes() }" />&#39;<c:out value="${ morceau.duree.getSeconds()%60 == 0 ? '00' : morceau.duree.getSeconds()%60 }" /></td>
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
        								<c:remove var="i" scope="page" />
	        						</tbody>
    	    					</table>
    	    				</c:otherwise>
    	    			</c:choose>
        			</section>
        			<footer>
        				<form action="" onsubmit="" method="post" id="formmorceau">
							<input type="submit" name="bouton" value="Ajouter un morceau" onclick="lancer(this)" />
							<input type="submit" name="bouton" value="Editer un morceau" onclick="lancer(this)" ${ empty sessionScope.audition.morceaux ? 'class="display-none"' : '' } />
							<input type="submit" name="bouton" value="Supprimer un morceau" onclick="lancer(this)" ${ empty sessionScope.audition.morceaux ? 'class="display-none"' : '' } />
							<input type="submit" name="bouton" value="Restaurer des morceaux" onclick="lancer(this)" ${ empty sessionScope.audition.morceauxSuppr ? 'class="display-none"' : '' } />
						</form>
					</footer>
        		</div>
			</div>
		</div>   
	</body>
</html>