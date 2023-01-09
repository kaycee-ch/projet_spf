with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with liste_gen; use liste_gen;


procedure Main is
   --  procedure print_int(n : in Integer) is
   --  Begin
   --     Put_Line(Integer'Image(n));
   --  end print_int;

   --procedure afficher_int is new afficher_liste(print_int);

   la_liste : liste;
   cell : cellule;
   le_noeud : T_noeud;
Begin
   la_liste := creer_liste_vide;
   le_noeud := creer_noeud(true, 't');
   cell := creer_cellule(le_noeud);
   inserer_en_tete(la_liste, cell);
   afficher_liste(la_liste);

end Main;
