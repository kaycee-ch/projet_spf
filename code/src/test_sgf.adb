with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with P_arbre;
with sgf; use sgf;

procedure test_sgf is

   a, n : p_sgf.T_arbre;

Begin
   test(a, n);

   end test_sgf;
