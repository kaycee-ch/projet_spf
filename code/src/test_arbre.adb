with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO;
with p_arbre;
with file_gen;

procedure test_arbre is

   package file_int is new file_gen(T_element => iNTEGER);
   use file_int;

   procedure print_int(n : in Integer) is
   Begin
      Put_Line(Integer'Image(n));
   end print_int;


   package arbre_int is new p_arbre(T_contenu => iNTEGER);
   use arbre_int;

   procedure afficher_int is new print(print_int);

   -- procedure afficher_str is new print(Text_IO.Unbounded_IO.Put_Line);

   arb, test : T_arbre;

Begin
   init(arb);
   creer_racine(arb, 1);
   -- ajouter_enfants(find(arb, 1), 3);
   ajouter_enfants(arb, 2);
   ajouter_enfants(arb, 3);
   ajouter_enfants(arb, 12);
   afficher_int(arb);
   -- remove(arb, 6);
   -- remove(arb, 12);
   -- afficher_str(arb);

end test_arbre;
