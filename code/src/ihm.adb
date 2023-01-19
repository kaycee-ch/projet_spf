with Ada.Text_IO; use Ada.Text_IO;
with ada.Text_IO.Unbounded_IO;
with strings.Unbounded;
with parser; use parser;
-- with sgf; use sgf;

package body IHM is

   procedure traiter_cmd(cmd : in T_COMMAND) is
   Begin
      case unbounded.to_string(liste_cmd.commande) is
         when "ls" =>
            if taille(cmd.options) > 1 then
               Put_Line("ls command can only have one option.");
            else
               if parser.liste_cmd.contient(cmd.arguments, Unbounded.To_Unbounded_String("a")) then
                  liste_contenu_dir();

            end if;

      when "pwd" =>
         if liste_mot.longueur > 1 then
            Put_Line("nombre d'arguments invalide");
         else
            repo_courant();
         end if;


      when "nano" =>
         if liste_mot.longueur > 2 then
            Put_Line("nombre d'arguments invalide");
         else
            if file_exists(liste_mot.tab(2)) then
               modifier_fichier();
            else
               creer_fichier(); --name = liste_mot.tab(2)
            end if;
         end if;


      when "mkdir" =>
         if liste_mot.longueur > 2 then
            Put_Line("nombre d'arguments invalide");
         else
            creer_dossier(); --name = liste_mot.tab(2)
         end if;


      when "cd" =>
         if liste_mot.longueur > 2 then
            Put_Line("nombre d'arguments invalide");
         else
            change_dir(); -- new_path = liste_mot.tab(2)

            when "rm" =>
            if liste_mot.longueur = 1 then
               suppr_fichier();
            else
               if liste_mot(2) = "-r" then
                  suppr_dir();
               elsif liste_mot(2) = "--help" then
                  Put("help ls");
               else
                  Put("commande invalide");
               end if;
            end if;
         end if;

      when "tar" =>
         if liste_mot.longueur > 2 then
            Put_Line("arguments invalides");
         else
            if liste_mot(2) = "--help" then
               Put("help tar");
            else
               archive_dir();
            end if;
         end if;


      when "mv" =>
         if liste_mot.longueur > 3 then
            Put_LIne("arguments invalides");
         else
            if liste_mot.longueur(2) = "--help" then
               Put_Line("help mv");
            else
               move_fichier(); -- fichier a deplacer = liste_mot.tab(2) destination = liste_mot.tab(3)
            end if;
         end if;


      when "cp" =>
         if liste_mot.longueur > 3 then
            Put_LIne("arguments invalides");
         else
            if liste_mot.longueur(2) = "--help" then
               Put_Line("help cp");
            else
               copy_fichier-- a copiermot.tab(2) destination = liste_mot.tab(3)
            end if;
         end if;

       when others =>
            Put_Line("commande inconnue");
      --end case;

   end traiter_cmd;

end IHM;
