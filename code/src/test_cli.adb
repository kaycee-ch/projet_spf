with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with parser; use parser;
with cli; use cli;

procedure test_cli is
   choix : Character;
Begin
   choix := afficher_menu;
   traiter_choix(choix);
end test_cli;
