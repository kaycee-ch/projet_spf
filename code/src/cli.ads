with sgf; use sgf;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package CLI is

   quitte : boolean := false;
   -- menu : Boolean := false;
   function affichage_deb return Boolean;
   procedure afficher_menu (choix : out Character);
   procedure saisie_libre(le_sgf : in out T_sgf);
   procedure menu(le_sgf : in out T_sgf; choix : in Character);


end CLI;
