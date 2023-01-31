with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with p_liste_gen;


package parser is

char_absent, nothing_to_parse : EXCEPTION;

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
   -- semantique : cette fonction prend un unbounded_string en paramètre et retourne la position de la première occurence du caractère recherché
   -- pre : none
   -- post : unbounded.element(phrase, index) = char
   -- exception : none


   function split(phrase : in Unbounded_String; separateur : in Character) return T_liste;
   -- semantique : cette fonction prend un unbounded_string et un caractère qui sert de séparateur en paramètres et retourne une liste chainée contenant les mots précédemment séparé par le séparateur (ex : espace ou slash)
   -- pre : none
   -- post : none
   -- exception : none


   function parse_cmd(liste_mot : in out T_liste) return T_COMMAND;
   -- semantique : cette fonction prend une liste chainée de mot, analyse la structure et sépare la commande, les options et les arguments
   -- pre : none
   -- post : none
   -- exception : none


   function parse_path(liste_mot : in T_liste) return T_PATH;
   -- semantique : cette fonction prend une liste chainee de mot , analyse la structure et renvoie le chemin, le chemin inversé et s'il est absolu ou non
   -- pre : none
   -- post : none
   -- exception : none


   function traiter_path (phrase : in Unbounded_String) return T_path;


   function traiter_cmd(phrase : in Unbounded_String) return T_command;


   procedure test_cmd;

end parser;
