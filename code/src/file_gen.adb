with p_liste_gen;
with Ada.Unchecked_Deallocation;

package body file_gen is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_cellule, Name => T_File);

   procedure initialiser(une_file : out T_file) is
   Begin
      une_file := new T_cellule;
      une_file := null;
   end initialiser;

   function is_empty(une_file : in T_file) return Boolean is
   Begin
      return une_file = null;
   end is_empty;

   procedure enfiler (une_file : in out T_file; elem : in T_element) is
   Begin
      une_file := new T_cellule'(elem, une_file);
   end enfiler;


   procedure enfiler_liste (une_file : in out T_file; elem : in liste_elem.T_liste) is
      curseur : liste_elem.T_liste;
   Begin
      curseur := elem;
      while not est_vide(curseur) loop
         enfiler(une_file, get_contenu(curseur));
         curseur := get_next(curseur);
      end loop;
   end enfiler_liste;


   function taille(une_file : in T_file) return Integer is
   Begin
      if une_file = null then
         return 0;
      else
         return taille(une_file.all.suivant) + 1;
      end if;
   end taille;

   procedure defiler (une_file : in out T_file; res : out T_file) is
      avant_d, d : T_file;
   Begin
      if une_file /= null then
         if une_file.all.suivant = null then
            res := une_file;
            une_file := null;
         else
            avant_d := une_file;
            d := une_file.all.suivant;
            while d.all.suivant /= null loop
               avant_d := d;
               d := d.all.suivant;
            end loop;
            res := d;
            avant_d.all.suivant := null;
         end if;
      else
         res := null;
      end if;
   end defiler;

   function get_contenu (une_file : in T_file) return T_element is
   Begin
      return une_file.all.valeur;
   end get_contenu;

end file_gen;
