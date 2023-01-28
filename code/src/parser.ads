with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with p_liste_gen;


package parser is


   package liste_cmd is new p_liste_gen(T_type => Unbounded_String);
   use liste_cmd;

   procedure print is new afficher_liste(put_line);

   TYPE T_PATH is record
      chemin : T_liste;
      chemin_inv : T_liste;
      isAbsolute : Boolean;
   end record;


   TYPE T_COMMAND is record
      commande : Unbounded_String;
      options : T_liste;
      arguments : T_liste;
   end record;


   function i_char (phrase : in Unbounded_String; index : in out Integer; char : in Character) return Integer;

   function parse_cmd(liste_mot : in out T_liste) return T_COMMAND;

   function split(phrase : in Unbounded_String; separateur : in Character) return T_liste;

   function parse_path(liste_mot : in T_liste) return T_PATH;

   procedure test_cmd;

   function isPath (phrase : in Unbounded_String) return Boolean;

   function traiter_path (phrase : in Unbounded_String) return T_path;

   function traiter_cmd(phrase : in Unbounded_String) return T_command;

end parser;
