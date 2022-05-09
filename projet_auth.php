<?php
include("connexion.inc.php");

$pseudo= $_POST['pseudo'];
$mdp = $_POST['mdp'];
$type = $_POST['type'];
$motDePasse = md5($mdp);
if(!empty($pseudo) && !empty($mdp) && !empty($type)){

    // La requête SELECT
    $req_select1 = "SELECT * FROM authentification WHERE login ='".$pseudo."'";
    $req_select2 = "SELECT * FROM admin WHERE login ='".$pseudo."'";
    if($type=='candidat'){
        $result=$cnx->query($req_select1);
    }else{
        $result=$cnx->query($req_select2);
    }

    // Le résulat sera sous forme d'un tableau indexé par le nom de la colonne 
    $result->setFetchMode(PDO::FETCH_ASSOC);

    if($result->rowCount() > 0){
        // On récupère la ligne retournée par le SELECT
        $ligne = $result->fetch();
        $identifiant = $ligne['id_candidat'];
        /*
        * On récupère le mot passe retournée par le SELECT
        * ATTENTION: on écrit $ligne['motdepasse'] en NON PAS $ligne['motDePasse'] (pas de majuscules!)
        */

        if ($ligne['motdepasse'] == $motDePasse && $type=="candidat"){
            session_start();
            $_SESSION['id_candidat'] = $identifiant;
            header('Location: projet_home.php');
            exit;
        }

        if ($ligne['motdepasse'] == $motDePasse && $type=="admin"){
            session_start();
            $_SESSION['id_candidat'] = $identifiant;
            header('Location: projet_home_admin.php');
            exit;
        }

        else{
            
            header('Location: projet_form_auth.php?error=incorrect');
            exit;
        }
        
        // Fermer le cursor
        $result->closeCursor();

        // Fermer la connexion
        $conn = null;
    }
    else{
        $erreur = True;
        header('Location: projet_form_auth.php?error=incorrect');
        exit;
    }
}
else{
    $erreur = True;
            header('Location: projet_form_auth.php?vide=vide');
            exit;
}

?>
