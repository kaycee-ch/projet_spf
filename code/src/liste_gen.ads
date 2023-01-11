with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

generic
   Type un_type is private;


package liste_gen is

   Type liste is private;
   liste_vide : exception;
   element_absent : exception;

   function creer_liste_vide return liste;
   -- semantique : créer une liste vide
   -- pre : none
   -- post : est_vide (1) vaut vrai
   -- exception : none

   function est_vide (une_liste : in liste) return boolean;
   -- semantique : tester si une liste 1 est vide
   -- pre : none
   -- post : none
   -- exception : none


   procedure inserer_en_tete (une_liste : in out liste; n : in un_type);
   -- semantique : insere l'element nouveau en tete de la liste 1
   -- pre : none
   -- post : n appartient à la liste
   -- exception : aucune

   generic
      with procedure afficher_gen(le_type : in un_type);
   procedure afficher_liste (une_liste : in liste);
   -- semantique : afficher les elements de la liste 1
   -- pre : none
   -- post : none
   -- exception : none


   function rechercher( une_liste : in liste; e : in un_type) return liste;
   -- semantique : recher si e est présent dans la liste 1, retourne son adresse ou null si la liste est vide ou si e n'appartient pas à la liste
   -- pre : none
   -- post : none
   -- exception : none


   procedure inserer_apres (une_liste : in out liste; n : in un_type; data : in un_type);
   -- semantique : insere dans la liste 1 (liste vide ou non vide), l'élement nouveau après la valeur data
   -- pre : none
   -- post : n appartient à une_liste
   -- exception : data n'est pas dans la liste ou la liste est vide


   procedure inserer_avant (une_liste : in out liste; n : in un_type; data : in un_type);
   -- semantique : insere dans la liste 1 (liste vide ou non vide), l'élement nouveau avant la valeur data
   -- pre : none
   -- post : n appartient à une_liste
   -- exception : data n'est pas dans la liste ou la liste est vide


   procedure enlever(une_liste : in out liste; e : in un_type);
   -- semantique : enlever un element e de la liste (vide ou non)
   -- pre : none
   -- post : e n'appartient pas à la liste
   -- exception : aucune

   function get_contenu (une_liste : in liste) return un_type;


   function get_next (une_liste : in liste) return liste;


private
   TYPE cellule;
   TYPE liste is access cellule;
   TYPE cellule is record
      valeur : un_type;
      suivant : liste;
   end record;
end liste_gen;
