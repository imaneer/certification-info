<?php

include "connexion.inc.php";

$query = " SELECT * from employeur"


?>




<!DOCTYPE html>
<html lang=fr>
 
 <head>
 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
 
	<title>Formulaire de saisie d'insertion d'un candidat</title>
	<link rel='stylesheet' href='projet.css' type='text/css' /> 
</head>

<body>
	<h1>Je m'inscris à une session de certification Informatique</h1>

	<form action="projet_insertion.php" method="POST">
		<p class ="inscription"> 
		Nom <input type="text" name="nom" size="20" /><p class="erreur">*</p> <br />
        </p>
		<p class ="inscription"> Prenom  <input type="text" name="prenom" size="20" /><p class="erreur">*</p><br /></p>
		<p class ="inscription"> Adresse Electronique  <input type="text" name="mail" size="20" /><p class="erreur">*</p><br /></p>
		<p class ="inscription"> Numéro Etudiant  <input type="text" name="num" size="20" /><p class="erreur">Remplir si vous êtes étudiants</p><br /></p>

		<p class ="inscription"> 
		Niveau d'étude <input type="radio" name="niveau" value="L1" /> L1 
			<input type="radio" name="niveau" value="L2"  />L2 
			<input type="radio" name="niveau" value="L3"  />L3 
			<input type="radio" name="niveau" value="M1"  />M1 
			<input type="radio" name="niveau" value="M2"  />M2 <br />
					</p>
		<p class ="inscription"> 
		Formation  <input type="text" name="formation" size="20" /><p class="erreur">Remplir si vous êtes étudiants</p><br /></p>
		<p class ="inscription"> 
		Numéro siret  <input type="text" name="siret" size="20" /><p class="erreur">Remplir si vous êtes exterieur</p><br /></p>
		<p class ="inscription"> Service Administartif <input type="text" name="service" size="20" /><p class="erreur">Remplir si vous êtes personnel</p><br /></p>
		<div class="inscription">
		<p class="erreur">Remplir si votre employeur ne figure pas dans la liste suivante</p>
         
<table>
  
    <?php foreach ($cnx->query($query) as $line): ?>

        <tr>
            <td><?= $line['nom'] ?></td>
           
        </tr>
    <?php endforeach ?>
</table>

       </div>

		<p class ="inscription"> Nom de l'emplyeur  <input type="text" name="nom_employeur" size="20" /><br /></p>
        <p class ="inscription"> Adresse de l'employeur <input type="text" name="adresse" size="20" /><br /></p>
        <p class ="inscription"> Telephone de l'employeur    <input type="text" name="tel_employeur" size="20" /><br /></p>
</br><p class ="inscription"> Login	<input type="text" name="login" size="20" /><br /></p>
		<p class ="inscription"> Mot De Passe	<input type="password" name="motdepasse" size="20" /><br /></p>

		<p class ="inscription"> 

			<input type="radio" name="nom_session" value="janvier 2020" />Janvier 2020 <br />
			<input type="radio" name="nom_session" value="mai 2020"  />Mai 2020 <br />
			<input type="radio" name="nom_session" value="avril 2021" />Avril 2021 <br />



	</p>
	<p>
		<input type="reset" name="reset" value="Effacez" /> 
		<input type="submit" name="submit" value="Insérez" />
		<?php if(isset($_GET["formvide"])) { ?><p class ="erreur">Veuillez remplir le formulaire</p><?php } ?>
		<?php if(isset($_GET["ech"])) { ?><p class ="erreur">L'inscription a échoué</p><?php } ?>
	</p>
</form>
<form method="get" action="projet_accueil.php">
        <input type="submit" name="quit" value="quitter" />
	</form>
</body>
</html>
