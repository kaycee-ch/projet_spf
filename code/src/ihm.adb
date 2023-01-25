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
         if parser.liste_cmd.contient(cmd.options, to_unbounded_string("-a")) then
            dir_fils := True;
         end if;
         if parser.liste_cmd.contient(cmd.options, to_unbounded_string("-l")) then
            all_info := True;
         end if;
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.liste_contenu(le_sgf, path, dir_fils, all_info);


      elsif to_string(cmd.commande) = "pwd" then
         sgf.repo_courant(le_sgf);


      elsif to_string(cmd.commande) = "nano" then
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, True, False);


      elsif to_string(cmd.commande) = "mkdir" then
         path := traiter_path(liste_cmd.get_contenu(cmd.arguments));
         sgf.creer_fichier_dossier(le_sgf, path, False, False);
      end if;


   end traiter_cmd;

end IHM;
