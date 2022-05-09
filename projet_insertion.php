<?php
include("connexion.inc.php");
$nom = $_POST['nom'];
$prenom = $_POST['prenom'];
$mail = $_POST['mail'];
$siret = $_POST['siret'];
$service = $_POST['service'];
$num = $_POST['num'];

$formation = $_POST['formation'];
$nom_employeur = $_POST['nom_employeur'];
$adresse = $_POST['adresse'];
$tel_employeur = $_POST['tel_employeur'];

$login = $_POST['login'];
$motdepasse = $_POST['motdepasse'];




if(!empty($nom) &&!empty($prenom) && !empty($mail)&& !empty($login)&& !empty($motdepasse)){
    $nom_session = $_POST['nom_session'];
    if (!empty($siret) && empty($service) && empty($num)){
        //requete pour l'insertion du nouveau candidat dans la table candidat
        $req_insert = "INSERT INTO candidat(nom, prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi, id_profil) VALUES ('".$nom."', '".$prenom."', '".$mail."',NULL, NULL, NULL ,'".$siret."', NULL, 3)";
        $res=$cnx->exec($req_insert);
        if($res>0){
            //on recupère le dernier id inséré par cette requete:
            $result=$cnx->query("SELECT * FROM candidat ORDER BY id_candidat desc limit 1");
            $result->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $result->fetch();
            $id_candidat = $ligne['id_candidat'];
          
            //on inscrit le candidat dans la session choisie
            $req_insert2 = "INSERT INTO inscrit(id_candidat, nom_session) VALUES ($id_candidat,'".$nom_session."')";
            $res2=$cnx->exec($req_insert2);
            if($res2>0){
                //on inscrit le candidat dans les modules de la sessions (dans l'épreuve du module plutot)
                if($nom_session=='avril 2021'){
                   
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E21', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E22', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E23', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E24', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E25', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E26', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E27', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E28', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E29', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E30', $note);";
                    $res12=$cnx->exec($req_insert12);
                    
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                            
                        header('Location: projet_frais.php?ext=ext');
                        exit;
                        }else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='janvier 2020'){
                   
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E1', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E2', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E3', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E4', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E5', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E6', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E7', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E8', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E9', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E10', $note);";
                    $res12=$cnx->exec($req_insert12);
                    
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                            
                        header('Location: projet_frais.php?ext=ext');
                        exit;
                        }else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='mai 2020'){
                   
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E11', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E12', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E13', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E14', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E15', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E16', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E17', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E18', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E19', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E20', $note);";
                    $res12=$cnx->exec($req_insert12);
                    
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                            
                        header('Location: projet_frais.php?ext=ext');
                        exit;
                        }else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
            }else{header('Location: projet_frais.php?ech=ech');
            exit;
            }
        }
        else{
            if(!empty($nom_employeur) && !empty($adresse) && !empty($tel_employeur)){
            $req_insert1 = "INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('".$siret."' , '".$nom_employeur."', '".$adresse."', '".$tel_employeur."')";
            $res1=$cnx->exec($req_insert1);
            if($res1>0){
            //requete pour l'insertion du nouveau candidat dans la table candidat
            $req_insert = "INSERT INTO candidat(nom, prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi, id_profil) VALUES ('".$nom."', '".$prenom."', '".$mail."',NULL, NULL, NULL ,'".$siret."', NULL, 5)";
            $res=$cnx->exec($req_insert);
            if($res>0){
                    //on recupère le dernier id inséré par cette requete:
                    $result=$cnx->query("SELECT * FROM candidat ORDER BY id_candidat desc limit 1");
                    $result->setFetchMode(PDO::FETCH_ASSOC);
                    $ligne = $result->fetch();
                    $id_candidat = $ligne['id_candidat'];

                    //on inscrit le candidat dans la session choisie
                    $req_insert2 = "INSERT INTO inscrit(id_candidat, nom_session) VALUES ($id_candidat,'".$nom_session."')";
                    $res2=$cnx->exec($req_insert2);
                    if($res2>0){
                        //on inscrit le candidat dans les modules de la sessions (dans l'épreuve du module plutot)
                        if($nom_session=='avril 2021'){
                        
                            $note = rand(0,  20);
                            $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E21', $note);";
                            $res3=$cnx->exec($req_insert3);
                            $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E22', $note);";
                            $res4=$cnx->exec($req_insert4);
                            $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E23', $note);";
                            $res5=$cnx->exec($req_insert5);
                            $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E24', $note);";
                            $res6=$cnx->exec($req_insert6);
                            $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E25', $note);";
                            $res7=$cnx->exec($req_insert7);
                            $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E26', $note);";
                            $res8=$cnx->exec($req_insert8);
                            $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E27', $note);";
                            $res9=$cnx->exec($req_insert9);
                            $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E28', $note);";
                            $res10=$cnx->exec($req_insert10);
                            $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E29', $note);";
                            $res11=$cnx->exec($req_insert11);
                            $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E30', $note);";
                            $res12=$cnx->exec($req_insert12);
                            
                            if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                                $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                                $res13=$cnx->exec($req_insert13);
                                if($res13>0){
                                    
                                header('Location: projet_frais.php?ext=ext');
                                exit;
                                }else{
                                    header('Location: projet_form_insertion.php?ech=ech');
                                            exit;
                                }
                            }else{
                                header('Location: projet_form_insertion.php?ech=ech');
                                        exit;
                            }
                        }
                        else if($nom_session=='janvier 2020'){
                        
                            $note = rand(0,  20);
                            $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E1', $note);";
                            $res3=$cnx->exec($req_insert3);
                            $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E2', $note);";
                            $res4=$cnx->exec($req_insert4);
                            $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E3', $note);";
                            $res5=$cnx->exec($req_insert5);
                            $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E4', $note);";
                            $res6=$cnx->exec($req_insert6);
                            $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E5', $note);";
                            $res7=$cnx->exec($req_insert7);
                            $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E6', $note);";
                            $res8=$cnx->exec($req_insert8);
                            $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E7', $note);";
                            $res9=$cnx->exec($req_insert9);
                            $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E8', $note);";
                            $res10=$cnx->exec($req_insert10);
                            $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E9', $note);";
                            $res11=$cnx->exec($req_insert11);
                            $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E10', $note);";
                            $res12=$cnx->exec($req_insert12);
                            
                            if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                                $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                                $res13=$cnx->exec($req_insert13);
                                if($res13>0){
                                    
                                header('Location: projet_frais.php?ext=ext');
                                exit;
                                }else{
                                    header('Location: projet_form_insertion.php?ech=ech');
                                            exit;
                                }
                            }else{
                                header('Location: projet_form_insertion.php?ech=ech');
                                        exit;
                            }
                        }
                        else if($nom_session=='mai 2020'){
                        
                            $note = rand(0,  20);
                            $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E11', $note);";
                            $res3=$cnx->exec($req_insert3);
                            $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E12', $note);";
                            $res4=$cnx->exec($req_insert4);
                            $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E13', $note);";
                            $res5=$cnx->exec($req_insert5);
                            $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E14', $note);";
                            $res6=$cnx->exec($req_insert6);
                            $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E15', $note);";
                            $res7=$cnx->exec($req_insert7);
                            $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E16', $note);";
                            $res8=$cnx->exec($req_insert8);
                            $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E17', $note);";
                            $res9=$cnx->exec($req_insert9);
                            $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E18', $note);";
                            $res10=$cnx->exec($req_insert10);
                            $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E19', $note);";
                            $res11=$cnx->exec($req_insert11);
                            $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E20', $note);";
                            $res12=$cnx->exec($req_insert12);
                            if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                                $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                                $res13=$cnx->exec($req_insert13);
                                if($res13>0){
                                    
                                header('Location: projet_frais.php?ext=ext');
                                exit;
                                }else{
                                    header('Location: projet_form_insertion.php?ech=ech');
                                            exit;
                                }
                            }else{
                                header('Location: projet_form_insertion.php?ech=ech');
                                        exit;
                            }
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                
                }else {
                header('Location: projet_form_insertion.php?ech=ech');
                        exit;
            }
         }
            else {
                header('Location: projet_form_insertion.php?formvide=vide');
                        exit;
            }
        }
    }



 else if (empty($siret) && empty($service) && !empty($num) ){
    $niveau = $_POST['niveau'];
    if($niveau !=''){
     //requete pour l'insertion du nouveau candidat dans la table candidat
        $req_insert = "INSERT INTO candidat(nom, prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES ('".$nom."', '".$prenom."', '".$mail."', '".$num."',  '".$niveau."',  '".$formation."' ,NULL, NULL, 02)";
        $res=$cnx->exec($req_insert);
    }
    //on teste si l'insertion s'est bien passé
        if($res>0){
            //on recupère le dernier id inséré par cette requete:
            $result=$cnx->query("SELECT * FROM candidat ORDER BY id_candidat desc limit 1");
            $result->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $result->fetch();
            $id_candidat = $ligne['id_candidat'];
            //on inscrit le candidat dans la session choisie
            $req_insert2 = "INSERT INTO inscrit(id_candidat, nom_session) VALUES ($id_candidat,'".$nom_session."')";
            $res2=$cnx->exec($req_insert2);
            if($res2>0){
                //on inscrit le candidat dans les modules de la sessions (dans l'épreuve du module plutot)
                if($nom_session=='avril 2021'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E21', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E22', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E23', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E24', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E25', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E26', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E27', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E28', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E29', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E30', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?etu=etu');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='janvier 2020'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E1', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E2', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E3', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E4', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E5', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E6', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E7', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E8', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E9', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E10', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?etu=etu');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='mai 2020'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E11', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E12', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E13', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E14', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E15', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E16', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E17', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E18', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E19', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E20', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?etu=etu');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }



            }else{
                header('Location: projet_form_insertion.php?ech=ech');
                        exit;
            }
        }
        else{
            header('Location: projet_form_insertion.php?ech=ech');
                    exit;
        }
    }



    //ca marche touche pas 
 else if (empty($siret) && !empty($service) && empty($num)){
     //requete pour l'insertion du nouveau candidat dans la table candidat
        $req_insert = "INSERT INTO candidat(nom, prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi, id_profil) VALUES ('".$nom."', '".$prenom."', '".$mail."', NULL ,  NULL,  NULL ,NULL, '".$service."',4)";
        $res=$cnx->exec($req_insert);
        //on teste si l'insertion s'est bien passé
        if($res>0){
            //on recupère le dernier id inséré par cette requete:
            $result=$cnx->query("SELECT * FROM candidat ORDER BY id_candidat desc limit 1");
            $result->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $result->fetch();
            $id_candidat = $ligne['id_candidat'];
            //on inscrit le candidat dans la session choisie
            $req_insert2 = "INSERT INTO inscrit(id_candidat, nom_session) VALUES ($id_candidat,'".$nom_session."')";
            $res2=$cnx->exec($req_insert2);
            if($res2>0){
                //on inscrit le candidat dans les modules de la sessions (dans l'épreuve du module plutot)
                if($nom_session=='avril 2021'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E21', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E22', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E23', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E24', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E25', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E26', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E27', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E28', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E29', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E30', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?pers=pers');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='janvier 2020'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E1', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E2', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E3', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E4', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E5', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E6', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E7', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E8', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E9', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E10', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?pers=pers');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }
                else if($nom_session=='mai 2020'){
                    $note = rand(0,  20);
                    $req_insert3 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisA200','E11', $note);";
                    $res3=$cnx->exec($req_insert3);
                    $req_insert4 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavA200','E12', $note);";
                    $res4=$cnx->exec($req_insert4);
                    $req_insert5 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E13', $note);";
                    $res5=$cnx->exec($req_insert5);
                    $req_insert6 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E14', $note);";
                    $res6=$cnx->exec($req_insert6);
                    $req_insert7 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E15', $note);";
                    $res7=$cnx->exec($req_insert7);
                    $req_insert8 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E16', $note);";
                    $res8=$cnx->exec($req_insert8);
                    $req_insert9 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC100','E17', $note);";
                    $res9=$cnx->exec($req_insert9);
                    $req_insert10 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'BoisC200','E18', $note);";
                    $res10=$cnx->exec($req_insert10);
                    $req_insert11 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC100','E19', $note);";
                    $res11=$cnx->exec($req_insert11);
                    $req_insert12 = "INSERT INTO passe(id_candidat, num_salle, code_epreuve, note) VALUES ($id_candidat,'LavC200','E20', $note);";
                    $res12=$cnx->exec($req_insert12);
                    if($res3>0 && $res4>0 && $res5>0 && $res6>0 && $res7>0 && $res8>0 && $res9>0 && $res10>0 && $res11>0 && $res12>0){
                        $req_insert13 = "INSERT INTO authentification(login, motdepasse,id_candidat) VALUES ('".$login."','".md5($motdepasse)."' ,$id_candidat)";
                        $res13=$cnx->exec($req_insert13);
                        if($res13>0){
                        header('Location: projet_frais.php?pers=pers');
                        exit;
                        }
                        else{
                            header('Location: projet_form_insertion.php?ech=ech');
                                    exit;
                        }
                    }
                    else{
                        header('Location: projet_form_insertion.php?ech=ech');
                                exit;
                    }
                }



            }
        }else{
            header('Location: projet_form_insertion.php');
            exit;
        }
    }
} 


else{
    header('Location: projet_form_insertion.php?formvide=vide');
                        exit;
}

?>