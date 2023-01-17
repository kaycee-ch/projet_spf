with Ada.Text_IO; use Ada.Text_IO;
with ihm; use ihm;

package body CLI is

   procedure afficher_menu (commande : out String; longueur : out Integer) is

      choix : Character;
      menu : Boolean;
      cmd : MOT;
   Begin
      loop
         Put_Line("Affichage (m)enu ou Saisie (l)ibre");
         Get(choix);
         case choix is
         when 'm' => menu := True;
         when 'l' => menu := False;
            when others => Put_Line("Saisie incorrect");
         end case;
      end loop;
      if menu then
         Put_Line("Choisissez l'une des commandes suivantes :");
         Put_Line("pwd");
         Put_Line("nano <filename>");
         Put_Line("mkdir <filename>");
         Put_Line("cd <path>");
         Put_Line("ls");
         Put_Line("ls -r");
         Put_Line("rm <filename>");
         Put_Line("rm -r <dirname>");
         Put_Line("mv <filePath> <fileDestination>");
         Put_Line("cp <filename> <copyname>");
         Put("tar <dirname>");
      end if;

      Get_Line(commande, longueur);
      traiter(commande, longueur);
   end afficher_menu;

end CLI;
