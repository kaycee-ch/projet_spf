with sgf; use sgf;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package CLI is

   quitte : boolean := false;

   function affichage_deb return Boolean;
   --semantique : cette fonction permet l'affichage du premier choix menu ou saisie libre et renvoie un booléen vrai si l'utilisateur choisit le menu
   -- pre : none
   -- post : none
   -- exception : none


   procedure afficher_menu (choix : out Character);
   -- semantique : cette procédure permet l'affichage du menu des commandes disponibles à l'utilisateur et récupère le caractère correspondant au choix de l'utilisateur
   -- pre : none
   -- post : none
   -- exception : none


   procedure saisie_libre(le_sgf : in out T_sgf);
   -- semantique : cette procedure récupère la ligne, analyse le mot de commande et appelle la procédure de traitement de commande de l'IHM
   -- pre : none
   -- post : none
   -- exception : none


   procedure menu(le_sgf : in out T_sgf; choix : in Character);
   -- semantique : cette procédure appelle la procédure de traitement de choix de l'IHM
   -- pre : none
   -- post : none
   -- exception : none


end CLI;
