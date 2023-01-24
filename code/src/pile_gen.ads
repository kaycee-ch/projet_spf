generic
   TYPE un_type is private;

package pile_gen is
   TYPE pile is private;

   procedure creer_pile_vide (une_pile : out pile);
   -- semantique : créer une liste vide
   -- pre : none
   -- post : est_vide (1) vaut vrai
   -- exception : none

   function est_vide (une_pile : in pile) return boolean;
   -- semantique : tester si une liste 1 est vide
   -- pre : none
   -- post : none
   -- exception : non



   -- procedure test (une_pile : in out pile);

  function depiler(une_pile : in out pile) return un_type;

   procedure afficher_pile (une_pile : in pile);

   generic



   function sommet (une_pile : in pile) return un_type;


   procedure empiler (une_pile : in out pile; n : in un_type);
   -- semantique : insere l'element nouveau en tete de la liste 1
   -- pre : none
   -- post : n appartient à la liste
   -- exception : aucune



private
   TYPE etage;
   TYPE pile is access etage;
   TYPE etage is RECORD
      element : un_type;
      inf : pile;
   end RECORD;

end pile_gen;
