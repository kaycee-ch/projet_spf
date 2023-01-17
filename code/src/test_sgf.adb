with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with P_arbre;
with sgf; use sgf;

procedure test_sgf is
data : T_info;
   noeud_courant, ab : P_sgf.T_arbre;
Begin
   data := (To_Unbounded_String("root"), False, To_Unbounded_String("all"), 0);
   formatage_disque(ab, noeud_courant, data);
   Put(P_sgf.get_contenu(repo_courant(noeud_courant)).name);

   end test_sgf;
