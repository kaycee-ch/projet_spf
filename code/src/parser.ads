with Ada.Text_IO; use Ada.Text_IO;

package parser is

   NMAX : INTEGER := 100;
   TYPE TAB_MOT is ARRAY(1..NMAX) of String(1..NMAX);
   TYPE MOT is record
      tab : TAB_MOT;
      longueur : Integer;
   end record;

   procedure parse_cmd(phrase : in String; taille : in out Integer; liste_mot : out MOT);

   procedure parse_path(path : in String; taille : in out Integer; liste_mot : out MOT);



end parser;
