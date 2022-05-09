<?php

include "connexion.inc.php";
$total = 0;
session_start(); 
$id = $_SESSION['id_candidat'];
$query = "SELECT  * FROM corrige natural join epreuve natural join surveillant natural join module "

?>

<!DOCTYPE>
<html lang="fr">
<head>
 
<!-- En-tête du document Si avec l'UTF8 cela ne fonctionne pas mettez charset=ISO-8859-1 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

  <!-- Balise meta  -->
  <meta name="title" content="Titre de la page" />
  <meta name="description" content="description de la page"/>
  <meta name="keywords" content="mots-clé1, mots-clé2, ..."/>
 
  <!-- Indexer et suivre 
  <meta name="robots" content="index,follow" /> -->
 <div id="menu">
  
  <link rel='stylesheet' href='projet2.css' type='text/css' /> 
  <nav class="links" style="--items: 5;">
<div >


<div >
    <form method="get" action="projet_home_admin.php">
    <button>
        <input type="submit" name="submit" value="Accueil" />
</button>
    </form>
</div>


<div >
    <form method="get" action="projet_liste_module_admin.php">
    <button>
        <input type="submit" name="submit" value="Modules" />
</button>
    </form>
</div>

<div >
    <form method="get" action="projet_les_sessions.php">
    <button>
        <input type="submit" name="submit" value="Candidats" />
</button>
    </form>
</div>



<div >
    <form method="get" action="projet_reussir.php">
    <button>
        <input type="submit" name="submit" value="Réussite" />
</button>
    </form>
</div> 
<div >
    <form method="get" action="projet_statistiques.php">
    <button>
        <input type="submit" name="submit" value="Statistiques" />
</button>
    </form>
</div> 
<div >
    <form method="get" action="projet_sessions.php">
    <button>
        <input type="submit" name="submit" value="Ordre" />
</button>
    </form>
</div>


<div >
    <form method="get" action="projet_surveille.php">
    <button>
        <input type="submit" name="quit" value="Surveillants" />
</button>
    </form>
</div>

<div >
    <form method="get" action="projet_correcteur.php">
    <button>
        <input type="submit" name="quit" value="Correcteurs" />
</button>
    </form>
</div>
<div >
    <form method="get" action="projet_accueil.php">
    <button>
        <input type="submit" name="quit" value="Deconnexion" />
</button>
    </form>
</div>



 
<span class="line"></span>

</div>
</nav>
</div>
 </head>
 
  
 <body>
 <div id="titre">Certificat Informatique</div>

<div id="contenu">
<h1>Liste des surveillants</h1>
<table>
    <tr>
        <th>Epreuve</th>
        <th>Module</th>
        <th>Session</th>
        <th>Identifiant</th>
        <th>Contact</th>
        <th>Rib</th>


    </tr>
    <?php foreach ($cnx->query($query) as $line): ?>

        <tr>
            <td><?= $line['code_epreuve'] ?></td>
            <td><?= $line['libelle_module'] ?></td>
            <td><?= $line['nom_session'] ?></td>
            <td><?= $line['id_surveillant'] ?> </td>
            <td><?= $line['contact_surveillant'] ?> </td>
            <td><?= $line['remuneration'] ?></td>


        </tr>

        
    <?php endforeach ?>
</table>
    </div>
    </body>
</html>


