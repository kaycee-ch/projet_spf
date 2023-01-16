with file_gen;
with p_liste_gen;
with Ada.Unchecked_Deallocation;

package body p_arbre is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_noeud, Name => T_arbre);

   function init return T_arbre is
      p : T_arbre;
   Begin
      p := new T_noeud;
      p := null;
      return p;
   end init;


   procedure print (ab : in T_arbre) is
      arbre_vide : exception;
      une_file : file.T_file;
      curseur : T_arbre;
      tmp : file.T_file;
   Begin
      curseur := ab;
      if curseur /= null then
         afficher_noeud(curseur.all.f_info);
         file.enfiler_liste(une_file, curseur.all.enfants);
         defiler(une_file, tmp);
      else
         raise arbre_vide;
      end if;
   end print;


   procedure add(ab : in out T_arbre; data : in T_contenu) is
      tmp : T_arbre;
   Begin
      if ab = null then
         ab := new T_noeud;
         ab.all.f_info := data;
      else
         tmp := new T_noeud;
         tmp.all.parent := ab;
         tmp.all.enfants := liste_elem.creer_liste_vide;
      end if;
   end add;

   procedure remove (ab : in out T_arbre; data : in T_contenu) is
      addr : T_arbre;
   Begin
      addr := ab; -- find(ab, data);
      --liste_elem.enlever(addr.all.parent.all.enfants, addr);
      free(addr);
   end remove;


   procedure move (ab : in out T_arbre; dest : in T_arbre; data : in T_contenu) is
   Begin
      null;
   end move;


   function find(ab : in T_arbre; data : in T_contenu) return T_arbre is
      tmp : T_arbre;
   Begin
      if ab = null then
         raise arbre_vide;
      else
         tmp := ab;
         return tmp;
      end if;
   end find;


end p_arbre;
