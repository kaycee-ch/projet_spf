with Ada.Text_IO; use Ada.Text_IO;
with ada.Text_IO.Unbounded_IO; use ada.Text_IO.Unbounded_IO;
with ada.strings.Unbounded; use ada.Strings.Unbounded;
with parser; use parser;
with sgf; use sgf;

package body IHM is

   procedure traiter_cmd(le_sgf : in out T_sgf; cmd : in T_COMMAND) is
      dir_fils, all_info : Boolean := false;
      path : T_path;
   Begin

      if to_string(cmd.commande) = "ls" then
         --  if parser.liste_cmd.contient(cmd.options, to_unbounded_string("a")) then
         --     dir_fils := True;
         --  end if;
         --  if parser.liste_cmd.contient(cmd.options, to_unbounded_string("l")) then
         --     all_info := True;
         --  end if;
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("ls"));
            end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.liste_contenu(le_sgf, path, true, true);


      elsif to_string(cmd.commande) = "pwd" then
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("pwd"));
            end if;
         sgf.repo_courant(le_sgf);


      elsif to_string(cmd.commande) = "nano" then
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("nano"));
            end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, True, False);


      elsif to_string(cmd.commande) = "mkdir" then
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("mkdir"));
            end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, False, False);


      elsif to_string(cmd.commande) = "cd" then
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("cd"));
            end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.change_dir(le_sgf, path);


      elsif to_string(cmd.commande) = "tar" then
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("tar"));
            end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.archive_dir(le_sgf, path);

      elsif to_string(cmd.commande) = "cat" then
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.affiche_fichier(le_sgf, path);
      end if;


   end traiter_cmd;


   procedure help(commande : in Unbounded_String) is
   Begin
      if to_string(commande) = "ls" then
         Put_Line("This command is used to display a list of files and sub-directories");
         Put_Line("ls [ Options ] [File]");
         Put_Line("ls -a list all files including hidden files starting with '.'");
         Put_Line("ls -l list with long format - show permissions");

      elsif to_string(commande) = "tar" then
         Put_Line("This command is used to creat Archive and exctract Archive files");
         Put_Line("tar [Folder]");

      elsif to_string(commande) = "nano" then
         Put_Line("This command opens up a text editor");
         Put_Line("nano [File]");

      elsif to_string(commande) = "cd" then
         Put_Line("This command is used to change the current working directory");
         Put_Line("cd [directory]");

         elsif to_string(commande) = "pwd" then
         Put_Line("This command is used to get the current working directory");
         Put_Line("pwd");
      end if;

   end help;


   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character) is
      path : Unbounded_String;
      path_traite : T_path;
      y : character;
      quitte : Boolean;
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
         when 'z' =>
            sgf.formatage_disque(le_sgf);
            Put_Line("Disk formatted");
         when others =>
            Put_Line("Commande Inconnue");
      end case;
   end traiter_choix;

end IHM;
