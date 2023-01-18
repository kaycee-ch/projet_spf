with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

package body parser is

   function isValid (la_cmd : in T_COMMAND) return Boolean is
   Begin
      return false;
   end isValid;

   function i_char (phrase : in Unbounded_String; index : in out Integer; char : in Character) return Integer is
   Begin
      while element(phrase, index) /= char and then index < length(phrase) loop
         index := index + 1;
      end loop;
      return index;
   end i_char;


   function split(phrase : in Unbounded_String; separateur : in Character) return T_liste is
      liste_split : T_liste;
      deb, fin, long, tmp : Integer;
      new_phrase : Unbounded_String := phrase;
   Begin
      liste_split := creer_liste_vide;
      long := length(phrase);
      if element(phrase, long) /= separateur then
         append(new_phrase, separateur);
      end if;
      deb := 1;
      while deb <= long loop
         tmp := deb;
         fin := i_char(new_phrase, tmp, separateur);
         inserer_en_tete(liste_split, Unbounded_Slice(new_phrase, deb, fin - 1));
         deb := fin + 1;
      end loop;
      return liste_split;
   end split;


   function parse_cmd(liste_mot : in out T_liste) return T_COMMAND is
      la_cmd : T_COMMAND;
   Begin
      la_cmd.commande := get_last(liste_mot);
      enlever(liste_mot, get_last(liste_mot));

      la_cmd.options := creer_liste_vide;
      la_cmd.arguments := creer_liste_vide;

      while not est_vide(liste_mot) loop
         if element(get_contenu(liste_mot), 1) = '-' then
            inserer_en_tete(la_cmd.options, get_contenu(liste_mot));
         else
            inserer_en_tete(la_cmd.arguments, get_contenu(liste_mot));
         end if;
         enlever(liste_mot, get_contenu(liste_mot));

      end loop;
      return la_cmd;
   end parse_cmd;


   function parse_path(liste_mot : in out T_liste) return T_PATH is
      le_path : T_PATH;
      long : Integer;
      new_phrase : Unbounded_String;
   Begin
      while not est_vide(liste_mot) loop
         new_phrase := get_contenu(liste_mot);
         long := length(new_phrase);
         Put(new_phrase);
         if element(new_phrase, 1) = '.' then
            le_path.isAbsolute := True;
         else
            le_path.isAbsolute := False;
         end if;
         if element(new_phrase, long) /= '/' then
            append(new_phrase, '/');
         end if;
         inserer_en_tete(le_path.chemin, new_phrase);
         enlever(liste_mot, new_phrase);
         liste_mot := get_next(liste_mot);
      end loop;
      return le_path;
   end parse_path;

   procedure test_cmd is
      phrase : Unbounded_String;
      cmd : T_COMMAND;
      l : T_liste;
   Begin
      -- Get_Line();
      phrase := To_Unbounded_String("ls -l -a test.adb test.ads test.ali");
      l := split(phrase, ' ');
      cmd := parse_cmd(l);
      -- put(cmd.commande);
      -- print(cmd.arguments);
      print(cmd.options);
   end test_cmd;

   procedure test_path is
      phrase : Unbounded_String;
      path : T_PATH;
      l : T_liste;
   Begin
      Get_Line(phrase);
      l := split(phrase, '/');
      path := parse_path(l);
      -- print(path.chemin);
   end test_path;

end parser;
