with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with Ada.Text_IO; use Ada.Text_IO;
with p_arbre;

package body sgf is


   procedure formatage_disque(arbre : in out T_arbre; noeud_courant : out T_arbre; data : in T_info) is
   Begin
      arbre := P_sgf.init;
      P_sgf.creer_racine(arbre, data);
      noeud_courant := arbre;
   end formatage_disque;


   function repo_courant(noeud_courant : in T_arbre) return T_arbre is
   Begin
      Put(P_sgf.get_contenu(noeud_courant).name);
      return noeud_courant;
   end repo_courant;

   procedure change_dir(noeud_courant : in out T_arbre; arbre : in out T_arbre; old_path : in String; new_path : in String) is
   Begin
      null;
   end change_dir;



   procedure creer_fichier(noeud_courant : in T_arbre; arbre : in out T_arbre; path : in String; name : in String) is
   Begin
      null;
   end creer_fichier;


   function get_name (ab : in T_arbre) return Unbounded_String IS
   Begin
      return get_contenu(ab).name;
   end get_name;

end sgf;
