with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with file_gen;
-- with p_arbre;
with cli; use cli;
with parser; use parser;


procedure Main is

   --  package file_int is new file_gen(T_element => Integer, Equal => equal_ptr);
   --  use file_int;
   --
   --  procedure print_int(n : in Integer) is
   --  Begin
   --     Put_Line(Integer'Image(n));
   --  end print_int;
   --
   --  package arbre_int is new p_arbre(T_contenu => Integer);
   --  use arbre_int;
   --
   --  procedure afficher_int is new print(print_int);

   -- arb : T_arbre;
   menu : BOOLEAN;
   phrase : String(1..50);
   tab : MOT;
   taille : INTEGER;
Begin
   Put("entrez phrase ");
   Get_Line(phrase, taille);

end Main;
