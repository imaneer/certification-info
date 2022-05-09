
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<link rel='stylesheet' href='projet.css' type='text/css' /> 
	<title>Formulaire de saisie de login et de mot de passe</title>
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
<h1 >connexion</h1>
<form action="projet_auth.php" method="post">

	<table class="centrer">
		<tr><td><label for="pseudo"><p class ="inscription"> login</p></label></td><td><input type="text" name="pseudo" /></td></tr>
		<tr><td><label for="mdp"><p class ="inscription">Mot de passe</p></label></td><td><input type="password" name="mdp" /></td></tr>
		<p class ="inscription"> 
<input type="radio" name="type" value="candidat" />Candidat <br />
			<input type="radio" name="type" value="admin"  />Admin <br />
	</p>
	</table>
	<br />
	<input type="reset" name="reset" value="Effacer" /> 
	<input type="submit" name="submit" value="Valider" />
	<?php if(isset($_GET["error"])) { ?><p class ="erreur">Login ou Mot de passe incorrect, réessayer</p><?php } ?>
	<?php if(isset($_GET["vide"])) { ?><p class ="erreur">Rentrez votre Login et mot de passe</p><?php } ?>
</form>

<form method="get" action="projet_accueil.php">
        <input type="submit" name="quit" value="quitter" />
    </form>
	
	</div>
	</div>
</body>
</html>
