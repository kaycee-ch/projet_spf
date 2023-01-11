with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_arbre;


package sgf is

   type T_info is private;


   procedure creer_fichier;



private
   TYPE T_info is record
      name : Unbounded_String;
      isFile : Boolean;
      droits : Unbounded_String;
      taille : Integer;
   end record;
   package P_sgf is new P_arbre(T_contenu => T_info); use P_sgf;
end sgf;
