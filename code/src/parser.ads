with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with p_liste_gen;


package parser is


   package liste_cmd is new p_liste_gen(T_type => Unbounded_String);
   use liste_cmd;

   procedure print is new afficher_liste(put_line);

   TYPE T_PATH is record
      isAbsolute : Boolean;
      chemin : T_liste;
   end record;


   TYPE T_COMMAND is record
      commande : Unbounded_String;
      options : T_liste;
      arguments : T_liste;
   end record;


   function i_char (phrase : in Unbounded_String; index : in out Integer; char_pos : in Integer) return Integer;

   function parse_cmd(phrase : in Unbounded_String) return T_COMMAND;

   function parse_path(phrase : in Unbounded_String) return T_PATH;


end parser;
