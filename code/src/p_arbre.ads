with p_liste_gen;
with file_gen;

generic
   TYPE T_contenu is private;

package p_arbre is

   arbre_vide : EXCEPTION;

   TYPE T_arbre is limited private;

   procedure init (ab : out T_arbre);

   procedure creer_racine(ab : in out T_arbre; data : T_contenu);

   procedure ajouter_enfants(ab : in out T_arbre; data : T_contenu);

   function find(ab : in T_arbre; data : in T_contenu) return T_arbre;
   -- pre : ab /= null

   procedure move (ab : in out T_arbre; dest : in T_arbre; data : in T_contenu);

   procedure remove (ab : in out T_arbre; data : in T_contenu);

   function get_info (ab : in T_arbre) return T_contenu;

   -- function get_parent (ab : in T_arbre) return T_arbre;

   generic
      with procedure afficher_noeud(n : in T_contenu);
   procedure print(Ab : in T_arbre);

private
   TYPE T_noeud;
   TYPE T_arbre is access T_noeud;


   function equal_ptr(a : in T_arbre; b : T_arbre) return boolean;

   package file is new file_gen(T_element => T_arbre, Equal => equal_ptr);
   use file;

   TYPE T_noeud is record
      f_info : T_contenu;
      parent : T_arbre;
      enfants : file.liste_elem.T_liste;
   end record;

   TYPE Ptr_int is access Integer;

end p_arbre;
