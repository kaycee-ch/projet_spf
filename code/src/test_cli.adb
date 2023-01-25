with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.text_io; use ada.text_io;
with parser; use parser;
with cli; use cli;
with ihm; use ihm;
with sgf; use sgf;

procedure test_cli is
   -- choix : Character;
   test_sgf : T_sgf;
Begin
   afficher_menu(test_sgf);
   -- traiter_choix(test_sgf, choix);
EXCEPTION
   WHEN Constraint_Error => Put("Parsing problem.");
   WHEN chemin_invalide => Put("Invalid Path");
end test_cli;
