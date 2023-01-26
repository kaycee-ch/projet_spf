with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO;
with p_arbre;
with file_gen;

procedure test_arbre is

   package file_int is new file_gen(T_element => Integer);
   use file_int;

   procedure print_int(n : in Integer; indent : in Integer) is
      str : String(1..3);
   Begin
      if indent = 0 then
         null;
      elsif indent = 1 then
         Put("\- ");
      else
         Put("|    ");
         str := "\- ";
         Put(str, indent);
      end if;
      Put(n, indent*indent);
      new_line;
   end print_int;


   procedure print_str(n : in Unbounded_String; indent : in Integer) is
      str : String(1..3);
      m : Integer := length(n);
      tmp : String(1..m);
   Begin
      if indent = 0 then
         null;
      elsif indent = 1 then
         Put("\- ");
      else
         Put("|    ");
         str := "\- ";
         Put(str, indent);
      end if;
      tmp := to_string(n);
      Put(tmp, indent*indent);
      new_line;
   end print_str;

   function egal_int(x : in Integer; y : in INteger) return Boolean is
   Begin
      return x = y;
   end egal_int;

   function egal_str(x : in Unbounded_String; y : in Unbounded_String) return Boolean is
   Begin
      return x = y;
   end egal_str;


   package arbre_int is new p_arbre(T_contenu => Integer, is_equals => egal_int);
   use arbre_int;

   procedure afficher_int is new print(print_int);

   -- function trouver_int is new find(egal_int);

   -- procedure remove_int is new remove(trouver_int);

   -- procedure afficher_str is new print(print_str);



   function test_int return T_arbre is
      arb, test, x, y, z, m, l, b : T_arbre;

   Begin
   --     init(arb);
   --     creer_racine(arb, 1);
   --     -- ajouter_enfants(find(arb, 1), 3);
   --     ajouter_enfants(arb, 2);
   --     ajouter_enfants(arb, 3);
   --     x := trouver_int(arb, 3);
   --
   --     ajouter_enfants(x, 4);
   --
   --     -- put((get_contenu(trouver_int(arb, 31))));
   --     -- ajouter_enfants(x, 5);
   --     -- ajouter_enfants(x, 6);
   --     -- y := trouver_int(arb, 4);
   --     ajouter_enfants(y, 5);
   --     z := trouver_int(arb, 2);
   --     ajouter_enfants(z, 6);
   --     m := trouver_int(arb, 6);
   --     ajouter_enfants(m, 7);
   --     l := trouver_int(arb, 7);
   --     ajouter_enfants(l, 8);
   --     l := trouver_int(arb, 8);
   --     ajouter_enfants(l, 9);
   --     l := trouver_int(arb, 9);
   --     ajouter_enfants(l, 10);
   --     afficher_int(arb);
   --     remove_int(arb, 4);
   --     New_Line;
   --     afficher_int(arb);
   --     New_Line;
   --     -- afficher_int(arb);
   --     -- set_arbre(arb , test);
   --     -- afficher_int(test);
   --     return arb;
   null;
    end test_int;
   --
   --  --     function test_str return T_arbre is
   --  --
   --  --     arb, test, x, y, z, m, l : T_arbre;
   --  --
   --  --  Begin
   --  --     init(arb);
   --  --     creer_racine(arb, To_Unbounded_String("\"));
   --  --     -- ajouter_enfants(find(arb, 1), 3);
   --  --     ajouter_enfants(arb, To_Unbounded_String("home"));
   --  --     ajouter_enfants(arb, To_Unbounded_String("usr"));
   --  --     x := trouver_int(arb, To_Unbounded_String("home"));
   --  --     ajouter_enfants(x, To_Unbounded_String("user1"));
   --  --     -- ajouter_enfants(x, 5);
   --  --     -- ajouter_enfants(x, 6);
   --  --     y := trouver_int(arb, To_Unbounded_String("usr"));
   --  --     ajouter_enfants(y, To_Unbounded_String("local"));
   --  --     z := trouver_int(arb, To_Unbounded_String("local"));
   --  --     ajouter_enfants(z, To_Unbounded_String("share"));
   --  --     m := trouver_int(arb, To_Unbounded_String("user1"));
   --  --     ajouter_enfants(m, To_Unbounded_String("projet"));
   --  --     l := trouver_int(arb, To_Unbounded_String("projet"));
   --  --     ajouter_enfants(l, To_Unbounded_String("exemple.adb"));
   --  --     -- remove_int(arb, 2);
   --  --     set_arbre(arb , test);
   --  --        -- afficher_int(test);
   --  --        return arb;
   --  -- end test_str;
  Begin
   null;

end test_arbre;
