with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

package body parser is

   function isValid (la_cmd : in T_COMMAND) return Boolean is
   Begin
      return false;
   end isValid;

   function i_char (phrase : in Unbounded_String; index : in out Integer; char_pos : in Integer) return Integer is
   Begin
      while character'pos(element(phrase, index)) /= char_pos and then index < length(phrase) loop
         index := index + 1;
      end loop;
      return index;
   end i_char;


   function parse_cmd(phrase : in Unbounded_String) return T_COMMAND is
      la_cmd : T_COMMAND;
      debut_cmd, fin_cmd, fin_arg, debut_arg, long : Integer;
   Begin

      la_cmd.arguments := creer_liste_vide;
      la_cmd.options := creer_liste_vide;
      long := length(phrase);

      debut_cmd := 1;
      fin_cmd := i_char(phrase, debut_cmd, 32) + 1;
      la_cmd.commande := Unbounded_Slice(phrase, debut_cmd, fin_cmd - 2);


      debut_arg := fin_cmd;
      fin_arg := i_char(phrase, fin_cmd, 32) + 1;
      if character'pos(element(phrase, debut_arg)) = 45 then
         debut_arg := debut_arg + 1;
      end if;
      inserer_en_tete(la_cmd.arguments, Unbounded_Slice(phrase, debut_arg, fin_arg - 2));


      inserer_en_tete(la_cmd.options, Unbounded_Slice(phrase, fin_arg, long));


      return  la_cmd;

   end parse_cmd;


   function parse_path(phrase : in Unbounded_String) return T_PATH is
      le_path : T_PATH;
      i, long, a, b : Integer;
   Begin
      long := length(phrase);
      if element(phrase, 1) = '.' then
         le_path.isAbsolute := True;
         a := 3;
      else
         le_path.isAbsolute := False;
         a := 2;
      end if;
      i := a;
      while a <= long loop
         b := a;
         i := i_char(phrase, a, 47);
         inserer_en_tete(le_path.chemin, Unbounded_Slice(phrase, b, i - 1));
         a := i + 1;
      end loop;
      return le_path;
   end parse_path;


end parser;
