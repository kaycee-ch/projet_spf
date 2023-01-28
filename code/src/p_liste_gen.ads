generic
   Type T_type is private;


package P_liste_gen is

   Type T_liste is private;

   function creer_liste_vide return T_liste;
   -- semantique : créer une liste vide
   -- pre : none
   -- post : est_vide (1) vaut vrai
   -- exception : none

   function est_vide (une_liste : in T_liste) return boolean;
   -- semantique : tester si une liste 1 est vide
   -- pre : none
   -- post : none
   -- exception : none


   procedure inserer_en_tete (une_liste : in out T_liste; n : in T_type);
   -- semantique : insere l'element nouveau en tete de la liste 1
   -- pre : none
   -- post : n appartient à la liste
   -- exception : aucune

   procedure inserer_fin (une_liste : in out T_liste; n : in T_type);

   generic
      with procedure afficher_gen(le_type : in T_type);
   procedure afficher_liste (une_liste : in T_liste);
   -- semantique : afficher les elements de la liste 1
   -- pre : none
   -- post : none
   -- exception : none


   function rechercher( une_liste : in T_liste; e : in T_type) return T_liste;
   -- semantique : recher si e est présent dans la liste 1, retourne son adresse ou null si la liste est vide ou si e n'appartient pas à la liste
   -- pre : none
   -- post : none
   -- exception : none


   procedure inserer_apres (une_liste : in out T_liste; n : in T_type; data : in T_type);
   -- semantique : insere dans la liste 1 (liste vide ou non vide), l'élement nouveau après la valeur data
   -- pre : none
   -- post : n appartient à une_liste
   -- exception : data n'est pas dans la liste ou la liste est vide


   procedure inserer_avant (une_liste : in out T_liste; n : in T_type; data : in T_type);
   -- semantique : insere dans la liste 1 (liste vide ou non vide), l'élement nouveau avant la valeur data
   -- pre : none
   -- post : n appartient à une_liste
   -- exception : data n'est pas dans la liste ou la liste est vide

   function inverser_liste(une_liste : in T_liste) return T_liste;


   procedure enlever(une_liste : in out T_liste; e : in T_type);
   -- semantique : enlever un element e de la liste (vide ou non)
   -- pre : none
   -- post : e n'appartient pas à la liste
   -- exception : aucune

   function get_contenu (une_liste : in T_liste) return T_type;

   function get_next (une_liste : in T_liste) return T_liste;

   function get_last (une_liste : in T_liste) return T_liste;

   function contient (une_liste : in T_liste; e : in T_type) return Boolean;


private
   TYPE T_cellule;
   TYPE T_liste is access T_cellule;
   TYPE T_cellule is record
      valeur : T_type;
      suivant : T_liste;
   end record;

   liste_vide : exception;
   element_absent : exception;

end P_liste_gen;
