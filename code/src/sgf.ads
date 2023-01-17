with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_arbre;


package sgf is

   TYPE T_info is record
      name : Unbounded_String;
      isFile : Boolean;
      droits : Unbounded_String;
      taille : Integer;
   end record;

   package P_sgf is new P_arbre(T_contenu => T_info);
   use P_sgf;



   procedure formatage_disque(arbre : in out T_arbre; noeud_courant : out T_arbre; data : in T_info);
   -- semantique : creation d'un SGF ne contenant que le dossier racine
   -- pre : none
   -- post : le SGF est cree et le répertoire courant est root
   -- exception : none


   function repo_courant(noeud_courant : in T_arbre) return T_arbre;
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


   procedure creer_fichier(noeud_courant : in T_arbre; arbre : in out T_arbre; path : in String; name : in String);
   -- semantique : creation d'un fichier dans le dossier courant
   -- pre : si le chemin est différent du cd, le path existe
   -- post : fichier cree avec le nom name
   -- exception : filename_unavailable : un fichier du meme nom existe deja dans le cd


   -- procedure creer_dossier(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String; name : in String; dir_info : in out T_info);
   -- semantique : creation d'un répertoire vide (mkdir)
   -- pre : si le chemin est différent du cd, le path existe
   -- post : dossier creer avec le nom name
   -- exception : dirname_unavailable : un dossier du meme nom existe deja dans le cd


   -- procedure modifier_fichier(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String; file_contenu : in out String; file_info : in out T_info);
   -- semantique : modification de la taille d'un fichier resultat de l'utilisation d'un éditeur de texte
   -- pre : fusion avec creer_fichier et file_contenu vide ou pas ?
   -- post :
   -- exception :


   -- procedure change_dir(noeud_courant : in out T_arbre; arbre : in out T_arbre; old_path : in String; new_path : in String);
   -- semantique : changement du repertoire courant en précisant le chemin du nouveau répertoire courant (cd)
   -- pre :
   -- post :
   -- exception


   -- procedure liste_contenu_dir(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String);
   --semantique : affichage du contenu, fichiers et repertoires, du repertoire designe par un chemin.

   -- pre :
   -- post :
   -- exception :


   -- procedure liste_contenu_all(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String);
   -- semantique : affichage des fichiers et des repertoires du repertoire courant et de tous les fichiers et repertoires de tous les sous-repertoires (ls -r)
   -- fusion avec liste_contenu_dir avec un booleén si on veut lister les fils des dossiers ?
   -- pre :
   -- post :
   -- exception :


   -- procedure suppr_fichier;
   -- semantique : suppression d'un fichier (rm)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action


   -- procedure suppr_dir;
   -- semantique : suppression d'un repertoire qu'il soit vide ou non (rm -r)
   -- pre : le noeud existe
   -- post : le noeud n'est plus dans l'arbre
   -- exception : droit_insufisant : l'utilisateur n'a pas les droits nécessaires pour cette action


   -- procedure move_fichier;
   -- semantique : deplacement (et renommage) eventuel d'un fichier (mv)


   -- procedure copy_fichier;
   -- semantique : copie d'un fichier ou d'un repertoire (cp -r)


   -- procedure archiver_dir;

   -- un unique fichier dont la taille est la somme des tailles des fichiers contenus dans ce repertoire et ses sous-repertoires (tar)

  function get_name (ab : in T_arbre) return Unbounded_String;




end sgf;
