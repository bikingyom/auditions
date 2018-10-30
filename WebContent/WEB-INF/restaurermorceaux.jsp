<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurer des morceaux - Conservatoire Haut-Jura-Saint-Claude</title>
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
		<div class="limiter height-100">
			<div class="conteneur-1200 height-100">
        		<div class="formulaire height-100 formuflex">
        			<header><h1>Sélectionnez les morceaux à restaurer&nbsp;:</h1></header>
        			<section id="tableau-morceaux">
						<div class="bloc-tableau">
    						<div class="contenu-morceau grand gras">
	   							<div id="elt2">Titre de l'oeuvre</div>
    							<div id="elt3">Compositeur</div>
   								<div id="elt4">Durée</div>
    	   						<div id="elt5">Chaises</div>
    	   						<div id="elt6">Pupitres</div>
	       						<div id="elt7">Matériel</div>
    							<div id="elt8">Élèves</div>
    	  					</div>
    						<c:forEach var="morceau" items="${ sessionScope.audition.morceauxSuppr }">
								<c:set var="hashLocal" value="${ morceau.hashCode() }" scope="page" />
   								<div class="bloc-morceau">
	   								<label class="radiolabel" for="${ hashLocal }"></label>
    								<input type="checkbox" name="morceauxchoisis" value="${ hashLocal }" id="${ hashLocal }" form="formmorceau" />
   									<div class="contenu-morceau grand">
										<div id="elt2"><c:out value="${ morceau.titre }" /></div>
										<div id="elt3"><c:out value="${ morceau.compositeur }" /></div><br />
    									<div id="elt4"><c:out value="${ morceau.duree.toMinutes() }" />&#39;<c:out value="${ morceau.duree.getSeconds()%60 == 0 ? '00' : morceau.duree.getSeconds()%60 }" /></div>
       									<div id="elt5"><c:out value="${ morceau.chaises }" /></div>
       									<div id="elt6"><c:out value="${ morceau.pupitres }" /></div><br />
        								<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><div class="hidden">Matériel : </div></c:if>
        								<div id="elt7"><c:out value="${ morceau.materiel }" /></div>
        								<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><br /></c:if>
   	    								<div id="elt8">
	       								<c:forEach var="eleve" items="${ morceau.eleves }">
    	   									<c:set var="j" value="${ j+1 }" scope="page" />
        									<c:out value="${ eleve.prenom }"/> <c:out value="${ eleve.nom }"/> (<c:out value="${ eleve.instrument }"/>)<br />
   	    								</c:forEach>
   	    								</div>
   	    							</div>
   	    							<div class="contenu-morceau petit">
	   	    							<div class="morceau-inline">
											<div id="elt2"><c:out value="${ morceau.titre }" /></div>
											<div class="hidden"><c:out value="${ empty morceau.compositeur || morceau.compositeur == null ? '' : '- ' }" /></div>
											<div id="elt3"><c:out value="${ morceau.compositeur }" /></div><br />
											<div class="hidden">Durée&nbsp;: </div>
       										<div id="elt4"><c:out value="${ morceau.duree.toMinutes() }" />&#39;<c:out value="${ morceau.duree.getSeconds()%60 == 0 ? '00' : morceau.duree.getSeconds()%60 }" /></div>
       										<div class="hidden">- Chaises&nbsp;: </div>
       										<div id="elt5"><c:out value="${ morceau.chaises }" /></div>
       										<div class="hidden">- Pupitres&nbsp;: </div>
       										<div id="elt6"><c:out value="${ morceau.pupitres }" /></div><br />
        									<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><div class="hidden">Matériel : </div></c:if>
        									<div id="elt7"><c:out value="${ morceau.materiel }" /></div>
        									<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><br /></c:if>
		   	  									<div class="hidden">Élèves&nbsp;: </div>
   			  									<div id="elt8">
	    	  										<c:forEach var="eleve" items="${ morceau.eleves }">
    	   											<c:set var="j" value="${ j+1 }" scope="page" />
        											<c:out value="${ eleve.prenom }"/> <c:out value="${ eleve.nom }"/> (<c:out value="${ eleve.instrument }"/>)<br />
   	    										</c:forEach>
   	    									</div>
   	    								</div>
   	    							</div>
   	    						</div>
       						</c:forEach>
       					</div>
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
        			