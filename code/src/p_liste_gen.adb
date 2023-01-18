with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;


package body P_liste_gen is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_cellule, Name => T_liste);

   function creer_liste_vide return T_liste is
      une_liste : T_liste;
   Begin
      une_liste := new T_cellule;
      une_liste := null;
      return une_liste;
   end creer_liste_vide;


   function est_vide (une_liste : in T_liste) return boolean is
   Begin
      return une_liste = null;
   end est_vide;


   procedure inserer_en_tete (une_liste : in out T_liste; n : in T_type) is
      p: T_liste;
   Begin
      p := new T_cellule;
      p.all.valeur := n;
      p.all.suivant := une_liste;
      une_liste := p;
   end inserer_en_tete;


   procedure inf_liste(x : in T_Type; y : in T_type; z : out Boolean) is
   Begin
      inf_gen(x, y, z);
   end inf_liste;


   procedure afficher_liste (une_liste : in T_liste) is
   Begin
      if une_liste /= null then
         afficher_gen(une_liste.all.valeur);
         afficher_liste(une_liste.all.suivant);
      end if;
   end afficher_liste;


   function rechercher (une_liste : in T_liste; e : in T_type) return T_liste is
      address : T_liste;
      temp_liste : T_liste;
   Begin
      if une_liste = null then
         return null; --la liste est vide
      else
         temp_liste := une_liste;
         while temp_liste /= null loop
            if temp_liste.all.valeur = e then
               address := temp_liste;
               return address; --la valeur est présente on renvoie l'adresse
            end if;
            temp_liste := temp_liste.suivant;
         end loop;
         return null;
      end if;
   end rechercher;


   procedure inserer_apres (une_liste : in out T_liste; n : in T_type; data : in T_type) is
      address_data : T_liste;
   Begin
      if une_liste = null then
         raise liste_vide;
      end if;
      address_data := rechercher(une_liste, data);
      if address_data = null then
         raise element_absent;
      end if;
      address_data.suivant := new T_cellule'(n, address_data.all.suivant);
   end inserer_apres;



   procedure inserer_avant (une_liste : in out T_liste; n : in T_type; data : in T_type) is
      address_data, temp_liste, prec_liste : T_liste;
   Begin
      if une_liste = null then
         raise liste_vide;
      end if;
      temp_liste := une_liste;
      prec_liste := null;
      while temp_liste.all.valeur /= data loop
         prec_liste := temp_liste;
         temp_liste := temp_liste.suivant;
      end loop;
      if prec_liste = null then
         inserer_en_tete(une_liste, n);
      elsif temp_liste = null then
         raise element_absent;
      else
         address_data := new T_cellule'(n, prec_liste.all.suivant);
      end if;
   end inserer_avant;


   procedure enlever(une_liste : in out T_liste; e : in T_type) is
      temp_liste, prec_liste : T_liste;
   Begin
      if une_liste = null then
         null;
      else
         temp_liste := une_liste;
         prec_liste := null;
         while temp_liste /= null and then temp_liste.all.valeur /= e loop
            prec_liste := temp_liste;
            temp_liste := temp_liste.suivant;
         end loop;
         if prec_liste = null then
            if temp_liste /= null then
               une_liste := temp_liste.all.suivant;
            end if;
         elsif temp_liste.all.valeur = e then
            prec_liste.all.suivant := temp_liste.all.suivant;
            free(temp_liste);
         end if;
      end if;
   end enlever;


   function get_contenu (une_liste : in T_liste) return T_type is
      vide : EXCEPTION;
   Begin
      if une_liste = null then
         raise vide;
      else
         return une_liste.all.valeur;
      end if;
   end get_contenu;


   function get_next (une_liste : in T_liste) return T_liste is
   Begin
      return une_liste.all.suivant;
   end get_next;


   function get_liste (une_liste : in T_liste) return T_liste is
   Begin
      return une_liste;
   end get_liste;


   function get_last (une_liste : in T_liste) return T_type is
      tmp : T_liste;
   Begin
      if tmp.all.suivant = null then
         return tmp.all.valeur;
      else
         return get_last(tmp.all.suivant);
      end if;
   end get_last;


end P_liste_gen;
