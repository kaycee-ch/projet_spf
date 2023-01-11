with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with file_gen;

procedure Main is
   package file_int is new file_gen(T_element => Integer);
   use file_int;

   la_file : T_file;
   resultat : T_file;
     empty : Boolean := false;
Begin
   initialiser(la_file);
   enfiler(la_file, 1);

   Put(Integer'Image(get_contenu(la_file)));
   enfiler(la_file, 2);

   Put(Integer'Image(get_contenu(la_file)));
   --Put(Integer'Image(taille(la_file)));
   defiler(la_file, resultat);
   Put(Integer'Image(get_contenu(resultat)));
   defiler(la_file, resultat);
   Put(Integer'Image(get_contenu(resultat)));
   --defiler(la_file, resultat);


end Main;
