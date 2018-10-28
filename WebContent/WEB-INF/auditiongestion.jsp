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
				if(elt.value == "Ajouter un morceau" || elt.value == "Editer un morceau" )
					document.forms[0].action='morceaugestion';
				else if(elt.value == 'Restaurer des morceaux')
					document.forms[0].action='restaurermorceaux';
				else if(elt.value == "haut" || elt.value == "bas")
					document.forms[0].action='auditiongestion#ancre';
				else
					document.forms[0].action='auditiongestion';
			}
  		</script>
	</head>
	<body>
		<!-- <header class="menu">
			<form action="auditiongestion" method="post">
				<input type="submit" name="bouton" value="Charger une audition"/>
			</form>
		</header> -->
		<div class="limiter height-100">
			<div class="conteneur-1200 height-100">
        		<div class="formulaire height-100 formuflex">
        			<c:if test="${ displaySaveOk }">
        				<p id="tempo">Vos modifications ont bien été enregistrées.</p>
        			</c:if>
        			<header><h1>Audition du <c:out value="${ audition.getFormattedDate() }" /> à <c:out value="${ audition.heure }" /><br /><c:out value="${ audition.lieu }" /></h1></header>
        			<section id="tableau-morceaux">
        				<c:choose>
	        				<c:when test="${ empty sessionScope.audition.morceaux || sessionScope.audition.morceaux == null }">
								<p>Il n'y a pas encore de morceau pour cette audition, veuillez en ajouter.</p>
							</c:when>
							<c:otherwise>
								<c:if test="${ ordre }">
									<div id="boutons-ordre">
										<input type="submit" name="bouton" value="haut" form="formmorceau" id="bouton-haut" onclick="lancer(this)" />
										<input type="submit" name="bouton" value="bas" form="formmorceau" id="bouton-bas" onclick="lancer(this)" />
									</div>
								</c:if>
    	    					<div class="bloc-tableau">
      								<c:set var="i" value="0" scope="page" />
       								<c:forEach var="morceau" items="${ sessionScope.audition.morceaux }">
       									<c:set var="i" value="${ i+1 }" scope="page" />
       									<c:set var="hashLocal" value="${ morceau.hashCode() }" scope="page" />
        								<div class="bloc-morceau">
	        								<label class="radiolabel" for="${ hashLocal }"></label>
        									<c:if test="${ i == isauve }"><a id="ancre"></a></c:if>
   	    									<input type="radio" name="morceauchoisi" value="${ hashLocal }" id="${ hashLocal }" form="formmorceau" ${ (ordre != true && i == 1) || (ordre == true && hashLocal == hashChoisi) ? 'checked="checked"' : '' } />
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
													<div class="hidden">Durée : </div>
       												<div id="elt4"><c:out value="${ morceau.duree.toMinutes() }" />&#39;<c:out value="${ morceau.duree.getSeconds()%60 == 0 ? '00' : morceau.duree.getSeconds()%60 }" /></div>
       												<div class="hidden">- Chaises : </div>
       												<div id="elt5"><c:out value="${ morceau.chaises }" /></div>
       												<div class="hidden">- Pupitres : </div>
       												<div id="elt6"><c:out value="${ morceau.pupitres }" /></div><br />
        											<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><div class="hidden">Matériel : </div></c:if>
        											<div id="elt7"><c:out value="${ morceau.materiel }" /></div>
        											<c:if test="${ !(empty morceau.materiel || morceau.materiel == null) }"><br /></c:if>
		   	    									<div class="hidden">Élèves : </div>
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
       								<c:remove var="i" scope="page" />
    	    					</div>
    	    				</c:otherwise>
    	    			</c:choose>
        			</section>
        			<footer>
        				<form action="" onsubmit="" method="post" id="formmorceau">
        					<c:choose>
        						<c:when test="${ ordre }">
        							<input type="submit" name="bouton" value="Valider l'ordre" onclick="lancer(this)" title="Valider et enregistrer le nouvel ordre des morceaux" />
        						</c:when>
        						<c:otherwise>
									<input type="submit" name="bouton" value="Ajouter un morceau" onclick="lancer(this)" title="Ajouter un nouveau morceau à l'audition" />
									<input type="submit" name="bouton" value="Editer un morceau" onclick="lancer(this)" ${ empty sessionScope.audition.morceaux ? 'class="display-none"' : '' } title="Modifier le morceau sélectionné" />
									<input type="submit" name="bouton" value="Changer l'ordre" onclick="lancer(this)" ${ empty sessionScope.audition.morceaux ? 'class="display-none"' : '' } title="Modifier l'ordre des morceaux en faisant monter ou descenddre le morceau sélectionné" />
									<input type="submit" name="bouton" value="Supprimer un morceau" onclick="lancer(this)" ${ empty sessionScope.audition.morceaux ? 'class="display-none"' : '' } title="Supprimer le morceau sélectionné" />
									<input type="submit" name="bouton" value="Restaurer des morceaux" onclick="lancer(this)" ${ empty sessionScope.audition.morceauxSuppr ? 'class="display-none"' : '' } title="Afficher la corbeille et restaurer un ou plusieurs morceaux"/>
								</c:otherwise>
							</c:choose>
						</form>
					</footer>
        		</div>
			</div>
		</div>   
	</body>
</html>