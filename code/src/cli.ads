with sgf; use sgf;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package CLI is

   quitte : boolean := false;


   procedure afficher_menu(le_sgf : in out T_sgf);
   procedure saisie_libre(le_sgf : in out T_sgf);
   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character);


end CLI;
