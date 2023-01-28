with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.text_io; use ada.text_io;
with parser; use parser;
with cli; use cli;
with ihm; use ihm;
with sgf; use sgf;

procedure test_cli is
   menu : Boolean;
   test_sgf : T_sgf;
   choix : Character;

   procedure launch(test_sgf : in out T_sgf) is
   Begin
      if menu then
         loop
            afficher_menu(choix);
            traiter_choix(test_sgf, choix);
            EXIT when choix = 'l';
         end loop;
      else
         loop
            saisie_libre(test_sgf);
         end loop;
      end if;
   end launch;

Begin
   menu := affichage_deb;
   launch(test_sgf);

EXCEPTION
   WHEN chemin_invalide => Put_Line("Invalid Path");
      launch(test_sgf);
   WHEN others => Put_Line("Sorry there was an error, try again.");
      launch(test_sgf);
end test_cli;
