with Ada.Text_IO; use Ada.Text_IO;


package body sgf is


   procedure formatage_disque(arbre : out T_arbre; noeud_courant : in out T_arbre) is
   Begin
      arbre := init;
      noeud_courant := arbre;
   end formatage_disque;

   function repo_courant(noeud_courant : in T_arbre) return T_arbre is
   Begin
      Put_Line(get_info(noeud_courant).name);
      return noeud_courant;
   end repo_courant;


   function get_path(noeud_courant : in T_arbre; path : in String; long_path : in Natural) return T_arbre is
      ab : T_arbre;
   Begin
      if path'First = "." then -- le chemin est relatif donc on le convertit en chemin absolu
         if long_path = 1 or else (long_path = 2 and then path'Last = "/") then
            return noeud_courant;
         elsif long_path = 2 or else (long_path = 3 and then path'Last = "/") then
            return get_parent(noeud_courant);
         else
            ab := find(ab, get_info(ab));
            return ab;
         end if;
      end if;
   end get_path;

   procedure creer_fichier(noeud_courant : in out T_arbre; arbre : in out T_arbre; path : in String; name : in String; file_info : in out T_info) is
   Begin
      null;
   end creer_fichier;

end sgf;
