with p_liste_gen;

generic
   TYPE T_element is private;


package file_gen is
   TYPE T_file is limited private;


   package liste_elem is new p_liste_gen(T_type => T_element);
   use liste_elem;

   procedure initialiser(une_file : out T_file);

   procedure enfiler (une_file : in out T_file; elem : in T_element);

   procedure enfiler_liste (une_file : in out T_file; elem : in T_liste);

   procedure defiler (une_file : in out T_file; res : out T_file);

   function is_empty(une_file : in T_file) return Boolean;

   function taille(une_file : in T_file) return Integer;

   function get_contenu (une_file : in T_file) return T_element;


private
   TYPE T_cellule;

   TYPE T_File is access T_cellule;
   TYPE T_liste is access T_cellule;
   TYPE T_cellule is record
      valeur : T_element;
      suivant : T_file;
   end record;

end file_gen;
