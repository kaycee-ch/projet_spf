with liste_gen;

generic
   TYPE T_contenu is private;

package p_arbre is

   arbre_vide : EXCEPTION;

   TYPE Ptr_noeud is private;



   function init return Ptr_noeud;
   --procedure ajouter(ab : in out Ptr_noeud; data : T_contenu);
   --procedure supprimer(ab : in out Ptr_noeud; data : in T_contenu);
   --procedure modifier(ab : in out Ptr_noeud; old_data : in T_contenu; new_data : in T_contenu);
   --procedure rechercher(ab : in out Ptr_noeud; old_data : in T_contenu; new_data : in T_contenu);

   generic
      with procedure afficher_noeud(n : in T_contenu);
      procedure afficher_arbre(Ab : in Ptr_noeud);

   private
   TYPE T_noeud;
   TYPE Ptr_noeud is access T_noeud;

   package P_noeud is new liste_gen(un_type => Ptr_noeud); use P_noeud;

   TYPE T_noeud is record
      f_info : T_contenu;
      parent : Ptr_noeud;
      enfants : P_noeud.liste;
   end record;


end p_arbre;
