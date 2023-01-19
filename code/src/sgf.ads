with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_arbre;
with parser; use parser;


package sgf is


   TYPE T_info is record
      name : Unbounded_String := To_Unbounded_String("No_name");
      isFile : Boolean := true;
      droits : Unbounded_String := To_Unbounded_String("None");
      taille : Integer := 0;
      contenu : Unbounded_String; -- := To_Unbounded_String("null");
   end record;

   package P_sgf is new P_arbre(T_contenu => T_info);
   use P_sgf;

   function cmp_name (x : in T_info; y : in T_info) return Boolean;

   function cherche is new P_sgf.find(is_equals => cmp_name);


   arbre, noeud_courant : T_arbre;

   procedure formatage_disque;
   -- semantique : creation d'un SGF ne contenant que le dossier racine
   -- pre : none
   -- post : le SGF est cree et le répertoire courant est root
   -- exception : none


   function repo_courant return Unbounded_String;
   -- semantique : obtention du repertoire de travail ou repertoire courant (pwd)
   -- pre : arbre a ete initialise
   -- post : none
   -- exception : none


   -- function get_path(noeud_courant : in T_arbre; path : in String; long_path : in Natural) return T_arbre;
   -- semantique : transforme le chemin saisi en addresse du noeud correspondant
   -- si le chemin est relatif, il le transforme d'abbord en chemin absolu
   -- pre : none
   -- post : none
   -- exception : path_invalid : le chemin ne mene a aucun noeud de l'arbre


   procedure creer_fichier_dossier(path : in T_PATH; estFichier : in Boolean; existe : in Boolean);
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



   procedure change_dir(destination : in T_PATH);
   -- semantique : changement du repertoire courant en précisant le chemin du nouveau répertoire courant (cd)
   -- pre :
   -- post :
   -- exception


   -- procedure liste_contenu_dir(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String);
   --semantique : affichage du contenu, fichiers et repertoires, du repertoire designe par un chemin.

   -- pre :
   -- post :
   -- exception :

   -- semantique : affichage des fichiers et des repertoires du repertoire courant et de tous les fichiers et repertoires de tous les sous-repertoires (ls -r)
   -- fusion avec liste_contenu_dir avec un booleén si on veut lister les fils des dossiers ?
   -- pre :
   -- post :
   -- exception :


   procedure supp_fichier_dossier(path : in T_PATH);
   -- semantique : suppression d'un fichier (rm)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action

   -- semantique : suppression d'un repertoire qu'il soit vide ou non (rm -r)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action


   -- procedure move_fichier;
   -- semantique : deplacement (et renommage) eventuel d'un fichier (mv)


   -- procedure copy_fichier;
   -- semantique : copie d'un fichier ou d'un repertoire (cp -r)


   procedure archive_dir (path : in T_PATH);

   -- un unique fichier dont la taille est la somme des tailles des fichiers contenus dans ce repertoire et ses sous-repertoires (tar)


   procedure test (ab : in out T_arbre; noeud : in out T_arbre);

end sgf;
