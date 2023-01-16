with p_liste_gen;
with file_gen;

generic
   TYPE T_contenu is private;

package p_arbre is

   arbre_vide : EXCEPTION;

   TYPE T_arbre is private;



   function init return T_arbre;

   procedure add(ab : in out T_arbre; data : T_contenu);

   function find(ab : in T_arbre; data : in T_contenu) return T_arbre;

   procedure move (ab : in out T_arbre; dest : in T_arbre; data : in T_contenu);

   procedure remove (ab : in out T_arbre; data : in T_contenu);

   generic
      with procedure afficher_noeud(n : in T_contenu);
   procedure print(Ab : in T_arbre);

private
   TYPE T_noeud;
   TYPE T_arbre is access T_noeud;

   package P_noeud is new p_liste_gen(T_type => T_arbre); use P_noeud;

   package liste_file is new p_liste_gen(T_type => T_arbre);
   use liste_file;

   package file is new file_gen(T_element => liste_file.T_liste);
   use file;



   TYPE T_noeud is record
      f_info : T_contenu;
      parent : T_arbre;
      enfants : liste_elem.T_liste;
   end record;


end p_arbre;
