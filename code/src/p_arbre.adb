with Ada.Text_IO; use Ada.Text_IO;
with Ada.strings.Unbounded; use Ada.Strings.Unbounded;
with file_gen;
with p_liste_gen;
with Ada.Unchecked_Deallocation;

package body p_arbre is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_noeud, Name => T_arbre);


   procedure init (ab : out T_arbre) is
   Begin
      ab := null;
   end init;

   procedure creer_racine(ab : in out T_arbre; data : in T_contenu) is
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
      -- cette fonction revient compte rle nombre de noeud entre ab et root
      r := get_root(ab);
      tmp := ab;
      -- tant que je ne suis pas à la racine je boucle
      while tmp /= r loop
         -- j'incrémente n de 1 parce que j'ai renontré un nouveau noeud
         n := n + 1;
         -- je remonte d'un noeud
         tmp := tmp.all.parent;
      end loop;
      return n;
   end profondeur;


   procedure ajouter_enfants(ab : in out T_arbre; data : in T_contenu) is
      tmp : T_arbre;
   Begin
      if ab /= null then
         tmp := new T_noeud;
         tmp.all.f_info := data;
         tmp.all.parent := ab;
         tmp.all.enfants := liste_elem.creer_liste_vide;
         liste_elem.inserer_en_tete(ab.all.enfants, tmp);
      else
         raise arbre_vide;
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
         -- j'utilise un affichage générique car il dépendra du contenu du noeud qui est lui meme generique
         afficher_noeud(curseur.all.f_info, profondeur(ab));
         -- j'enfile tous les enfants qui car ils seraient perdu dans l'appel récursif
         file.enfiler_liste(une_file, curseur.all.enfants);
         while not file.is_empty(une_file) loop
            defiler(une_file, tmp);
            -- je rappel print sur le premier enfant qui sera affiché puis je descends dans ses enfants à lui et ainsi de suite
            print(file.get_contenu(tmp));
         end loop;
      else
         raise arbre_vide;
      end if;
   end print;



   procedure remove (ab : in out T_arbre; data : in T_contenu) is
      addr : T_arbre;
      l_addr : liste_elem.T_liste;
   Begin
      -- cette procedure ne prévient pas des fuites de mémoire puisqu'on supprime le noeud au lieu de supprimer tous les noeuds du sous-arbre
      addr := find(ab, data);
      if addr /= null then
         if (not liste_elem.est_vide(addr.all.parent.all.enfants)) then
            -- je cherche (recherche de la lise) parmi les enfants du père de ab celui qui a pour contenu data et je l'enlève de la liste
            l_addr := liste_elem.rechercher(addr.all.parent.all.enfants, addr);
            liste_elem.enlever(addr.all.parent.all.enfants, liste_elem.get_contenu(l_addr)); -- = addr
            -- je libère la case mémoire
            free(addr);
         end if;
      else
         raise data_absente;
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




   function find(ab : in T_arbre; data : in T_contenu) return T_arbre is
      addr : T_arbre;
      tmp : liste_elem.T_liste;
      present : Boolean := false;
   Begin
      if ab /= null then
         tmp := ab.all.enfants;
         -- si ab a le contenu voulu on revoie direct ab
         if is_equals(ab.all.f_info, data) then
            return ab;
         else
            while not liste_elem.est_vide(tmp) and not present loop
               if is_equals(liste_elem.get_contenu(tmp).all.f_info, data) then
                  return liste_elem.get_contenu(tmp);
               else
                  addr := find(liste_elem.get_contenu(tmp), data);
                  if ab_est_vide(addr) then
                     tmp := liste_elem.get_next(tmp);
                  else
                     present := true;
                  end if;
               end if;
            end loop;
         end if;
         return addr;
      else
         return null;
      end if;
   end find;


   function get_root(ab : in T_arbre) return T_arbre is
   Begin
      if ab /= null then
         if ab.all.parent /= null then
            return get_root(ab.all.parent);
         else
            return ab;
         end if;
      else
         raise arbre_vide;
      end if;
   end get_root;


   procedure set_arbre(ab : in T_arbre; ab2 : out T_arbre) is
   Begin
      ab2 := ab;
   end set_arbre;

   function get_contenu(ab : in T_arbre) return T_contenu is
   Begin
      if not ab_est_vide(ab) then
         return ab.all.f_info;
      else
         raise arbre_vide;
      end if;
   end get_contenu;


   function get_parent (ab : in T_arbre) return T_arbre is
   Begin
      if not ab_est_vide(ab) then
         if not ab_est_vide(ab.all.parent) then
            return ab.all.parent;
         else
            return null;
         end if;
      else
         raise arbre_vide;
      end if;
   end get_parent;


   procedure modifier (ab : in out T_arbre; new_data : in T_contenu) is
      tmp : T_arbre;
   Begin
      if ab /= null then
         tmp := ab;
         liste_elem.enlever(ab.all.parent.all.enfants, tmp);
         tmp.all.f_info := new_data;
         liste_elem.inserer_en_tete(ab.all.parent.all.enfants, tmp);
      else
         raise arbre_vide;
      end if;
   end modifier;


   procedure supp_enfants (ab : in out T_arbre) is
   Begin
      if ab /= null then
         ab.all.enfants := liste_elem.creer_liste_vide;
      else
         raise arbre_vide;
      end if;
   end supp_enfants;



   function cherche_enfant(ab : in T_arbre; data : in T_contenu) return T_arbre is
      tmp_enf : liste_elem.T_liste;
      liste_vide : EXCEPTION;
      present : Boolean;
   Begin
      if ab = null then
         raise arbre_vide;
      else
         tmp_enf := ab.all.enfants;
         present := false;
         while not liste_elem.est_vide(tmp_enf) and not present loop
            if is_equals(liste_elem.get_contenu(tmp_enf).all.f_info, data) then
               present := True;
            else
               tmp_enf := liste_elem.get_next(tmp_enf);
            end if;
         end loop;

         if present then
            return liste_elem.get_contenu(tmp_enf);
         else
            return null;
         end if;
      end if;

   end cherche_enfant;


end p_arbre;
