with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO;
with p_arbre;
with file_gen;

procedure test_arbre is

   package file_int is new file_gen(T_element => iNTEGER);
   use file_int;

   procedure print_int(n : in Integer; indent : in Integer) is
   Begin
      Put(n, indent);
      new_line;
   end print_int;


   function egal_int(x : in Integer; y : in INteger) return Boolean is
   Begin
      return x = y;
   end egal_int;



   package arbre_int is new p_arbre(T_contenu => iNTEGER);
   use arbre_int;

   procedure afficher_int is new print(print_int);

   function trouver_int is new find(egal_int);

   procedure remove_int is new remove(trouver_int);

   -- procedure afficher_str is new print(Text_IO.Unbounded_IO.Put_Line);

   arb, test, x, y, z, m : T_arbre;

Begin
   init(arb);
   creer_racine(arb, 1);
   -- ajouter_enfants(find(arb, 1), 3);
   ajouter_enfants(arb, 2);
   ajouter_enfants(arb, 3);
   x := trouver_int(arb, 2);
   ajouter_enfants(x, 4);
   ajouter_enfants(x, 5);
   ajouter_enfants(x, 6);
   y := trouver_int(arb, 3);
   ajouter_enfants(y, 8);
   z := trouver_int(arb, 8);
   ajouter_enfants(z, 9);
   m := trouver_int(arb, 6);
   ajouter_enfants(m, 7);
   -- remove_int(arb, 2);
   afficher_int(arb);
   set_arbre(arb , test);
   -- afficher_int(test);
   -- put(integer'image(profondeur(trouver_int(arb, 1))));
   -- remove(arb, 6);
   -- remove(arb, 12);
   -- afficher_str(arb);

end test_arbre;
