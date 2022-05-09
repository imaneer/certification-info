<?php
?>
<!DOCTYPE html>
<html>
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


<?php
    include "connexion.inc.php";
    $total = 0;
    session_start(); 
    $id = $_SESSION['id_candidat'];
    $req_select = "SELECT nom, prenom, nom_session from candidat natural join inscrit  where id_candidat = $id";
    $result=$cnx->query($req_select);
    
    $result->setFetchMode(PDO::FETCH_ASSOC);

    $ligne = $result->fetch();
    $query = "SELECT code_epreuve, libelle_module, date_epreuve, heure ,num_salle, nom_batiment, nom_session from epreuve natural join module natural join salle natural join passe where id_candidat = $id order by nom_session";

?>
    <h1>Convocation</h1>
    <p> Mme/Mr <?= $ligne['nom'] ?><?= $ligne['prenom'] ?> Vous êtes convoqué(e) pour passer la certification d'informatique de la session <?= $ligne['nom_session'] ?> </p><br/>
    <p>Voici les dates et les salles de chaque épreuve</p><br/>
    <table>
        <tr>
            <th>Epreuve</th>
            <th>Session</th>
            <th>Module</th>
            <th>date et heure</th>
            <th>salle</th>
            <th>bâtiment</th>
        </tr>
        <?php foreach ($cnx->query($query) as $line): ?>

            <tr>
                <td><?= $line['code_epreuve'] ?></td>

                <td><?= $line['nom_session'] ?></td>
        
                <td><?= $line['libelle_module'] ?></td>
                  
                <td><?= $line['date_epreuve'] ?> à <?= $line['heure'] ?> </td>
            
                <td><?= $line['num_salle'] ?> </td>
           
                <td><?= $line['nom_batiment'] ?> </td>
            </tr>


        <?php endforeach ?>
</table>
<p>Ce document est à représenter impérativement pour passer chaque épreuve</p>
</body>
        </div>
</html>