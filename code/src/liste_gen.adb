with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;


package body liste_gen is

   procedure free is new Ada.Unchecked_Deallocation(Object => T_TAB, Name => liste);

   function creer_noeud(file_bool : BOOLEAN; noeud_name : Character) return T_noeud is
      un_noeud : T_NOEUD;
   Begin
      un_noeud.isFile := file_bool;
      un_noeud.name := noeud_name;
      return un_noeud;
   end creer_noeud;

   function creer_cellule(noeud : T_noeud) return cellule is
      une_cell : cellule;
   Begin
      une_cell.valeur := noeud;
      une_cell.suivant := null;
      return une_cell;
   end creer_cellule;


   function creer_liste_vide return liste is
      une_liste : liste;
   Begin
      une_liste := new T_TAB;
      une_liste := null;
      return une_liste;
   end creer_liste_vide;


   function est_vide (une_liste : in liste) return boolean is
   Begin
      if une_liste = null then
         return true;
      else
         return false;
      end if;
   end est_vide;


   procedure inserer_en_tete (une_liste : in out liste; c : in cellule) is
      t : liste;
   Begin
      if une_liste = null then
         t := new T_TAB;
         t.all.le_tab(0).valeur := c.valeur;
         t.all.le_tab(0).suivant := une_liste;
         une_liste := t;
      else
         raise liste_vide;
      end if;
   end inserer_en_tete;


   procedure afficher_liste (une_liste : in liste) is
      index : INTEGER := 0;
   Begin
      if une_liste /= null then
         if index < 1 then
            Put(une_liste.all.le_tab(index).valeur.name);
            afficher_liste(une_liste.all.le_tab(index + 1).suivant);
         end if;
      else
         raise liste_vide;
      end if;
   end afficher_liste;


   --  function rechercher (une_liste : in liste; e : in String) return liste is
   --     address : liste;
   --     temp_liste : liste;
   --  Begin
   --     if une_liste = null then
   --        return null; --la liste est vide
   --     else
   --        temp_liste := une_liste;
   --        while temp_liste /= null loop
   --           if temp_liste.all.valeur.name = e then
   --              address := temp_liste;
   --              return address; --la valeur est présente on renvoie l'adresse
   --           end if;
   --           temp_liste := temp_liste.suivant;
   --        end loop;
   --        return null;
   --     end if;
   --  end rechercher;
   --
   --
   --  procedure enlever(une_liste : in out liste; e : in String) is
   --     temp_liste, prec_liste : liste;
   --  Begin
   --     if une_liste = null then
   --        null;
   --     else
   --        temp_liste := une_liste;
   --        prec_liste := null;
   --        while temp_liste /= null and then temp_liste.all.valeur.name /= e loop
   --           prec_liste := temp_liste;
   --           temp_liste := temp_liste.suivant;
   --        end loop;
   --        if prec_liste = null then
   --           if temp_liste /= null then
   --              une_liste := temp_liste.all.suivant;
   --           end if;
   --        elsif temp_liste.all.valeur.name = e then
   --           prec_liste.all.suivant := temp_liste.all.suivant;
   --           free(temp_liste);
   --        end if;
   --     end if;
   --  end enlever;


end liste_gen;
