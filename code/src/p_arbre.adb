with Ada.Text_IO; use Ada.Text_IO;
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


   function profondeur(ab : in T_arbre) return Integer is
      n : Integer := 0;
      tmp, r : T_arbre;
   Begin
      r := get_root(ab);
      tmp := ab;
      while tmp /= r loop
         n := n + 1;
         tmp := tmp.all.parent;
      end loop;
      return n;
   end profondeur;


   procedure ajouter_enfants(ab : in out T_arbre; data : T_contenu) is
      tmp : T_arbre;
   Begin
      if ab /= null then
         tmp := new T_noeud;
         tmp.all.f_info := data;
         tmp.all.parent := ab;
         tmp.all.enfants := liste_elem.creer_liste_vide;
         liste_elem.inserer_en_tete(ab.all.enfants, tmp);
      end if;
   end ajouter_enfants;

   function ab_est_vide (ab : in T_arbre) return Boolean is
   begin
      return ab = null;
   end ab_est_vide;


   procedure print (ab : in T_arbre) is
      arbre_vide : exception;
      une_file : file.T_file;
      curseur : T_arbre;
      tmp : file.T_file;
   Begin
      curseur := ab;
      if curseur /= null then
         afficher_noeud(curseur.all.f_info, profondeur(ab)*profondeur(ab));
         file.enfiler_liste(une_file, curseur.all.enfants);
         while not file.is_empty(une_file) loop
            defiler(une_file, tmp);
            print(file.get_contenu(tmp));
         end loop;
      else
         raise arbre_vide;
      end if;
      New_LIne;
   end print;


   procedure remove (ab : in out T_arbre; data : in T_contenu) is
      addr : T_arbre;
      l_addr : liste_elem.T_liste;
   Begin
      addr := chercher(ab, data);
      if addr /= null and then (not liste_elem.est_vide(addr.all.parent.all.enfants)) then
         l_addr := liste_elem.rechercher(addr.all.parent.all.enfants, addr);
         liste_elem.enlever(addr.all.parent.all.enfants, liste_elem.get_contenu(l_addr));
         free(addr);
      end if;
   end remove;


   --  procedure remove_sa (ab : in out T_arbre) is
   --     tmp : liste_elem.T_liste;
   --     abr_tmp : T_arbre;
   --  Begin
   --     if ab /= null then
   --        tmp := ab.all.enfants;
   --        abr_tmp := liste_elem.get_contenu(tmp);
   --        while not liste_elem.est_vide(tmp) loop
   --           remove(abr_tmp, abr_tmp.all.f_info);
   --           tmp := liste_elem.get_next(tmp);
   --        end loop;
   --        free(ab);
   --     end if;
   --  end remove_sa;


   procedure move (ab : in out T_arbre; dest : in out T_arbre; data : in T_contenu) is
   Begin
      -- remove(ab, data);
      ajouter_enfants(dest, data);
   end move;


   function find(ab : in T_arbre; data : in T_contenu) return T_arbre is
      addr : T_arbre;
      tmp : liste_elem.T_liste;
   Begin
      tmp := ab.all.enfants;
      if ab.all.f_info = data then
         return ab;
      else
         while not liste_elem.est_vide(tmp) loop
            if is_equals(liste_elem.get_contenu(tmp).all.f_info, data) then
               return liste_elem.get_contenu(tmp);
            else
               addr := find(liste_elem.get_contenu(tmp), data);
               tmp := liste_elem.get_next(tmp);
            end if;
         end loop;
      end if;
      return addr;
   end find;



   function get_root(ab : in T_arbre) return T_arbre is
   Begin
      if ab.all.parent /= null then
         return get_root(ab.all.parent);
      else
         return ab;
      end if;
   end get_root;


   procedure set_arbre(ab : in T_arbre; ab2 : out T_arbre) is
   Begin
      ab2 := ab;
   end set_arbre;


   function get_contenu (ab : in T_arbre) return T_contenu is
      arbre_vide : exception;
   Begin
      if ab /= null then
         return ab.all.f_info;
      else
         raise arbre_vide;
      end if;
   end get_contenu;

   --  function etage (ab : in T_arbre) return Integer is
   --     n : Integer;
   --     tmp : T_arbre := ab;
   --  Begin
   --     if tmp /= null then

end p_arbre;
