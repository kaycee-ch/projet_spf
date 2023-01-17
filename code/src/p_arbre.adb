with file_gen;
with p_liste_gen;
with Ada.Unchecked_Deallocation;

package body p_arbre is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_noeud, Name => T_arbre);

   procedure init (ab : out T_arbre) is
   Begin
      ab := null;
   end init;

   procedure creer_racine(ab : in out T_arbre; data : T_contenu) is
   Begin
      ab := new T_noeud;
      ab.all.f_info := data;
      ab.all.parent := null;
      ab.all.enfants := liste_elem.creer_liste_vide;
   end creer_racine;


   procedure ajouter_enfants(ab : in out T_arbre; data : T_contenu) is
      tmp : T_arbre;
   Begin
      tmp := new T_noeud;
      tmp.all.f_info := data;
      tmp.all.parent := ab;
      tmp.all.enfants := liste_elem.creer_liste_vide;
      liste_elem.inserer_en_tete(ab.all.enfants, tmp);
   end ajouter_enfants;


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

   function get_parent (ab : in T_arbre) return T_arbre is
   Begin
      return null;
   end get_parent;


   function find(ab : in T_arbre; data : in T_contenu) return T_arbre is
      addr, curseur : T_arbre;
      tmp : liste_elem.T_liste;
   Begin
      if ab.all.f_info = data then
         addr := ab;
      else
         curseur : new T_noeud;
         curseur.all.f_info := data;
         if isEqual(liste_elem.rechercher(ab.all.enfants, curseur)) then
            return liste_elem.rechercher(ab.all.enfants);
         end if;
      end if;
      return addr;
   end find;


   function equal_ptr(a : in T_arbre; b : T_arbre) return boolean is
   Begin
      return isEqual(a.all.f_info, b.all.f_info);
   end equal_ptr;

   function get_info (ab : in T_arbre) return T_contenu is
   Begin
      return ab.all.f_info;
   end get_info;

end p_arbre;
