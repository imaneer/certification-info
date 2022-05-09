---
-- Create table candidat
---
Create TABLE candidat (
   id_candidat serial primary key,
   nom varchar(25) not null,
   prenom varchar(25) not null,
   mail varchar(70) not null,
   num_etud varchar(5),
   niv_etud varchar(2),
   formation varchar(30) ,
   num_siret char(14) ,
   service_admi varchar(70) , 
   id_profil integer,
   check(niv_etud in ('L1', 'L2','L3', 'M1', 'M2')),
   check(((num_etud  is not null) and (num_siret is null) and (service_admi is null)) or
    ((num_etud is null) and (num_siret is not null) and (service_admi is  null)) 
or ((num_etud is null) and (num_siret is null) and (service_admi is not null)))
   );

---
-- Create table inscrit
---
Create TABLE inscrit(
	id_candidat serial,
    nom_session varchar(20),
    constraint cle_prim_inscrit primary key (id_candidat, nom_session)

);

---
-- Create table employeur
---
Create TABLE employeur (
   num_siret char(14) primary key,
   nom varchar(70) not null,
   adresse varchar(70),
   tel_employeur varchar(10) unique
);

---
-- Create table profil
---
Create TABLE profil (
   id_profil integer primary key,
   absence int
);


---
-- Create table annee_univ
---
Create TABLE annee_univ (
   annee_univ varchar(9) primary key
);


---
-- Create table session
---
Create TABLE session (
   nom_session varchar(20) primary key,
   date_session varchar(15),
   heure_debut varchar(5),
   heure_fin varchar(5)
);
   
   
---
-- Create table epreuve
---
Create TABLE epreuve (
   code_epreuve varchar(4) primary key,
   libelle_epreuve varchar(50),
   note_min int,
   nom_session varchar(20),
   code_module varchar(20), 
   date_epreuve varchar(20) not null, 
   heure varchar(6) not null
);


---
-- Create table module
---
Create TABLE module (
   code_module varchar(20) primary key,
   libelle_module varchar(70)
   );
   
---
-- Create table passe
---
Create TABLE passe  (
   id_candidat serial ,
   num_salle varchar(20),
   code_epreuve varchar(20),
   note float default 0,
   unique(id_candidat, num_salle, code_epreuve),
   constraint cle_prim_passe primary key (id_candidat, num_salle,code_epreuve)
);


---
-- Create table salle
---
Create TABLE salle  (
   num_salle varchar(20) primary key,
   capacite int,
   nom_batiment varchar(30),
   unique(num_salle,nom_batiment)

);

---
-- Create table corrige
---
Create TABLE corrige (
    code_epreuve varchar(4),
    id_surveillant integer,
    constraint cle_prim_corrige primary key (code_epreuve, id_surveillant)
);


---
-- Create table surveille
---
Create TABLE surveille (
    code_epreuve varchar(4),
    id_surveillant integer,
    num_salle varchar(20),
    unique(id_surveillant,code_epreuve, num_salle),
    constraint cle_prim_surveille primary key (code_epreuve, id_surveillant, num_salle)
);

---
-- Create table surveillant
---
Create TABLE surveillant(
	id_surveillant integer primary key,
	contact_surveillant varchar(20),
	remuneration varchar(27) not null, 
    unique(contact_surveillant)
);


---
-- Create table batiment
---
Create TABLE batiment(
	nom_batiment varchar(30) primary key,
    id_responsable integer
);

---
-- Create table sous_batiment
--- 
Create TABLE sous_batiment(
	nom_sous_batiment varchar(10),
	nom_batiment varchar(30),
	constraint cle_prim_sous_bat primary key (nom_sous_batiment, nom_batiment)

);

---
-- Create table responsable
---
Create TABLE responsable(
	id_responsable integer primary key,
    nom varchar(20),
    prenom varchar(20)
);
   

---
-- Create table ouvre
---
Create TABLE ouvre(
	nom_batiment varchar(30),
	heure varchar(11),
	jour varchar(10),
	moyen varchar(30),
	constraint cle_prim_ouvre primary key (nom_batiment, heure, jour)
);

---
-- Create table heure
---
Create TABLE heure(
	heure varchar(11) primary key 
);

---
-- Create table jour
---
Create TABLE jour(
	jour varchar(10) primary key
);

---
-- Create table authentification
---
Create TABLE authentification(
	login varchar(50) primary key, 
    motdepasse varchar(50), 
    id_candidat serial
);

---
-- Create table admin
---
Create TABLE admin(
	login varchar(50) primary key, 
    motdepasse varchar(50) 
);

---
-- Create table paye
---
Create TABLE paye(
     id_profil integer,
     annee_univ varchar(9),
     frais varchar(10),
     constraint cle_prim_paye primary key (id_profil, annee_univ)
);



--
-- Name: authentification_id_candidat_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE authentification
    ADD CONSTRAINT authentification_id_candidat_fkey FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat) on delete cascade on update cascade;


--
-- Name: inscrit_id_candidat_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE inscrit
    ADD CONSTRAINT inscrit_id_candidat_fkey FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat) on delete cascade on update cascade;

--
-- Name: inscrit_nom_session_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE inscrit
    ADD CONSTRAINT inscrit_nom_session_fkey FOREIGN KEY (nom_session) REFERENCES session(nom_session)on delete cascade on update cascade;


--
-- Name: candidat_num_siret_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE candidat
    ADD CONSTRAINT candidat_num_siret_employeur_fkey FOREIGN KEY (num_siret) REFERENCES employeur(num_siret)on delete cascade on update cascade;

--
-- Name: candidat_id_profil_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE candidat
    ADD CONSTRAINT candidat_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES profil(id_profil)on delete cascade on update cascade;

--
-- Name: passe_id_candidat_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE passe
    ADD CONSTRAINT passe_id_candidat_fkey FOREIGN KEY (id_candidat) REFERENCES candidat(id_candidat)on delete cascade on update cascade;

--
-- Name: passe_num_salle_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE passe
    ADD CONSTRAINT passe_num_salle_fkey FOREIGN KEY (num_salle) REFERENCES salle(num_salle)on delete cascade on update cascade;

--
-- Name: passe_code_epreuve_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE passe
    ADD CONSTRAINT passe_code_epreuve_fkey FOREIGN KEY (code_epreuve) REFERENCES epreuve(code_epreuve)on delete cascade on update cascade;


--
-- Name: epreuve_nom_session_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE epreuve
    ADD CONSTRAINT epreuve_nom_session_fkey FOREIGN KEY (nom_session) REFERENCES session(nom_session)on delete cascade on update cascade;


--
-- Name: epreuve_code_module_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE epreuve
    ADD CONSTRAINT epreuve_code_module_fkey FOREIGN KEY (code_module) REFERENCES module(code_module)on delete cascade on update cascade;


--
-- Name: corrige_code_epreuve_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE corrige
    ADD CONSTRAINT corrige_code_epreuve_fkey FOREIGN KEY (code_epreuve) REFERENCES epreuve(code_epreuve)on delete cascade on update cascade;


--
-- Name: corrige_id_surveillant_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE corrige
    ADD CONSTRAINT corrige_id_surveillant_fkey FOREIGN KEY (id_surveillant) REFERENCES surveillant(id_surveillant)on delete cascade on update cascade;

--
-- Name: surveille_code_epreuve_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE surveille
    ADD CONSTRAINT surveille_code_epreuve_fkey FOREIGN KEY (code_epreuve) REFERENCES epreuve(code_epreuve)on delete cascade on update cascade;

--
-- Name: surveille_id_surveillant_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE surveille
    ADD CONSTRAINT surveille_id_surveillant_fkey FOREIGN KEY (id_surveillant) REFERENCES surveillant(id_surveillant)on delete cascade on update cascade;


--
-- Name: surveille_num_salle_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE surveille
    ADD CONSTRAINT surveille_num_salle_fkey FOREIGN KEY (num_salle) REFERENCES salle(num_salle)on delete cascade on update cascade;


--
-- Name: salle_nom_batiment_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE salle
    ADD CONSTRAINT salle_nom_batiment_fkey FOREIGN KEY (nom_batiment) REFERENCES batiment(nom_batiment)on delete cascade on update cascade;


--
-- Name: sous_batiment_nom_batiment_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE sous_batiment
    ADD CONSTRAINT sous_batiment_nom_batiment_fkey FOREIGN KEY (nom_batiment) REFERENCES batiment(nom_batiment)on delete cascade on update cascade;
   

--
-- Name: responsable_nom_batiment_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE batiment
    ADD CONSTRAINT batiment_id_responsable_fkey FOREIGN KEY (id_responsable) REFERENCES responsable(id_responsable)on delete cascade on update cascade;
   

--
-- Name: ouvre_nom_batiment_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE ouvre
    ADD CONSTRAINT ouvre_nom_batiment_fkey FOREIGN KEY (nom_batiment) REFERENCES batiment(nom_batiment)on delete cascade on update cascade;


--
-- Name: ouvre_heure_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE ouvre
    ADD CONSTRAINT ouvre_heure_fkey FOREIGN KEY (heure) REFERENCES heure(heure)on delete cascade on update cascade;

--
-- Name: ouvre_jour_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE ouvre
    ADD CONSTRAINT ouvre_jour_fkey FOREIGN KEY (jour) REFERENCES jour(jour)on delete cascade on update cascade;


--
-- Name: profil_id_fkey; Type: FK CONSTRAINT;
--

ALTER TABLE paye
    ADD CONSTRAINT paye_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES profil(id_profil)on delete cascade on update cascade;
--
-- Name: paye_annee_fkey; Type: FK CONSTRAINT; 
--

ALTER TABLE paye
    ADD CONSTRAINT paye_annee_fkey FOREIGN KEY (annee_univ) REFERENCES annee_univ(annee_univ)on delete cascade on update cascade;

--
-- Data for Name: responsable
--
INSERT INTO responsable(id_responsable,nom,prenom) VALUES (1,'Raymond','Jacob');
INSERT INTO responsable(id_responsable,nom,prenom) VALUES (2,'Ramon','Norbert');

--
-- Data for Name: batiment
--
INSERT INTO batiment(nom_batiment,id_responsable ) VALUES ('Bois de l’Etang', 2);
INSERT INTO batiment(nom_batiment, id_responsable) VALUES ('Lavoisier', 1);


--
-- Data for Name: salle
--

INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisA100', 20, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisA200', 30, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisA300', 20, 'Bois de l’Etang');

INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisB100', 30, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisB200', 20, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisB300', 20, 'Bois de l’Etang');

INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisC100', 30, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisC200', 20, 'Bois de l’Etang');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('BoisC300', 30, 'Bois de l’Etang');


INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavA100', 20, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavA200', 30, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavA300', 20, 'Lavoisier');

INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavB100', 30, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavB200', 20, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavB300', 20, 'Lavoisier');

INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavC100', 30, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavC200', 30, 'Lavoisier');
INSERT INTO salle(num_salle, capacite, nom_batiment) VALUES ('LavC300', 20, 'Lavoisier');


--
-- Data for Name: sous_batiment
--

INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('BoisA','Bois de l’Etang');
INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('BoisB','Bois de l’Etang');
INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('BoisC','Bois de l’Etang');

INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('LavA','Lavoisier');
INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('LavB','Lavoisier');
INSERT INTO sous_batiment(nom_sous_batiment,nom_batiment) VALUES ('LavC','Lavoisier');



--
-- Data for Name: heure
--
INSERT INTO heure(heure) VALUES ('8h-20h');
INSERT INTO heure(heure) VALUES ('20h-21h');
INSERT INTO heure(heure) VALUES ('8h-16h');

--
-- Data for Name: surveillant:
--
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (1 ,'07 75 02 50 08','FR7630006000011234567890187');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (2 ,'06 55 12 59 45','FR8710011000201234567G90188');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (3 ,'06 55 22 58 63','FR7640618802611234567890107');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (4 ,'07 85 32 57 10','FR7610107001011234567890129');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (5 ,'06 55 42 56 89','FR7611315000011234567890138');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (6 ,'06 55 52 55 24','FR7642559000011234567890121');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (7 ,'07 55 62 54 69','FR7630076020821234567890186');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (8 ,'06 55 72 53 18','FR7612548029981234567890161');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (9 ,'06 05 82 52 71','FR7611808009101234567890147');
INSERT INTO surveillant(id_surveillant, contact_surveillant, remuneration) VALUES (10,'06 15 92 51 10','FR7630007000111234567890144');



--
-- Data for Name: jour
--
INSERT INTO jour(jour) VALUES ('Lundi');
INSERT INTO jour(jour) VALUES ('Mardi');
INSERT INTO jour(jour) VALUES ('Mercredi');
INSERT INTO jour(jour) VALUES ('Jeudi');
INSERT INTO jour(jour) VALUES ('Vendredi');
INSERT INTO jour(jour) VALUES ('Samedi');


--
-- Data for Name: ouvre
--
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-20h', 'Lundi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','20h-21h', 'Lundi'  , 'sur demande' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-20h', 'Mardi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-20h', 'Mercredi', 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-20h', 'Jeudi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-20h', 'Vendredi', 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Lavoisier','8h-16h', 'Samedi'  , 'sur demande' );

INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-20h', 'Lundi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-20h', 'Mardi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-20h', 'Mercredi', 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-20h', 'Jeudi'   , 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','20h-21h', 'Lundi'  , 'sur demande' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-20h', 'Vendredi', 'systematiquement ouvert' );
INSERT INTO ouvre(nom_batiment, heure, jour, moyen) VALUES ('Bois de l’Etang','8h-16h', 'Samedi'  , 'sur demande' );


--
-- Data for Name: employeur
--
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('36252187900579', 'Eproc', '35 avenue du général Leclerc', '0255179908');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('55203253400646', 'BLC' , '301 avenue Foche', '0588766042');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('48358525300014', 'GCM', '11 avenue Auguste Rodin', '0418386368');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('36452187900034', 'ProdFactory', '2 avenue Copernic', '0340810900');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('48358525300246', 'STR', '1 avenue Commandant', '0443232942');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('55206709200153', 'Baulore', '50 avenue de France', '0286539702');
INSERT INTO employeur(num_siret, nom, adresse, tel_employeur) VALUES ('55206709200049', 'Asl', '76 avenue de la Republique', '0347733977');


--
-- Data for Name: année
--
INSERT INTO annee_univ(annee_univ) VALUES ('2019/2020');
INSERT INTO annee_univ(annee_univ) VALUES ('2020/2021');

--
-- Data for Name: session
--

INSERT INTO session(nom_session, date_session, heure_debut, heure_fin ) values ('mai 2020', '15-03-2020', '8h','16h' );
INSERT INTO session(nom_session, date_session, heure_debut, heure_fin ) values ('janvier 2020','15-05-2020','9h' ,'18h' );
INSERT INTO session(nom_session, date_session, heure_debut, heure_fin ) values ('avril 2021',  '15-04-2021', '8h','17h' );

--
-- Data for Name: profil
--

/*L1 et L2 avec absence*/
INSERT INTO profil( id_profil, absence) VALUES (1,  1 );

/*L1 et L2 sans absence*/
INSERT INTO profil( id_profil, absence) VALUES (2,  0 );

/*employées*/
INSERT INTO profil( id_profil, absence) VALUES (3 , NULL);

/*personnel de la fac */
INSERT INTO profil( id_profil, absence) VALUES (4, NULL );

--
-- Data for Name: paye
--


INSERT INTO paye(id_profil, annee_univ, frais) VALUES (1, '2019/2020','50€');
INSERT INTO paye(id_profil, annee_univ, frais) VALUES (1, '2020/2021','70€');

INSERT INTO paye(id_profil, annee_univ, frais) VALUES (2, '2019/2020','0€');
INSERT INTO paye(id_profil, annee_univ, frais) VALUES (2, '2020/2021','0€');


INSERT INTO paye(id_profil, annee_univ, frais) VALUES (3, '2019/2020','150€');
INSERT INTO paye(id_profil, annee_univ, frais) VALUES (3, '2020/2021','200€');

INSERT INTO paye(id_profil, annee_univ, frais) VALUES (4, '2019/2020','90€');
INSERT INTO paye(id_profil, annee_univ, frais) VALUES (4, '2020/2021','120€');



--
-- Data for Name: candidat
--
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Masson'  ,'Jules'   , 'Masson.J@univ.eiffel.fr' ,'0101','L1','MI',NULL,NULL,1);   
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Gautier' ,'Léo'     , 'Gautier.L@univ.eiffel.fr','0202','L1','MI',NULL,NULL,2);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Mathieu' ,'Zoé'     , 'Mathieu.Z@univ.eiffel.fr','0303','L1','MI',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Roussel' ,'Raphaël' , 'Roussel.R@univ.eiffel.fr','0404','L1','MI',NULL,NULL,2);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Henry'   ,'Juliette', 'Henry.J@univ.eiffel.fr'  ,'0505','L1','MIASH',NULL,NULL,2);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Legrand' ,'Adam'    , 'Legrand.A@univ.eiffel.fr','0606','L2','MIASH',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Garcia'  ,'Jeanne'  , 'Garcia.J@univ.eiffel.fr ','0707','L2','MIASH',NULL,NULL,2);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Nicolas' ,'Gaspar'  , 'Nicolas.G@univ.eiffel.fr','0808','L2','MPC',NULL,NULL,2);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Morin'   ,'Victoire', 'Morin.V@univ.eiffel.fr'  ,'0909','L2','MPC',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Clement' ,'Malo'    , 'Clement.M@univ.eiffel.fr','1010','L2','MPC',NULL,NULL,2);

INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Gauthier','Lina'    , 'Gauthier.L@univ.eiffel.fr','1111', 'L3', 'MITIC' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Robin'   ,'Martin'  , 'Robin.M@univ.eiffel.fr'   ,'1212', 'L3', 'MITIC' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Perrin'  ,'Victor'  , 'Perrin.V@univ.eiffel.fr'  ,'1313', 'L3', 'MITIC' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Francois','Rose'    , 'Francois.R@univ.eiffel.fr','1414', 'L3', 'LMI' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Chevalier','Samuel'  , 'hevalier.S@univ.eiffel.fr','1515', 'L3', 'LMI' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Guerin'  ,'Ambre '  , 'Guerin.A@univ.eiffel.fr'  ,'1616', 'M1', 'MIAGE' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Boyer'   ,'Adèle'   , 'Boyer.A@univ.eiffel.fr'   ,'1717', 'M1', 'MIAGE' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Garnier' ,'Chloé'   , 'Garnier.C@univ.eiffel.fr','1818', 'M1', 'MIAGE' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Blanc'   ,'Léonie'  , 'Blanc.L@univ.eiffel.fr'  ,'1919', 'M1',  'DS',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Andre'   ,'Lucas'   , 'Andre.L@univ.eiffel.fr'  ,'2020', 'M1', ' DS',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Mercier' ,'Louise'  , 'Mercier.L@univ.eiffel.fr','2121', 'M2', ' DS',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Faure'   ,'Iris'    , 'Faure.I@univ.eiffel.fr'  ,'2222', 'M2', ' DS',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Lefevre' ,'Léa'     , 'Lefevre.L@univ.eiffel.fr','2323', 'M2', 'MIAGE',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Muller'  ,'Eva'     , 'Muller.E@univ.eiffel.fr','2424', 'M2', 'MIAGE' ,NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Vincent' ,'Gabin'   , 'Vincent.G@univ.eiffel.fr','2525', 'M2', 'MIAGE',NULL,NULL,1);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Fournier','Emma'    , 'Fournier.E@gmail.com', NULL , NULL, NULL ,'36252187900579',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Rousseau','Mathis'  , 'Rousseau.M@gmail.com', NULL , NULL, NULL ,'36252187900579',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Fontaine','Alice'   , 'Fontaine.A@gmail.com', NULL , NULL, NULL ,'55203253400646',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Girard'  ,'Yanick'  , 'Girard.Y@gmail.com', NULL , NULL, NULL   ,'48358525300014',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Bonnet'  ,'Paul'    , 'Bonnet.P@yahoo.fr', NULL , NULL, NULL    ,'48358525300246',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Dupont'  ,'Arthur'  , 'Dupont.A@yahoo.fr', NULL , NULL, NULL    ,'48358525300246',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Morel'   ,'Lou'     , 'Morel.L@yahoo.fr', NULL , NULL, NULL     ,'36452187900034',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Lambert' ,'Enzo'    , 'Lambert.E@yahoo.fr', NULL , NULL, NULL   ,'55206709200153',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Bertrand','Julia'   , 'Bertrand.J@yahoo.fr', NULL , NULL, NULL  ,'55206709200049',NULL,3);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('David'   ,'Hugo'    , 'David.H@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SCD',4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Leroy'   ,'Sami'    , 'Leroy.S@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SCD',4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Roux'    ,'Agathe'  , 'Roux.A@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SCD' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Lefebvre','Lise'    , 'Lefebvre.L@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SCD',4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Simon'   ,'Inès'    , 'Simon.I@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'CRI'  ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Laurent' ,'Nathan'  , 'Laurent.N@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'CRI',4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Durand'  ,'Sarah'   , 'Durand.S@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'CRI' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Moreau'  ,'Antoine' , 'Moreau.A@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'CRI' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Richard' ,'Léna'    , 'Richard.L@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SSU',4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Michel'  ,'Anna'    , 'Michel.A@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SSU' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Dubois'  ,'Léon'    , 'Dubois.L@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'SSU' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Robert'  ,'Manon'   , 'Robert.M@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'RH'  ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Petit'   ,'Camille' , 'Petit.C@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'RH'   ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Thomas'  ,'Gabriel' , 'Thomas.G@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'RH'  ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Bernard' ,'Jade'    , 'Bernard.J@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'RH' ,4);
INSERT INTO candidat(nom,prenom, mail, num_etud, niv_etud, formation, num_siret, service_admi,id_profil) VALUES  ('Martin'  ,'Marius'  , 'Martin.M@univ-eiffel.fr', NULL, NULL,NULL,NULL, 'RH'  ,4);

--
-- Data for Name: module
--

INSERT INTO MODULE (code_module, libelle_module) Values ('BDD'  , 'bases de donnee');
INSERT INTO MODULE (code_module, libelle_module) Values ('C'    ,'programmation C');
INSERT INTO MODULE (code_module, libelle_module) Values ('PH'   , 'python');
INSERT INTO MODULE (code_module, libelle_module) Values ('J'    , 'java');
INSERT INTO MODULE (code_module, libelle_module) Values ('C2'   , 'C2i');
INSERT INTO MODULE (code_module, libelle_module) Values ('SI'   ,'sécurité informatique');
INSERT INTO MODULE (code_module, libelle_module) Values ('R'    , 'réseaux');
INSERT INTO MODULE (code_module, libelle_module) Values ('WEB'  , 'programmation web');
INSERT INTO MODULE (code_module, libelle_module) Values ('ARCHI','architecture des ordinateurs');
INSERT INTO MODULE (code_module, libelle_module) Values ('MI'   ,'mathémathiques appliquées à linformatique');

--
-- Data for Name: epreuve
--

INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E1',  'BDDJ2020',8, 'janvier 2020', 'BDD', '15-01-2020', '8h00');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E2',  'CJ2020'  ,  8, 'janvier 2020', 'C', '15-01-2020', '14h00');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E3',  'PHJ2020'  , 10, 'janvier 2020', 'PH', '16-01-2020', '10h30');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E4',  'JJ2020'   ,  10, 'janvier 2020', 'J', '17-01-2020', '10h15');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E5',  'C2J2020'  , 10, 'janvier 2020', 'C2', '18-01-2020', '15h15');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E6',  'SIJ2020'    , 10, 'janvier 2020', 'SI', '19-01-2020', '8h45');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E7',  'RJ2020'     ,  10, 'janvier 2020', 'R', '20-01-2020', '9h00');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E8',  'WEBJ2020'   ,10, 'janvier 2020', 'WEB', '21-01-2020', '10h00');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E9',  'ARCHIJ2020'  , 8, 'janvier 2020', 'ARCHI', '22-01-2020', '14h30');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E10', 'MIJ2020'    , 8 , 'janvier 2020', 'MI', '23-01-2020', '14h00');
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E11', 'BDDM2020'    , 8, 'mai 2020','BDD', '15-05-2020', '8h00'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E12', 'CM2020'     , 8, 'mai 2020','C'  , '15-05-2020', '14h00'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E13', 'PHM2020'      , 10, 'mai 2020','PH' , '16-05-2020', '10h30'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E14', 'JM2020'      , 10, 'mai 2020','J' , '17-05-2020', '10h15'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E15', 'C2M2020'    , 10, 'mai 2020','C2' , '18-05-2020', '15h15'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E16', 'SIM2020'     , 10, 'mai 2020','SI' , '19-05-2020', '8h45'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E17', 'RM2020'     , 10, 'mai 2020','R',  '20-05-2020', '9h00'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E18', 'WEBM2020'  , 10, 'mai 2020','WEB' ,  '21-05-2020', '10h00' );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E19', 'ARCHIM2020', 8, 'mai 2020','ARCHI', '22-05-2020', '14h30' );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E20', 'MIM2020'   ,8 , 'mai 2020','MI', '23-05-2020', '14h00'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E21', 'BDDA2021'  , 8, 'avril 2021','BDD', '15-04-2021', '8h00'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E22', 'CA2021'    ,  8, 'avril 2021','C' , '15-04-2021', '14h00'     );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E23', 'PHA2021'   , 10, 'avril 2021','PH' ,  '16-04-2021', '10h30'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E24', 'JA2021'    , 10, 'avril 2021','J' , '17-04-2021', '10h15'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E25', 'C2A2021'   , 10, 'avril 2021','C2'   , '18-04-2021', '15h15' );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E26', 'SIA2021'    , 10, 'avril 2021','SI' , '19-04-2021', '8h45'   );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E27', 'RA2021'     , 10, 'avril 2021','R' , '20-04-2021', '9h00'    );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E28', 'WEBA2021'    ,10, 'avril 2021','WEB' , '21-04-2021', '10h00'  );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E29', 'ARCHIA2021'   , 8, 'avril 2021','ARCHI', '22-04-2021', '14h30'  );
INSERT INTO epreuve (  code_epreuve , libelle_epreuve, note_min , nom_session, code_module, date_epreuve, heure  ) Values ('E30', 'MIA2021'     ,  8  , 'avril 2021','MI'  , '23-04-2021', '14h00'   );

--
-- Data for Name: passe
--
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'BoisA200' , 'E11', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'LavA200' , 'E12', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'BoisC100', 'E13', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'BoisC200', 'E14', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'LavC100' , 'E15', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'LavC200' , 'E16', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'BoisC100', 'E17', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'BoisC200', 'E18', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'LavC100' , 'E19', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,  'LavC200' , 'E20', 13);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01,'BoisA200' , 'E1' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'LavA200' , 'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'BoisC100', 'E3' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'BoisC200', 'E4' , 2.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'LavC100' , 'E5' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'LavC200' , 'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'BoisC100', 'E7' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'BoisC200', 'E8' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'LavC100' , 'E9' , 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (01, 'LavC200' , 'E10', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06,'BoisA200' , 'E1' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'LavA200' , 'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'BoisC100', 'E3' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'BoisC200', 'E4' , 2.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'LavC100' , 'E5' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'LavC200' , 'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'BoisC100', 'E7' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'BoisC200', 'E8' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'LavC100' , 'E9' , 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (06, 'LavC200' , 'E10', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13,'BoisA200' , 'E21', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'LavA200' , 'E22', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'BoisC100', 'E23', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'BoisC200', 'E24', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'LavC100' , 'E25', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'LavC200' , 'E26', 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'BoisC100', 'E27', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'BoisC200', 'E28', 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'LavC100' , 'E29', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (13, 'LavC200' , 'E30', 11);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19,'BoisA200' , 'E21', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'LavA200' , 'E22', 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'BoisC100', 'E23', 3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'BoisC200', 'E24', 3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'LavC100' , 'E25', 8);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'LavC200' , 'E26', 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'BoisC100', 'E27', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'BoisC200', 'E28', 6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'LavC100' , 'E29', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (19, 'LavC200' , 'E30', 13);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27,'BoisA200' ,'E11', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'LavA200' ,'E12', 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'BoisC100','E13', 11.4);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'BoisC200','E14', 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'LavC100' ,'E15', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'LavC200' ,'E16', 12.4);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'BoisC100','E17', 14.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'BoisC200','E18', 10.2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'LavC100' ,'E19', 9.4);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (27, 'LavC200' ,'E20', 14);


INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33,'BoisA200'  ,'E21', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'LavA200'  ,'E22', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'BoisC100' ,'E23', 14.25);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'BoisC200' ,'E24', 10.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'LavC100'  ,'E25', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'LavC200'  ,'E26', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'BoisC100' ,'E27', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'BoisC200' ,'E28', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'LavC100'  ,'E29', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (33, 'LavC200'  ,'E30', 19);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39,'BoisA200' , 'E11', 18.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'LavA200' , 'E12', 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'BoisC100', 'E13', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'BoisC200', 'E14', 18.9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'LavC100' , 'E15', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'LavC200' , 'E16', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'BoisC100', 'E17', 19.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'BoisC200', 'E18', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'LavC100' , 'E19', 14.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (39, 'LavC200' , 'E20', 15);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45,'BoisA200' , 'E1' , 0);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'LavA200' , 'E2' , 0.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'BoisC100', 'E3' , 10.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'BoisC200', 'E4' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'LavC100' , 'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'LavC200' , 'E6' , 9.3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'BoisC100', 'E7' , 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'BoisC200', 'E8' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'LavC100' , 'E9' , 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (45, 'LavC200' , 'E10', 10);




INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02, 'BoisA200' , 'E1' , 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'LavA200' , 'E2' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'BoisC100', 'E3' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'BoisC200', 'E4' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'LavC100' , 'E5' , 10.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'LavC200' , 'E6' , 4.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'BoisC100', 'E7' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'BoisC200', 'E8' , 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'LavC100' , 'E9' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (02,  'LavC200' , 'E10', 14.75);







INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03, 'BoisA200' , 'E1' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'LavA200' , 'E2' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'BoisC100', 'E3' , 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'BoisC200', 'E4' , 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'LavC100' , 'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'LavC200' , 'E6' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'BoisC100', 'E7' , 13.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'BoisC200', 'E8' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'LavC100' , 'E9' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (03,  'LavC200' , 'E10', 11);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04, 'BoisA200' , 'E21', 9.7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'LavA200' , 'E22', 7.8);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'BoisC100', 'E23', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'BoisC200', 'E24', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'LavC100' , 'E25', 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'LavC200' , 'E26', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'BoisC100', 'E27', 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'BoisC200', 'E28', 7.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'LavC100' , 'E29', 8.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (04,  'LavC200' , 'E30', 7.2);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10, 'BoisA200' ,'E1' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'LavA200' ,'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'BoisC100','E3' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'BoisC200','E4' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'LavC100' ,'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'LavC200' ,'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'BoisC100','E7' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'BoisC200','E8' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'LavC100' ,'E9' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (10,  'LavC200' ,'E10', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16, 'BoisA200' , 'E1' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'LavA200' , 'E2' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'BoisC100', 'E3' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'BoisC200', 'E4' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'LavC100' , 'E5' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'LavC200' , 'E6' , 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'BoisC100', 'E7' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'BoisC200', 'E8' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'LavC100' , 'E9' , 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (16,  'LavC200' , 'E10', 12);



INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14, 'BoisA200' , 'E1' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'LavA200' , 'E2' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'BoisC100', 'E3' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'BoisC200', 'E4' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'LavC100' , 'E5' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'LavC200' , 'E6' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'BoisC100', 'E7' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'BoisC200', 'E8' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'LavC100' , 'E9' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (14,  'LavC200' , 'E10', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34, 'BoisA200' , 'E11', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'LavA200' , 'E12', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'BoisC100', 'E13', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'BoisC200', 'E14', 8);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'LavC100' , 'E15', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'LavC200' , 'E16', 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'BoisC100', 'E17', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'BoisC200', 'E18', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'LavC100' , 'E19', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (34,  'LavC200' , 'E20', 10);




INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37, 'BoisA200' , 'E1' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'LavA200' , 'E2' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'BoisC100', 'E3' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'BoisC200', 'E4' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'LavC100' , 'E5' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'LavC200' , 'E6' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'BoisC100', 'E7' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'BoisC200', 'E8' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'LavC100' , 'E9' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (37,  'LavC200' , 'E10', 19);




INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38, 'BoisA200' , 'E21', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'LavA200' , 'E22', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'BoisC100', 'E23', 0.4);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'BoisC200', 'E24', 2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'LavC100' , 'E25', 6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'LavC200' , 'E26', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'BoisC100', 'E27', 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'BoisC200', 'E28', 8);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'LavC100' , 'E29', 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (38,  'LavC200' , 'E30', 11);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46, 'BoisA200'  , 'E21', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'LavA200'  , 'E22', 11.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'BoisC100' , 'E23', 6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'BoisC200' , 'E24', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'LavC100'  , 'E25', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'LavC200'  , 'E26', 6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'BoisC100' , 'E27', 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'BoisC200' , 'E28', 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'LavC100'  , 'E29', 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (46,  'LavC200'  , 'E30', 8);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47, 'BoisA200'  ,'E11', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'LavA200'  ,'E12', 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'BoisC100' ,'E13', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'BoisC200' ,'E14', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'LavC100'  ,'E15', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'LavC200'  ,'E16', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'BoisC100' ,'E17', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'BoisC200' ,'E18', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'LavC100'  ,'E19', 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (47,  'LavC200'  ,'E20', 11);




INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23, 'BoisA200'  , 'E1' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'LavA200'  , 'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'BoisC100' , 'E3' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'BoisC200' , 'E4' , 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'LavC100'  , 'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'LavC200'  , 'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'BoisC100' , 'E7' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'BoisC200' , 'E8' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'LavC100'  , 'E9' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (23,  'LavC200'  , 'E10', 13);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30,'BoisA200'   , 'E1' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'LavA200'   , 'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'BoisC100'  , 'E3' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'BoisC200'  , 'E4' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'LavC100'   , 'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'LavC200'   , 'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'BoisC100'  , 'E7' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'BoisC200'  , 'E8' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'LavC100'   , 'E9' , 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (30, 'LavC200'   , 'E10', 2);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36,'BoisA200'   , 'E11',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'LavA200'   , 'E12',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'BoisC100'  , 'E13',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'BoisC200'  , 'E14',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'LavC100'   , 'E15',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'LavC200'   , 'E16',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'BoisC100'  , 'E17',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'BoisC200'  , 'E18',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'LavC100'   , 'E19',15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (36, 'LavC200'   , 'E20',15.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41, 'BoisA200'  ,'E1' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'LavA200'  ,'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'BoisC100' ,'E3' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'BoisC200' ,'E4' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'LavC100'  ,'E5' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'LavC200'  ,'E6' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'BoisC100' ,'E7' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'BoisC200' ,'E8' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'LavC100'  ,'E9' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (41,  'LavC200'  ,'E10', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48, 'BoisA200'  , 'E11', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'LavA200'  , 'E12', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'BoisC100' , 'E13', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'BoisC200' , 'E14', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'LavC100'  , 'E15', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'LavC200'  , 'E16', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'BoisC100' , 'E17', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'BoisC200' , 'E18', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'LavC100'  , 'E19', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (48,  'LavC200'  , 'E20', 15.5);


INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11, 'BoisA200'  , 'E11', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'LavA200'  , 'E12', 0);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'BoisC100' , 'E13', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'BoisC200' , 'E14', 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'LavC100'  , 'E15', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'LavC200'  , 'E16', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'BoisC100' , 'E17', 0.9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'BoisC200' , 'E18', 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'LavC100'  , 'E19', 2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (11,  'LavC200'  , 'E20', 13);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17, 'BoisA200'  ,'E1' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'LavA200'  ,'E2' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'BoisC100' ,'E3' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'BoisC200' ,'E4' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'LavC100'  ,'E5' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'LavC200'  ,'E6' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'BoisC100' ,'E7' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'BoisC200' ,'E8' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'LavC100'  ,'E9' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (17,  'LavC200'  ,'E10', 16);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21, 'BoisA200'  , 'E1' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'LavA200'  , 'E2' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'BoisC100' , 'E3' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'BoisC200' , 'E4' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'LavC100'  , 'E5' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'LavC200'  , 'E6' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'BoisC100' , 'E7' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'BoisC200' , 'E8' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'LavC100'  , 'E9' , 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (21,  'LavC200'  , 'E10', 20);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25, 'BoisA200'  ,'E11', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'LavA200'  ,'E12', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'BoisC100' ,'E13', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'BoisC200' ,'E14', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'LavC100'  ,'E15', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'LavC200'  ,'E16', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'BoisC100' ,'E17', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'BoisC200' ,'E18', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'LavC100'  ,'E19', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (25,  'LavC200'  ,'E20', 14.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26,'BoisA200'   , 'E21', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'LavA200'   , 'E22', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'BoisC100'  , 'E23', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'BoisC200'  , 'E24', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'LavC100'   , 'E25', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'LavC200'   , 'E26', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'BoisC100'  , 'E27', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'BoisC200'  , 'E28', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'LavC100'   , 'E29', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (26, 'LavC200'   , 'E30', 15.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29,'BoisA200'   , 'E1' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'LavA200'   , 'E2' , 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'BoisC100'  , 'E3' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'BoisC200'  , 'E4' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'LavC100'   , 'E5' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'LavC200'   , 'E6' , 15.2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'BoisC100'  , 'E7' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'BoisC200'  , 'E8' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'LavC100'   , 'E9' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (29, 'LavC200'   , 'E10', 15.3);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32,'BoisA200'   , 'E21', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'LavA200'   , 'E22', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'BoisC100'  , 'E23', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'BoisC200'  , 'E24', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'LavC100'   , 'E25', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'LavC200'   , 'E26', 10.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'BoisC100'  , 'E27', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'BoisC200'  , 'E28', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'LavC100'   , 'E29', 9.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (32, 'LavC200'   , 'E30', 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40,'BoisA200'   ,  'E11', 16.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'LavA200'   ,  'E12', 18.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'BoisC100'  ,  'E13', 16.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'BoisC200'  ,  'E14', 16.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'LavC100'   ,  'E15', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'LavC200'   ,  'E16', 16.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'BoisC100'  ,  'E17', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'BoisC200'  ,  'E18', 16.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'LavC100'   ,  'E19', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (40, 'LavC200'   ,  'E20', 16.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42,'BoisA200'   ,'E21', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'LavA200'   ,'E22', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'BoisC100'  ,'E23', 12.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'BoisC200'  ,'E24', 15.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'LavC100'   ,'E25', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'LavC200'   ,'E26', 14.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'BoisC100'  ,'E27', 15.25);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'BoisC200'  ,'E28', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'LavC100'   ,'E29', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (42, 'LavC200'   ,'E30', 19.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43,'BoisA200'  ,'E11', 12.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'LavA200'  ,'E12', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'BoisC100' ,'E13', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'BoisC200' ,'E14', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'LavC100'  ,'E15', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'LavC200'  ,'E16', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'BoisC100' ,'E17', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'BoisC200' ,'E18', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'LavC100'  ,'E19', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (43, 'LavC200'  ,'E20', 1);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05,'BoisA200' ,'E1'  , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'LavA200' ,'E2'  , 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'BoisC100','E3'  , 9.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'BoisC200','E4'  , 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'LavC100' ,'E5'  , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'LavC200' ,'E6'  , 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'BoisC100','E7'  , 14);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'BoisC200','E8'  , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'LavC100' ,'E9'  , 8);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (05, 'LavC200' ,'E10' , 9.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08,'BoisA200' ,'E11', 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'LavA200' ,'E12', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'BoisC100','E13', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'BoisC200','E14', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'LavC100' ,'E15', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'LavC200' ,'E16', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'BoisC100','E17', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'BoisC200','E18', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'LavC100' ,'E19', 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (08, 'LavC200' ,'E20', 16);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15, 'BoisA200' ,'E21', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'LavA200' ,'E22', 11.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'BoisC100','E23', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'BoisC200','E24', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'LavC100' ,'E25', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'LavC200' ,'E26', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'BoisC100','E27', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'BoisC200','E28', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'LavC100' ,'E29', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (15,  'LavC200' ,'E30', 13);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18, 'BoisA200' ,'E11', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'LavA200' ,'E12', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'BoisC100','E13', 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'BoisC200','E14', 12.23);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'LavC100' ,'E15', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'LavC200' ,'E16', 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'BoisC100','E17', 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'BoisC200','E18', 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'LavC100' ,'E19', 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (18,  'LavC200' ,'E20', 12);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20, 'BoisA200' ,'E1' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'LavA200' ,'E2' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'BoisC100','E3' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'BoisC200','E4' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'LavC100' ,'E5' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'LavC200' ,'E6' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'BoisC100','E7' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'BoisC200','E8' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'LavC100' ,'E9' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (20,  'LavC200' ,'E10', 12);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22, 'BoisA200' , 'E21', 9.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'LavA200' , 'E22', 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'BoisC100', 'E23', 9.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'BoisC200', 'E24', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'LavC100' , 'E25', 10.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'LavC200' , 'E26', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'BoisC100', 'E27', 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'BoisC200', 'E28', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'LavC100' , 'E29', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (22,  'LavC200' , 'E30', 19.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44,'BoisA200' , 'E1' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'LavA200' , 'E2' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'BoisC100', 'E3' , 3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'BoisC200', 'E4' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'LavC100' , 'E5' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'LavC200' , 'E6' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'BoisC100', 'E7' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'BoisC200', 'E8' , 3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'LavC100' , 'E9' , 5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (44, 'LavC200' , 'E10', 12);



INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07, 'BoisA200' , 'E21' , 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'LavA200' , 'E22' , 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'BoisC100', 'E23' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'BoisC200', 'E24' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'LavC100' , 'E25' , 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'LavC200' , 'E26' , 16.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'BoisC100', 'E27' , 18.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'BoisC200', 'E28' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'LavC100' , 'E29' , 15.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (07,  'LavC200' , 'E30' , 15.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09, 'BoisA200' , 'E21' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'LavA200' , 'E22' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'BoisC100', 'E23' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'BoisC200', 'E24' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'LavC100' , 'E25' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'LavC200' , 'E26' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'BoisC100', 'E27' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'BoisC200', 'E28' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'LavC100' , 'E29' , 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (09,  'LavC200' , 'E30' , 15);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12, 'BoisA200' , 'E1' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'LavA200' , 'E2' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'BoisC100', 'E3' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'BoisC200', 'E4' , 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'LavC100' , 'E5' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'LavC200' , 'E6' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'BoisC100', 'E7' , 1);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'BoisC200', 'E8' , 11.3);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'LavC100' , 'E9' , 1.2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (12,  'LavC200' , 'E10', 12);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,'BoisA200' ,  'E21', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,'LavA200' ,  'E22', 8.9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,'BoisC100',  'E23', 8.6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'BoisC200',  'E24', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'LavC100' ,  'E25', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'LavC200' ,  'E26', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'BoisC100',  'E27', 8.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'BoisC200',  'E28', 9);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'LavC100' ,  'E29', 6);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (24,  'LavC200' ,  'E30', 8.5);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28,'BoisA200' , 'E21' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28,'LavA200' , 'E22' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28,'BoisC100', 'E23' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28,'BoisC200', 'E24' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28,'LavC100' , 'E25' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28, 'LavC200' , 'E26' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28, 'BoisC100', 'E27' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28, 'BoisC200', 'E28' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28, 'LavC100' , 'E29' , 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (28, 'LavC200' , 'E30' , 10);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'BoisA200' ,  'E1' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'LavA200' ,  'E2' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'BoisC100',  'E3' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'BoisC200',  'E4' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'LavC100' ,  'E5' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'LavC200' ,  'E6' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'BoisC100',  'E7' , 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'BoisC200',  'E8' , 16);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'LavC100' ,  'E9' , 17.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (31,'LavC200' ,  'E10', 17);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35,'BoisA200' , 'E11', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'LavA200' , 'E12', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'BoisC100', 'E13', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'BoisC200', 'E14', 7);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'LavC100' , 'E15', 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'LavC200' , 'E16', 2.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'BoisC100', 'E17', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'BoisC200', 'E18', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'LavC100' , 'E19', 2.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (35, 'LavC200' , 'E20', 6.3);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49, 'BoisA200' ,  'E1', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'LavA200' ,  'E2', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'BoisC100',  'E3', 9.55);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'BoisC200',  'E4', 10);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'LavC100' ,  'E5', 7.5);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'LavC200' ,  'E6', 2);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'BoisC100',  'E7', 0.25);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'BoisC200',  'E8', 18);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'LavC100' ,  'E9', 20);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (49,  'LavC200' ,  'E10', 12);

INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50, 'BoisA200' ,  'E1' , 13);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'LavA200' ,  'E2' , 12.75);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'BoisC100',  'E3' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'BoisC200',  'E4' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'LavC100' ,  'E5' , 19);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'LavC200' ,  'E6' , 17);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'BoisC100',  'E7' , 12);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'BoisC200',  'E8' , 11);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'LavC100' ,  'E9' , 15);
INSERT INTO passe ( id_candidat, num_salle, code_epreuve, note) VALUES  (50,  'LavC200' ,  'E10', 12.3);

--
-- Data for Name: corrige
--

INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E1'  , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E2'    , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E2'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E3', 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E4'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E5'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E6'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E7'   , 3);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E8'   , 4);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E9'    , 5);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E10'  , 5);

INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E11'  , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E12'    , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E12'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E13', 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E14'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E15'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E16'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E17'   , 3);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E18'   , 4);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E19'    , 5);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E20'  , 5);

INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E21'  , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E22'    , 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E22'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E23', 1);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E24'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E25'    , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E26'   , 2);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E27'   , 3);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E28'   , 4);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E29'    , 5);
INSERT INTO corrige( code_epreuve, id_surveillant) VALUES ( 'E30'  , 5);


--
-- Data for Name: surveille
--

INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E11' , 1, 'BoisA200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E11' , 2, 'BoisA200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E12'   , 3,  'LavA200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E12'   , 4,  'LavA200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E13', 3, 'BoisC100');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E13', 1, 'BoisC100');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E14'  , 4,  'BoisC200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E15'   , 5,  'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E15'   , 7,  'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E16'  , 6,  'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E16'  , 4,  'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E17'  , 7,  'BoisC100');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E17'  , 8,  'BoisC100');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E18'  , 8,  'BoisC200');
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E19'   , 9,  'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E19'   , 10,  'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E20' , 10, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E20' , 6, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E1' , 5, 'BoisB200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E1' , 1, 'BoisB200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E2' , 8, 'LavA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E2' , 4, 'LavA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E3' , 1, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E3' , 2, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E4' , 3, 'BoisC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E5' , 7, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E5' , 9, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E6' , 2, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E6' , 5, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E7' , 1, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E7' , 3, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E8' , 7, 'BoisC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E9' , 9, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E9' , 8, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E10' , 5, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E10' , 1, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E21' , 6, 'BoisA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E21' , 10, 'BoisA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E22' , 1, 'LavA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E22' , 4, 'LavA200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E23' , 5, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E23' , 9, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E24' , 6, 'BoisC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E25' , 7, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E25' , 2, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E26' , 8, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E26' , 10, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E27' , 6, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E27' , 9, 'BoisC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E28' , 3, 'BoisC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E29' , 1, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E29' , 5, 'LavC100' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E30' , 9, 'LavC200' );
INSERT INTO surveille (code_epreuve, id_surveillant, num_salle) VALUES ('E30' , 8, 'LavC200' );




INSERT INTO inscrit (id_candidat,nom_session) VALUES (1, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (1, 'janvier 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (2, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (3, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (4, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (5, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (6, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (7, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (8, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (9, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (10,'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (11,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (12,'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (13, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (14,'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (15,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (16, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (17, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (18, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (19,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (20,'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (21, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (22,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (23, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (24, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (25, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (26, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (27, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (28, 'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (29, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (30,'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (31,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (32, 'janvier 2020' );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (33,'avril 2021'   );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (34, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (35, 'mai 2020'     );   
INSERT INTO inscrit (id_candidat,nom_session) VALUES (36,'avril 2021'   );
INSERT INTO inscrit (id_candidat,nom_session) VALUES (37, 'janvier 2020' );
INSERT INTO inscrit (id_candidat,nom_session) VALUES (38, 'avril 2021'   );
INSERT INTO inscrit (id_candidat,nom_session) VALUES (39,'mai 2020'     );
INSERT INTO inscrit (id_candidat,nom_session) VALUES (40,  'mai 2020'    );
INSERT INTO inscrit (id_candidat,nom_session) VALUES (41, 'janvier 2020');
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 42,'avril 2021'  );
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 43, 'mai 2020'   );
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 44, 'janvier 2020');
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 45, 'janvier 2020');
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 46, 'avril 2021'  );
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 47,'mai 2020'    );
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 48,'mai 2020'    );
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 49,'janvier 2020');
INSERT INTO inscrit (id_candidat,nom_session) VALUES ( 50,'janvier 2020');



 create view candidat_inscrit(inscrit, nom_session, date_session)as(select count(id_candidat), nom_session , date_session from inscrit natural join session group by nom_session, date_session);

create view reussi(reussi, nom_session, date_session)as(select id_candidat ,nom_session, date_session from candidat natural join passe natural join session natural join epreuve where note>= note_min group by id_candidat, nom_session, date_session having count(code_epreuve) = 10);
create view moyenne(moyenne, nom_session, date_session)as( select avg(note),nom_session, date_session from passe natural join session natural join epreuve group by nom_session, date_session);
create view histSession as ( select nom_session, date_session,count(reussi) as reussi, inscrit, moyenne from moyenne natural join reussi natural join candidat_inscrit group by nom_session, date_session, inscrit, moyenne);


--
-- Data for Name: authentification
--
INSERT INTO authentification (login , motdepasse) VALUES ( 'masson.jules', md5('masson.2001'));

--
-- Data for Name: admin
--
INSERT INTO admin (login , motdepasse) VALUES ( 'admin', md5('admin'));
