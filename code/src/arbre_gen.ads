package arbre_gen is

   type T_AB is private;

   procedure Initialiser(Abr: out T_AB);

   function Est_Vide (Abr : T_AB) return Boolean;

   procedure Inserer (Abr : in out T_AB ; Donnee : in un_type);

   function Recherche (Abr : T_AB; Donnee: in un_type) return Boolean;

   procedure Modifier (Abr : in out T_AB ; src_donnee : in un_type; tar_donnee : in un_type);

   procedure Supprimer (Abr : in out T_AB; donnee : in un_type);

   procedure Afficher (Abr : in T_AB);

   function maximum (Abr : T_AB) return un_type;
   -- pre
   -- post
   --

private
   TYpe T_noeud;
   TYPE T_AB is access T_noeud;
   TYPE T_noeud is record
      f_g : T_AB;
      contenu : Integer;
      f_d : T_AB;
   end record;

end arbre_gen;
