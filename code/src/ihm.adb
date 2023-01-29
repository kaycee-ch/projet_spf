with Ada.Text_IO; use Ada.Text_IO;
with ada.Text_IO.Unbounded_IO; use ada.Text_IO.Unbounded_IO;
with ada.strings.Unbounded; use ada.Strings.Unbounded;
with parser; use parser;
with sgf; use sgf;

package body IHM is

   procedure traiter_ls (le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_command; path : in out T_path) is
      dir_fils, all_info : Boolean := false;
   Begin
      if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
         help(to_unbounded_string("ls"));
      else
         if liste_cmd.contient(cmd.options, to_unbounded_string("l")) then
            all_info := True;
         end if;
         if liste_cmd.contient(cmd.options, to_unbounded_string("R")) then
            dir_fils := true;
         end if;
      end if;
      if menu then
         sgf.liste_contenu(le_sgf, path, dir_fils, all_info);
      else
         if liste_cmd.est_vide(cmd.arguments) then
            path := sgf.repo_courant(le_sgf);
         else
            path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         end if;
         sgf.liste_contenu(le_sgf, path, dir_fils, all_info);
      end if;

   end traiter_ls;


   procedure traiter_pwd (le_sgf : in out T_sgf; cmd : in T_command; path : in out T_path) is
      repo : T_path;
   Begin
      if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
         help(to_unbounded_string("pwd"));
      end if;
      repo := sgf.repo_courant(le_sgf);
   end traiter_pwd;


   procedure traiter_nano(le_sgf : in out T_sgf; menu : in Boolean; existe : in Boolean; cmd : in T_command; path : in out T_path) is
      tmp : T_sgf := le_sgf;
   Begin
      if existe then
         sgf.affiche_fichier(le_sgf, path);
         sgf.supp_fichier_dossier(le_sgf, path, True);
      end if;
      if menu then
         sgf.creer_fichier_dossier(le_sgf, path, true, existe);
      else
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("nano"));
         end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, True, False);
      end if;
   end traiter_nano;



   procedure traiter_mkdir(le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path) is
   Begin
      if menu then
         sgf.creer_fichier_dossier(le_sgf, path, False, False);
      else
         if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
            help(to_unbounded_string("mkdir"));
         end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, False, False);
      end if;
   end traiter_mkdir;



   procedure traiter_cd(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path) is
   Begin
      if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
         help(to_unbounded_string("cd"));
      end if;
      if liste_cmd.est_vide(cmd.arguments) then
         path := sgf.repo_courant(le_sgf);
      else
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      end if;
      sgf.change_dir(le_sgf, path);
   end traiter_cd;



   procedure traiter_tar(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path) is
   Begin
      if liste_cmd.contient(cmd.options, To_Unbounded_String("-help")) then
         help(to_unbounded_string("tar"));
      end if;
      path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      sgf.archive_dir(le_sgf, path);
   end traiter_tar;



   procedure traiter_cat(le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_command; path : in out T_path) is
   Begin
      path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      sgf.affiche_fichier(le_sgf, path);
   end traiter_cat;


   procedure traiter_rm(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path) is
   Begin
      path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      if liste_cmd.est_vide(cmd.options) then
         sgf.supp_fichier_dossier(le_sgf, path, True);
      elsif liste_cmd.get_contenu(cmd.options) = "r" then
         sgf.supp_fichier_dossier(le_sgf, path, False);
      else
         raise commande_inconnu;
      end if;
   end traiter_rm;


   procedure traiter_chmod(le_sgf : in out T_SGF; cmd : in T_COMMAND; path : in out T_PATH) is
   Begin
      path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      sgf.change_droits(le_sgf, path, Integer'Value(to_string(liste_cmd.get_contenu(cmd.options))));
   end traiter_chmod;



   procedure traiter_rename(le_sgf : in out T_SGF; cmd : in T_COMMAND; path : in out T_PATH) is
   Begin
      path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
      sgf.change_name(le_sgf, path, liste_cmd.get_contenu(cmd.options));
   end traiter_rename;



   procedure traiter_cmd(le_sgf : in out T_sgf; cmd : in T_COMMAND) is
      path : T_PATH;
      menu : Boolean := false;
   Begin

      if to_string(cmd.commande) = "init" then
         sgf.formatage_disque(le_sgf);
         Put_Line("Disk formatted");


      elsif to_string(cmd.commande) = "ls" then
         traiter_ls(le_sgf, menu, cmd, path);


      elsif to_string(cmd.commande) = "pwd" then
         traiter_pwd(le_sgf, cmd, path);


      elsif to_string(cmd.commande) = "nano" then
         traiter_nano(le_sgf, menu, false, cmd, path);
         Put_Line("File created");


      elsif to_string(cmd.commande) = "mkdir" then
         traiter_mkdir(le_sgf, menu, cmd, path);
         Put_Line("Folder created");


      elsif to_string(cmd.commande) = "cd" then
         traiter_cd(le_sgf, menu, cmd, path);
         Put_Line("Working Directory has been changed");


      elsif to_string(cmd.commande) = "tar" then
         traiter_tar(le_sgf, menu, cmd, path);
         Put_Line("Folder compressed");


      elsif to_string(cmd.commande) = "cat" then
         traiter_cat(le_sgf, menu, cmd, path);


      elsif to_string(cmd.commande) = "rm" then
         traiter_rm(le_sgf, menu, cmd, path);
         Put_Line("Deleted");


      elsif to_string(cmd.commande) = "chmod" then
         traiter_chmod(le_sgf, cmd, path);
         Put_Line("Rights changed");


      elsif to_string(cmd.commande) = "rename" then
         traiter_rename(le_sgf, cmd, path);
         Put_Line("Name changed");


      elsif to_string(cmd.commande) = "du" then
         Put_Line(Integer'Image(sgf.stockage_occupe(le_sgf)));
         Put_Line("octets");


      elsif to_string(cmd.commande) = "clear" then
         Put(ASCII.ESC & "[2J");


      else
         Put_Line("Unknown Command");

      end if;


   end traiter_cmd;


   procedure help(commande : in Unbounded_String) is
   Begin
      if to_string(commande) = "ls" then
         Put_Line("This command is used to display a list of files and sub-directories");
         Put_Line("ls [ Options ] [File name]");
         Put_Line("ls -R list all of the files, folders and subfolders");
         Put_Line("ls -l list with long format - show name, type, permissions, size");

      elsif to_string(commande) = "tar" then
         Put_Line("This command is used to creat an Archive from a folder");
         Put_Line("tar [Folder name]");

      elsif to_string(commande) = "nano" then
         Put_Line("This command opens up a text editor");
         Put_Line("nano [File name]");

      elsif to_string(commande) = "cd" then
         Put_Line("This command is used to change the current working directory");
         Put_Line("cd [path]");

      elsif to_string(commande) = "pwd" then
         Put_Line("This command is used to get the current working directory");
         Put_Line("pwd");

      elsif to_string(commande) = "cat" then
         Put_Line("This command is used to show the content of a file");
         Put_Line("cat [File path]");

      elsif to_string(commande) = "rename" then
         Put_Line("This command is used to rename a folder");
         Put_Line("rename -[new_name] [File path]");

      elsif to_string(commande) = "mkdir" then
         Put_Line("This command is used to create a folder");
         Put_Line("mkdir [File path]");

      elsif to_string(commande) = "chmod" then
         Put_Line("This commmand is used to change a folder's permissions");
         Put_Line("chmod -[Permission Number] [Folder Path]");
      end if;

   end help;


   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character) is
      path : Unbounded_String;
      cmd : T_command;
      path_traite : T_PATH;
      y : Unbounded_string;
      quitte : Boolean;
      menu : Boolean := true;
      sure : Character;
      n : INteger;
   Begin
      case choix is
      when 'a' =>
         Put_Line("This action will erase everything in the current disk and is irreversible, are you sure Y/N ?");
         Get(sure); Skip_Line;
         case sure is
            when 'Y' =>
               sgf.formatage_disque(le_sgf);
               Put_Line("Disk formatted");
            when others =>
               Put_Line("Action canceled.");
         end case;

      when 'b' =>
         path_traite := repo_courant(le_sgf);

      when 'c' =>
         Put_Line("What is the file path ? ('<filename>' if it's the current directory) ");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         traiter_nano(le_sgf, menu, false, cmd, path_traite);

      when 'd' =>
         Put_Line("What is the file path ? ('<filename>' if it's the current directory) ");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         traiter_cat(le_sgf, menu, cmd, path_traite);

      when 'e' =>
         Put_Line("What is the file path ('<filename>' if it's the current directory) ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         traiter_nano(le_sgf, menu, true, cmd, path_traite);

      when 'f' =>
         Put_Line("What is the folder path ('<foldername>' if it's the current directory) ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         traiter_mkdir(le_sgf, menu, cmd, path_traite);

      when 'g' =>
         Put_Line("What is the destination path ('/.' if it's the current directory, '/..' if it's the current directory's parent)?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         traiter_cd(le_sgf, menu, cmd, path_traite);

      when 'h' =>
         Put_Line("What is the directory path ('/.' if it's the current directory) ? ");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         Put_Line("If you want to see the children tree, type '-R'");
         Put_Line("If you want to list every details about the files/folders, type '-l'");
         Unbounded_Io.Get_Line(y); skip_line;
         cmd := traiter_cmd(y);
         traiter_ls(le_sgf, menu, cmd, path_traite);

      when 'i' =>
         Put_Line("What is the file path (<filename> if it's the current directory) ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         sgf.supp_fichier_dossier(le_sgf, path_traite, true);

      when 'j' =>
         Put_Line("What is the folder path (<foldername> if it's the current directory) ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         sgf.supp_fichier_dossier(le_sgf, path_traite, false);

      when 'k' =>
         Put_Line("What is the folder path ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         sgf.archive_dir(le_sgf, path_traite);

      when 'l' =>
         Put_Line("What is the folder path ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         Put_Line("What are the new rights ? (Integer only)");
         n := integer'value(Get_Line);
         sgf.change_droits(le_sgf, path_traite, n);

      when 'm' =>
         Put_Line("What is the file/folder path ?");
         Unbounded_IO.Get_Line(path);
         path_traite := traiter_path(path);
         Put_Line("What is the new name ?");
         Unbounded_IO.Get_Line(y);
         sgf.change_name(le_sgf, path_traite, y);

      when 'n' =>
         Put_Line(Integer'Image(sgf.stockage_occupe(le_sgf)));


      when 'o' =>
         Put_line("Exiting, goodbye");
         quitte := true;

      when others =>
         Put_Line("Unknown command, please pick from the menu.");

      end case;
   end traiter_choix;

end IHM;
