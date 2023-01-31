with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_arbre;
with parser; use parser;
with pile_gen;


package sgf is

   chemin_invalide : EXCEPTION;
   arbre_vide : EXCEPTION;
   stockage_plein, tar_file, no_folder, cannot_print, droit_insuffisant : EXCEPTION;

   TYPE T_info is record
      name : Unbounded_String;
      isFile : Boolean;
      droits : Integer;
      taille : Integer;
      contenu : Unbounded_String;
   end record;

   function cmp_name (x : in T_info; y : in T_info) return Boolean;

   package P_sgf is new P_arbre(T_contenu => T_info, is_equals => cmp_name);
   use P_sgf;

   TYPE T_sgf is private;

   package P_pile is new pile_gen(un_type => Unbounded_String);
   use P_pile;



   procedure print_simpl (data : in T_info; indent : in Integer);

   procedure print_enf_tree(data : in T_info; indent : in Integer);

   procedure print_all (data : in T_info; indent : in Integer);

   procedure affiche_enf_det is new P_sgf.print_just(afficher_noeud => print_all);

   procedure affiche_simpl is new P_sgf.print_just(afficher_noeud => print_simpl);

   procedure affiche_enf_tree is new P_sgf.print_every(afficher_noeud => print_enf_tree);

   procedure affiche_all is new P_sgf.print_every(afficher_noeud => print_all);


   function is_equal (a : in T_arbre; b : in T_arbre) return Boolean;




   procedure formatage_disque (sgf : in out T_sgf);
   -- semantique : creation d'un SGF ne contenant que le dossier racine, efface tout le contenu du sgf s'il y en a
   -- pre : none
   -- post : sgf.root = sgf.noeud_courant = \
   -- exception : none


   function repo_courant (sgf : in out T_sgf) return T_path;
   -- semantique : obtention du repertoire de travail ou repertoire courant (pwd)
   -- pre : sgf initialisé
   -- post : none
   -- exception : none


   procedure print_repo(sgf : in T_sgf);
   -- semantique : impression du repertoire de travail ou repertoire courant (pwd)
   -- pre : sgf initialisé
   -- post : none
   -- exception : none


   procedure creer_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; estFichier : in Boolean; existe : in Boolean);
   -- semantique : creation d'un fichier ou dossier au path passé en paramètre
   -- pre : sgf initialisé
   -- post : none
   -- exception : stockage_plein si le répertoire est déja à 10Go (idealement devrait aussi il y avoir name_unavailable si un fichier/dossier du meme nom existe déja dans le répertiire destination)



   procedure change_dir(sgf : in out T_sgf; destination : in T_PATH);
   -- semantique : changement du repertoire courant en précisant le chemin du nouveau répertoire courant (cd)
   -- pre : sgf initialisé
   -- post : repo_courant(sgf) = destination
   -- exception : chemin_invalide si le chemin est invalide



   procedure affiche_fichier(sgf : in out T_sgf; path : in T_path);
   -- semantique : affiche le contenu d'un fichier préexistant
   -- pre : sgf initialisé
   -- post : none
   -- exception : cannot_print si le fichier n'existe pas



   procedure liste_contenu(sgf : in out T_sgf; path : in T_PATH; dir_fils : in Boolean; all_info : in Boolean) ;
   --semantique : affichage de plus ou moins d'infos concernant les fichiers/dossiers en fonction des arguments de l'utilisateur
   -- pre : sgf initialisé
   -- post : none
   -- exception : none


   procedure supp_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; isFile : in Boolean);
   -- semantique : suppression d'un fichier (rm)
   -- pre : sgf initialise
   -- post : none
   -- exception : chemin_invalide si le fichier/dossier n'existe pas, droit_insufisant : le code permission du dossier ne permet pas sa suppression (il faut le code 111)


   procedure change_droits(sgf : in out T_sgf; path : in T_path; n : in Integer);
   -- semantique : cette procedure permet la modification des droits d'un dossier (la suppression d'un dossier requiert les permissions 111)
   -- pre : sgf initialisé
   -- post : none
   -- exception : none


   procedure change_name (sgf : in out T_SGF; path : in T_PATH; name : in Unbounded_String);
   -- cette procedure permet la modifictaion du nom d'un dossier
   -- pre : sgf initialise
   -- post : none
   -- exception : none (idealement name_unavailable si un dossier du meme nom existe deja dans le répertoire destination)


   procedure archive_dir (sgf : in out T_sgf; path : in T_PATH);
   -- cette procedure permet la compression d'un dossier
   -- pre : sgf initialise
   -- post : none
   -- exception : tar_file si ce n'est pas un dossier au bout du chemin


   function stockage_occupe(sgf : in out T_SGF) return Integer;
   -- cette procedure permet de connaitre le stockage occupé du sgf
   -- pre : sgf initialise
   -- post : none
   -- exception : none

   procedure copy_move(sgf : in out T_sgf; path : in T_path; name : in out Unbounded_String; move : in Boolean);
   -- cette procedure permet le déplacement ou la copie d'un dossier du répertoire courant vers une destination
   -- pre : sgf initialise
   -- post : none
   -- exception : chemin_invalide si ce n'est pa sun odssier au bour du chemin et no_folder s'il n'y a pas de dossier du nom indiqué dans le répertoire courant

   procedure test(sgf : in out T_sgf);

private
   TYPE T_sgf is record
      root : T_arbre;
      noeud_courant : T_arbre;
      nom : Unbounded_String;
      taille : Integer; -- 1 Go max
   end record;

end sgf;
