with ada.strings.Unbounded; use ada.strings.Unbounded;
with parser; use parser;
with sgf; use sgf;

package IHM is

   commande_inconnu : EXCEPTION;

   procedure traiter_cmd(le_sgf : in out T_sgf; cmd : in T_COMMAND);
   -- semantique : cette procedure analyse le choix et appelle la proc�dure de traitement associ� � une commande bien pr�cise
   -- pre : none
   -- post : none
   -- exception : commande_inconnu : l'utilisateur tape un caract�re inconnu


   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character);
   -- semantique : cette procedure analyse le choix et appelle la proc�dure de traitement associ� � une commande bien pr�cise
   -- pre : none
   -- post : none
   -- exception : commande_inconnu : l'utilisateur tape un caract�re inconnu


   procedure traiter_ls (le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_command; path : in out T_path);
   -- semantique : cette procedure permet, en fonction des options de l'utilisateur, diff�rents types d'affichage de l'arbre de fichiers
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_nano (le_sgf : in out T_sgf; menu : in Boolean; existe : in Boolean; cmd : in T_command; path : in out T_path);
   -- semantique : cette procedure permet de cr�er un fichier ou de modifier un fichier pr� existant (uniquement avec le menu)
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_mkdir(le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);
   -- semantique : cette procedure permet de cr�er un dossier
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none

   procedure traiter_cd(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);
   -- semantique : cette procedure permet de changer le changement du working directory
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_tar(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);
   -- semantique : cette procedure permet l'archivage d'un dossier
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none

   procedure traiter_cat(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);
   -- semantique : cette procedure permet l'affichage d'un fichier pr� �xistant
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_rm(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);
   -- semantique : cette procedure permet, en fonction des options de l'utilisateur, de supprimer un fichier ou un dossier
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_chmod(le_sgf : in out T_SGF; cmd : in T_COMMAND; path : in out T_PATH);
   -- semantique : cette procedure permet de modifier les droits/permissions d'un dossier
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_rename(le_sgf : in out T_SGF; cmd : in T_COMMAND; path : in out T_PATH);
   -- semantique : cette procedure permet de renommer un dossier
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_cp(le_sgf : in out T_sgf; cmd : in T_command; path : in out T_path);
   -- semantique : cette procedure permet de copier un dossier du r�pertoire courant vers un r�pertoire destination
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure traiter_mv(le_sgf : in out T_sgf; cmd : in T_command; path : in out T_path);
   -- semantique : cette procedure permet de d�placer un dossier du r�pertoire courant vers un r�pertoire destination (les fichies et sous dossiers ne seront pas d�plac�s)
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


   procedure help(commande : in Unbounded_String);
   -- semantique : cette procedure sert de dictionnaire, l'utilisateur peut faire <commande> --help et avoir plus d'informations sur une des commandes expliqu�es dans cette proc�dure
   -- pre : le_sgf a �t� initialis�
   -- post : none
   -- exception : none


end IHM;
