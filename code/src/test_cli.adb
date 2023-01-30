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
            EXIT when choix = 'm';
         end loop;
      else
         loop
            saisie_libre(test_sgf);
         end loop;
      end if;
   EXCEPTION
      WHEN sgf.chemin_invalide => Put_Line("Invalid Path");
         launch(test_sgf);
      WHEN sgf.stockage_plein => Put_Line("Disk Full, Delete something");
         launch(test_sgf);
      WHEN sgf.tar_file => Put_Line("Can't compress a file, please select a folder");
         launch(test_sgf);
      WHEN sgf.no_file => Put_Line("No file with this name in the repository, please try again");
         launch(test_sgf);
      WHEN sgf.cannot_print => Put_line("This file doesn't exist");
         launch(test_sgf);
      WHEN others => Put_Line("Sorry there was an error, try again.");
         launch(test_sgf);
   end launch;

Begin
   menu := affichage_deb;
   launch(test_sgf);

end test_cli;
