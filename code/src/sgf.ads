with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_arbre;
with parser; use parser;
with pile_gen;
with p_liste_gen;


package sgf is

   chemin_invalide : EXCEPTION;
   arbre_vide : EXCEPTION;

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

   TYPE T_sgf is record
      root : T_arbre;
      noeud_courant : T_arbre;
      nom : Unbounded_String;
      end record;


   package P_pile is new pile_gen(un_type => Unbounded_String);
   use P_pile;

   package liste_enf is new p_liste_gen(T_type => T_arbre);

   procedure print_str (data : in T_info; indent : in Integer);

   procedure print_all(data : in T_info; indent : In Integer);

   -- function cherche is new P_sgf.find;

   -- procedure rm is new P_sgf.remove(chercher => cherche);

   procedure affiche_simple is new P_sgf.print(afficher_noeud => print_str);
   procedure affiche_detail is new P_sgf.print(afficher_noeud => print_all);

   -- procedure find_child is new P_sgf.cherche_enfant;

   function is_equal (a : in T_arbre; b : in T_arbre) return Boolean;




   procedure formatage_disque (sgf : in out T_sgf);
   -- semantique : creation d'un SGF ne contenant que le dossier racine
   -- pre : none
   -- post : le SGF est cree et le répertoire courant est root
   -- exception : none


   function repo_courant (sgf : in out T_sgf) return Unbounded_String;
   -- semantique : obtention du repertoire de travail ou repertoire courant (pwd)
   -- pre : arbre a ete initialise
   -- post : none
   -- exception : none


   -- exception : path_invalid : le chemin ne mene a aucun noeud de l'arbre


   procedure creer_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; estFichier : in Boolean; existe : in Boolean);
   -- semantique : creation d'un fichier dans le dossier courant
   -- pre : si le chemin est différent du cd, le path existe
   -- post : fichier cree avec le nom name
   -- exception : filename_unavailable : un fichier du meme nom existe deja dans le cd

   -- semantique : creation d'un répertoire vide (mkdir)
   -- pre : si le chemin est différent du cd, le path existe
   -- post : dossier creer avec le nom name
   -- exception : dirname_unavailable : un dossier du meme nom existe deja dans le cd

   -- semantique : modification de la taille d'un fichier resultat de l'utilisation d'un éditeur de texte
   -- pre : fusion avec creer_fichier et file_contenu vide ou pas ?
   -- post :
   -- exception :



   procedure change_dir(sgf : in out T_sgf; destination : in T_PATH);
   -- semantique : changement du repertoire courant en précisant le chemin du nouveau répertoire courant (cd)
   -- pre :
   -- post :
   -- exception

   procedure affiche_fichier(sgf : in out T_sgf; path : in T_path);

   procedure liste_contenu(sgf : in out T_sgf; path : in T_PATH; dir_fils : in Boolean; all_info : in Boolean) ;
   --semantique : affichage du contenu, fichiers et repertoires, du repertoire designe par un chemin.

   -- pre :
   -- post :
   -- exception :

   -- semantique : affichage des fichiers et des repertoires du repertoire courant et de tous les fichiers et repertoires de tous les sous-repertoires (ls -r)
   -- fusion avec liste_contenu_dir avec un booleén si on veut lister les fils des dossiers ?
   -- pre :
   -- post :
   -- exception :


   procedure supp_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; isFile : in Boolean);
   -- semantique : suppression d'un fichier (rm)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action

   -- semantique : suppression d'un repertoire qu'il soit vide ou non (rm -r)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action


   procedure copy_move(sgf : in out T_sgf; old_path : in T_PATH; new_path : in T_PATH; isFile : in Boolean; copy : in Boolean);
   -- semantique : copie d'un fichier ou d'un repertoire (cp -r)


   procedure archive_dir (sgf : in out T_sgf; path : in T_PATH);

   -- un unique fichier dont la taille est la somme des tailles des fichiers contenus dans ce repertoire et ses sous-repertoires (tar)


   procedure test(sgf : in out T_sgf);

end sgf;
