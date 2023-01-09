with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;



package liste_gen is
type chaine_char is new String(1..10);
   Type liste is private;
   TYPE TAB is private;
   TYPE cellule is private;
   TYPE T_noeud is private;

   liste_vide : exception;
   element_absent : exception;

   function creer_liste_vide return liste;
   -- semantique : cr�er une liste vide
   -- pre : none
   -- post : est_vide (1) vaut vrai
   -- exception : none
   function creer_noeud(file_bool : BOOLEAN; noeud_name : character) return T_noeud;
   function creer_cellule(noeud : T_noeud) return cellule;
   function est_vide (une_liste : in liste) return boolean;
   -- semantique : tester si une liste 1 est vide
   -- pre : none
   -- post : none
   -- exception : none


   procedure inserer_en_tete (une_liste : in out liste; c : in cellule);
   -- semantique : insere l'element nouveau en tete de la liste 1
   -- pre : none
   -- post : n appartient � la liste
   -- exception : aucune

   procedure afficher_liste (une_liste : in liste);
   -- semantique : afficher les elements de la liste 1
   -- pre : none
   -- post : none
   -- exception : none


   --function rechercher( une_liste : in liste; e : in String) return liste;
   -- semantique : recherche si e est pr�sent dans la liste 1, retourne son adresse ou null si la liste est vide ou si e n'appartient pas � la liste
   -- pre : none
   -- post : none
   -- exception : none

   --procedure enlever(une_liste : in out liste; e : in String);
   -- semantique : enlever un element e de la liste (vide ou non)
   -- pre : none
   -- post : e n'appartient pas � la liste
   -- exception : aucune


private

   TYPE T_noeud is record
      isFile : Boolean;
      name : character;
      -- droits : String(1..10);
      taille : Integer; -- si fichier
   end record;
   NMAX : INTEGER := 100;
   TYPE T_TAB;
   TYPE liste is access T_TAB;
   TYPE TAB is ARRAY(0..NMAX) of cellule;
   TYPE T_TAB is record
      le_tab : TAB;
      nb_elem : INTEGER;
   end record;

   TYPE cellule is record
      valeur : T_noeud;
      suivant : liste;
   end record;

end liste_gen;
