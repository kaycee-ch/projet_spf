with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
-- with file_gen;
with p_arbre;

procedure Main is
   --  package file_int is new file_gen(T_element => Integer);
   --  use file_int;

   procedure print_int(n : in Integer) is
   Begin
      Put_Line(Integer'Image(n));
   end print_int;

   package arbre_int is new p_arbre(T_contenu =>  Integer);
   use arbre_int;

   procedure afficher_int is new print(print_int);

   arb : T_arbre;
Begin

   arb := init;
   add(arb, 1);
   add(arb, 2);
   afficher_int(arb);

end Main;
