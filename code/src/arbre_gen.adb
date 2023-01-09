with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;


package body arbre_gen is


   procedure free is new Ada.Unchecked_Deallocation(Object => T_noeud, Name => T_AB);


   procedure Initialiser(Abr: out T_AB) is
   Begin
      Abr := new T_noeud;
      Abr := null;
   end Initialiser;


   function Est_Vide (Abr : in T_AB) return Boolean is
   Begin
      return (Abr = null);
   end Est_Vide;


   procedure Inserer (Abr : in out T_AB ; Donnee : in un_type) is
      donnee_presente : EXCEPTION;
   Begin
      if Abr = null then
         Abr := new T_noeud;
         Abr.all.contenu := Donnee;
      else
         if Abr.all.contenu > Donnee then
            Inserer(Abr.all.f_g, Donnee);
         elsif Abr.all.contenu < Donnee then
            Inserer(Abr.all.f_d, Donnee);
         else
            raise donnee_presente;
         end if;
      end if;
   end inserer;


   function Recherche (Abr : T_AB; Donnee: in un_type) return Boolean is
   Begin
      if Abr /= null then
         if Abr.all.contenu > Donnee then
            return Recherche(Abr.all.f_g, Donnee);
         elsif Abr.all.contenu < Donnee then
            return Recherche(Abr.all.f_d, Donnee);
         else
            return True;
         end if;
      else
         return false;
      end if;
   end recherche;


   procedure Modifier (Abr : in out T_AB ; src_donnee : in un_type; tar_donnee : in un_type) is
      abr_vide, element_present, element_absent : EXCEPTION;
   Begin
      if Abr /= null then
         if not Recherche(Abr, src_donnee) then
            raise element_absent;
         end if;
         if Recherche(Abr, tar_donnee) then
            raise element_present;
         end if;
         Supprimer(Abr, src_donnee);
         Inserer(Abr, tar_donnee);
      else
         raise abr_vide;
      end if;
   end modifier;


   procedure Supprimer (Abr : in out T_AB; donnee : in un_type) is
      noeud_temp : T_AB;
      abr_vide, donnee_absente: EXCEPTION;
      f_g, f_d : Boolean;
   Begin
      if Abr = null then
         raise abr_vide;
      else
         f_g := (Abr.all.f_g /= null);
         f_d := (Abr.all.f_d /= null);
         if Recherche(Abr, donnee) then
            if Abr.all.contenu = donnee then
               if not f_g and then not f_d then -- cas ou le noeud n'a pas de fils, on libere direct le noeud
                  free(Abr);
               elsif not f_g and then f_d then    -- cas ou le noeud a un fils à droite
                  noeud_temp := Abr;
                  Abr := Abr.all.f_d;
                  free(noeud_temp);
               elsif f_g and then not f_d then -- cas ou le noeud a un fils à gauche
                  noeud_temp := Abr;
                  Abr := Abr.all.f_g;
                  free(noeud_temp);
               elsif f_g and then f_d then -- cas ou le noeud a deux fils
                  Abr.all.contenu := maximum(Abr.all.f_g);
                  supprimer(Abr, maximum(Abr.all.f_g));
               end if;
            elsif donnee < Abr.all.contenu then
               supprimer(Abr.all.f_g, donnee);
            elsif donnee > Abr.all.contenu then
               supprimer(Abr.all.f_d, donnee);
            end if;
         else
            raise donnee_absente;
         end if;
      end if;
   end supprimer;


   procedure Afficher (Abr : in T_AB) is
      abr_vide : EXCEPTION;
   Begin
      if Abr /= null then
         if Abr.all.f_g /= null then
            Afficher(Abr.all.f_g);
         end if;
         Put(Integer'Image(Abr.all.contenu));
         New_Line;
         if Abr.all.f_d /= null then
            afficher(Abr.all.f_d);
         end if;
      else
         raise abr_vide;
      end if;
   end afficher;


   function maximum (Abr : T_AB) return un_type is
   Begin
      if Abr /= null then
         if Est_Vide(Abr.all.f_d) then
            return Abr.all.contenu;
         else
            return maximum(Abr.all.f_d);
         end if;
      else
         -- raise abr_vide;
         return 0;
      end if;
   end maximum;


end arbre_gen;
