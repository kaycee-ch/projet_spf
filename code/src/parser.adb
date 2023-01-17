with Ada.Text_IO; use Ada.Text_IO;

package body parser is

   procedure parse_cmd(phrase : in String; taille : in out Integer; liste_mot : out MOT) is
      j : Integer;
   Begin
      liste_mot.longueur := 0;
      j := 1;
      for i in 1..taille loop
         while character'pos(phrase(j)) /= 32 and then j <= taille loop
            j := j + 1;
         end loop;
         liste_mot.tab(i) := phrase(i..(j - 1));
         liste_mot.longueur := liste_mot.longueur + 1;
         j := j + 1;
      end loop;
   end parse_cmd;

   procedure parse_path(path : in String; taille : in out Integer; liste_mot : out MOT) is
      j : Integer;
   Begin
      for i in 1..taille loop
         j := i;
         while character'pos(path(j)) /= 47 loop
            j := j + 1;
         end loop;
         liste_mot.tab(i) := path(i..j);
         liste_mot.longueur := liste_mot.longueur + 1;
      end loop;
   end parse_path;

end parser;
