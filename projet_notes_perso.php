<?php

include "connexion.inc.php";
$total = 0;
session_start(); 
$id = $_SESSION['id_candidat'];
$query = "SELECT code_module, note, libelle_module, nom_session FROM passe NATURAL JOIN epreuve natural join module where id_candidat = $id"

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
    <form method="get" action="projet_home.php">
    <button>
        <input type="submit" name="submit" value="Accueil" />
</button>
    </form>
</div>

<span>
    <form method="get" action="projet_notes_perso.php">
    <button>
        <input type="submit" name="submit" value="mes notes" />
</button>
    </form>
</span>

<div >
    <form method="get" action="projet_liste_module.php">
    <button>
        <input type="submit" name="submit" value="Modules" />
</button>
    </form>
</div>



<div >
    <form action="projet_convocation.php" method="post">
    <button>
        <input type="submit" name="submit" value="Ma convocation" />
</button>
    </form>
</div>
<div >
    <form method="get" action="projet_profil.php">
    <button>
        <input type="submit" name="submit" value="Profil" />
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
<h1>Notes</h1>


<table>
    <tr>
        <th>Module</th>
        <th>Note</th>
        <th>Session</th>
    </tr>
    <?php foreach ($cnx->query($query) as $line): ?>

        <tr>
            <td><?= $line['libelle_module'] ?></td>
            <td><?= $line['note'] ?></td>
            <td><?= $line['nom_session'] ?></td>
        </tr>
    <?php endforeach ?>
</table>

<div >
    <br/>consultez vos moyennes
    <form method="get" action="projet_moyenne_perso.php">
    <button>
        <input type="submit" name="quit" value="Ma moyenne" />
</button>
    </form>
</div>

    </div>
    </body>
</html>


