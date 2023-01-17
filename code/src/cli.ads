
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package CLI is

   function afficher_menu return Character;
   procedure traiter_choix (choix : in Character);

end CLI;
