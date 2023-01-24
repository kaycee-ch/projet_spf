with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body pile_gen is

   procedure free is new Ada.Unchecked_Deallocation(Object => etage, Name => pile);

   procedure creer_pile_vide(une_pile : out pile) is
   Begin
      une_pile := new etage;
      une_pile := null;
   end creer_pile_vide;

   function est_vide (une_pile : in pile) return boolean is
   Begin
      return une_pile = null;
   end est_vide;


   procedure empiler (une_pile : in out pile; n : in un_type) is
      p : pile;
   Begin
      p := new etage;
      p.all.element := n;
      p.all.inf := une_pile;
      une_pile := p;
   end empiler;


   function depiler(une_pile : in out pile) return un_type is
      p : pile;
      pile_vide : exception;
      data : un_type;
   Begin
      if une_pile /= null then
         data := une_pile.all.element;
         p := une_pile;
         une_pile := une_pile.all.inf;
         free(p);
         return data;
      else
         raise pile_vide;
      end if;
   end depiler;

   function sommet (une_pile : in pile) return un_type is
      pile_vide : exception;
   Begin
      if une_pile /= null then
         return une_pile.all.element;
      else
         raise pile_vide;
      end if;
   end sommet;

   procedure afficher_pile (une_pile : in pile) is
      pile_vide : exception;
   Begin
      if une_pile /= null then
         Put("test");
         afficher_pile(une_pile.all.inf);
      end if;
   end afficher_pile;

   --  procedure test (une_pile : in out pile) is
   --  Begin
   --     creer_pile_vide(une_pile);
   --     empiler(une_pile, 5);
   --     empiler(une_pile, 3);
   --     empiler(une_pile, 9);
   --     afficher_pile(une_pile);
   --     if sommet(une_pile) = 9 then
   --        Put_Line("ok");
   --     else
   --        Put_Line("ko");
   --     end if;
   --     depiler(une_pile);
   --     afficher_pile(une_pile);
   --     depiler(une_pile);
   --     afficher_pile(une_pile);
   --     depiler(une_pile);
   --     afficher_pile(une_pile);
   --     if est_vide(une_pile) then
   --        Put_Line("ok");
   --     else
   --        Put_Line("ko");
   --     end if;
   --  end test;

end pile_gen;
