with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;
with Text_Io;

package body parser is


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
      tmp, tmp1 : Unbounded_String;
   Begin
      la_cmd.commande := get_contenu(get_last(liste_mot));
      enlever(liste_mot, get_contenu(get_last(liste_mot)));

      la_cmd.options := creer_liste_vide;
      la_cmd.arguments := creer_liste_vide;

      while not est_vide(liste_mot) loop
         if element(get_contenu(liste_mot), 1) = '-' then
            tmp := get_contenu(liste_mot);
            tmp1 := unbounded_slice(tmp, 2, length(tmp));
            inserer_en_tete(la_cmd.options, tmp1);
            enlever(liste_mot, tmp);
         else
            inserer_en_tete(la_cmd.arguments, get_contenu(liste_mot));
            enlever(liste_mot, get_contenu(liste_mot));
         end if;
      end loop;
      return la_cmd;
   end parse_cmd;


   function parse_path(liste_mot : in T_liste) return T_PATH is
      le_path : T_PATH;
      tmp : T_liste;
   Begin
      tmp := liste_mot;
      if element(get_contenu(get_last(tmp)), 1) = '.' then
         le_path.isAbsolute := True;
      else
         le_path.isAbsolute := False;
      end if;
      le_path.chemin := liste_mot;
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
      put_line(cmd.commande);
      text_io.New_line;
      print(cmd.arguments);
      text_io.new_line;
      print(cmd.options);
   end test_cmd;

   function traiter (phrase : in Unbounded_String) return T_path is
      path : T_PATH;
      l : T_liste;
   Begin
      -- Get_Line(phrase);
      -- phrase := to_unbounded_string("/home/kaycee/./n7/../prog/");
      l := split(phrase, '/');
      -- print(l);
      path := parse_path(l);
      -- print(path.chemin);
      return path;
   end traiter;

end parser;
