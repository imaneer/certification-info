
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<link rel='stylesheet' href='projet.css' type='text/css' /> 
	<title>Paiement des frais d'inscription></title>
	<style type="text/css">
		body {
			background-color:white;
			font-family:Verdana,Helvetica,Arial,sans-serif;
		}
	</style>
</head>

<body>
<div id="container">
<div class="form">
<h1 >Frais d'inscription</h1>
<form action="projet_insertion.php" method="post">
		
	<br />
    


	<?php if(isset($_GET["error"])) { ?><p class ="erreur">Login ou Mot de passe incorrect, réessayer</p><?php } ?>
	<?php if(isset($_GET["vide"])) { ?><p class ="erreur">Rentrez votre Login et mot de passe</p><?php } ?>

    <h2><p class ="inscription">Veuillez saisir vos informations bancaires</p></h2>
    <p class ="erreur">Si vous êtes étudiant en L1 ou L2 avec aucune absence injustifiée à une épreuve passée, vous serez remboursé dans un délai de deux semaines</p>
    <?php if(isset($_GET["ext"])) { ?><p class ="inscription">Le montant à régler est 200€ </p><?php } ?>
	<?php if(isset($_GET["pers"])) { ?><p class ="inscription">Le montant à régler est 120€ </p><?php } ?>
    <?php if(isset($_GET["etu"])) { ?><p class ="inscription">Le montant à régler est 70€ </p><?php } ?>
    <table class="centrer">
		<tr><td><label for="pseudo"><p class ="inscription"> Nom complet</p></label></td><td><input type="text" name="nom"maxlength="20" size="20" /></td></tr>
		<tr><td><label for="mdp"><p class ="inscription">Numéro de carte bancaire</p></label></td><td><input type="text" name="num" maxlength="16" size="15" /></td></tr>
        <tr><td><label for="mdp"><p class ="inscription">Date d'expiration</p></label></td><td><input type="text" name="date" maxlength="11" size="15" /></td></tr>
        <tr><td><label for="mdp"><p class ="inscription">Cryptograme</p></label></td><td><input type="text" name="cryp" maxlength="3" size="5" /></td></tr>
    </table>
</form>

<form method="get" action="projet_form_auth.php">
<input type="reset" name="reset" value="Effacer" /> 
	<input type="submit" name="submit" value="Valider" />
        <input type="submit" name="quit" value="quitter" />
    </form>
	
	</div>
	</div>
</body>
</html>
