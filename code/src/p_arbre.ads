with p_liste_gen;
with file_gen;

generic
   TYPE T_contenu is private;
    with function is_equals(x : in T_contenu; y : in T_contenu) return Boolean;

package p_arbre is

   arbre_vide : EXCEPTION;

   TYPE T_arbre is private;

   TYPE T_liste is private;


   procedure init (ab : out T_arbre);

   procedure creer_racine(ab : in out T_arbre; data : T_contenu);

   procedure ajouter_enfants(ab : in out T_arbre; data : T_contenu);

   -- procedure afficher (ab : in T_arbre);



   function cherche_enfant(ab : in T_arbre; data : in T_contenu) return T_arbre;


   function find(ab : in T_arbre; data : in T_contenu) return T_arbre;
   -- pre : ab /= null




   procedure move (ab : in out T_arbre; dest : in out T_arbre; data : in T_contenu);



   procedure remove (ab : in out T_arbre; data : in T_contenu);

   -- procedure remove_sa (ab : in out T_arbre);

   function get_root(ab : in T_arbre) return T_arbre;

   function get_enfants (ab : in T_arbre) return T_liste;

   function get_contenu (ab : in T_arbre) return T_contenu;

   procedure set_arbre(ab : in T_arbre; ab2 : out T_arbre);

   function ab_est_vide (ab : in T_arbre) return Boolean;

   function profondeur(ab : in T_arbre) return Integer;
   function get_parent (ab : in T_arbre) return T_arbre;
   procedure modifier (ab : in out T_arbre; new_data : in T_contenu);
   procedure supp_enfants (ab : in out T_arbre);

   generic
      with procedure afficher_noeud(n : in T_contenu; indent : in Integer);
   procedure print(Ab : in T_arbre);


private
   TYPE T_noeud;
   TYPE T_arbre is access T_noeud;

   package file is new file_gen(T_element => T_arbre);
   use file;

   TYPE T_cellule;
   TYPE T_liste is access T_cellule;
   TYPE T_cellule is record
      valeur : T_arbre;
      suivant : T_liste;
   end record;

   TYPE T_noeud is record
      f_info : T_contenu;
      parent : T_arbre;
      enfants : file.liste_elem.T_liste;
   end record;



end p_arbre;
