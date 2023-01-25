with Ada.Text_IO; use Ada.Text_IO;
with Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ihm; use ihm;
with sgf; use sgf;
with parser; use parser;

package body CLI is

   procedure afficher_menu(le_sgf : in out T_sgf) is

      choix_affichage, choix_action : Character;
      menu : Boolean;
   Begin
      Put_Line("Affichage (m)enu ou Saisie (l)ibre");
      Get(choix_affichage);
      Skip_Line;
      case choix_affichage is
         when 'm' => menu := True;
         when 'l' => menu := False;
         when others => Put_Line("Saisie incorrect");
      end case;

      formatage_disque(le_sgf);
      Put_Line("New disk has been formated");
      if menu then
         while not quitte loop
            Put_Line("Que souhaitez-vous faire ?");
            Put_Line("a) Find the current directory");
            Put_Line("b) Create a new file");
            Put_Line("c) Modify an existing file");
            Put_Line("d) Create a folder");
            Put_Line("e) Go to a different directory");
            Put_Line("f) List everything in the current directory");
            Put_Line("g) Remove a file");
            Put_Line("h) Remove a folder");
            Put_Line("i) Move a file");
            Put_Line("j) Copy a file");
            Put_Line("k) Archive a folder");
            Put_line("l) Exit this SGF");

            Get(choix_action);
            traiter_choix(le_sgf, choix_action);
            New_Line;
         end loop;
      else
         saisie_libre(le_sgf);
      end if;
   end afficher_menu;


   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character) is
      path : Unbounded_String;
      path_traite : T_path;
      y : character;
   Begin
      case choix is
         when 'a' =>
            repo_courant(le_sgf);
         when 'b' =>
            Put_Line("What is the file path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            creer_fichier_dossier(le_sgf, path_traite, True, False);
         when 'c' =>
            Put_Line("What is the file path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            creer_fichier_dossier(le_sgf, path_traite, True, True);
         when 'd' =>
            Put_Line("What is the folder path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            creer_fichier_dossier(le_sgf, path_traite, False, False);
         when 'e' =>
            Put_Line("What is the destination path (absolute)?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            change_dir(le_sgf, path_traite);
         when 'f' =>
            Put_Line("What is the directory path (absolute) ? ");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            Put_Line("List everything in the children directory ? Y/N");
            get(y); skip_line;
            if y = 'y' then
               liste_contenu(le_sgf, path_traite, true, false);
            else
               liste_contenu(le_sgf, path_traite, false, false);
            end if;
         when 'g' =>
            Put_Line("What is the file path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            sgf.supp_fichier_dossier(le_sgf, path_traite);
         when 'h' =>
            Put_Line("What is the folder path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            sgf.supp_fichier_dossier(le_sgf, path_traite);
         when 'i' =>
            Put_Line("What is the current file path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            -- sgf.deplacer(le_sgf, path_traite, path_traite_dest);
         when 'j' =>
            Put_Line("What is the folder path (absolute)");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            --sgf.copy(le_sgf, path_traite, path_traite_dest);
         when 'k' =>
            Put_Line("What is the current file path (absolute) ?");
            Unbounded_IO.Get_Line(path); Skip_line;
            path_traite := traiter_path(path);
            sgf.archive_dir(le_sgf, path_traite);
         when 'l' =>
            Put_line("Exiting, goodbye");
            quitte := true;
         when others =>
            Put_Line("Commande Inconnue");
      end case;
   end traiter_choix;


   procedure saisie_libre(le_sgf : in out T_sgf) is
      cmd : T_command;
      cmd_str : Unbounded_String;
   Begin
      loop
         unbounded_io.Get_line(cmd_str);
         Skip_line;
         cmd := traiter_cmd(cmd_str);
         traiter_cmd(le_sgf, cmd);
      end loop;
   end saisie_libre;


end CLI;
