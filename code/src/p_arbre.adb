with file_gen;
with liste_gen;
package body p_arbre is

   package file is new file_gen(T_element => Ptr_noeud);
   use file;

   package liste_file is new liste_gen(un_type => Ptr_noeud);
   use liste_file;

   function init return Ptr_noeud is
      p : Ptr_noeud;
   Begin
      p := new T_noeud;
      p:= null;
      return p;
   end init;


   procedure afficher_arbre (ab : in Ptr_noeud) is
      arbre_vide : exception;
      une_file : file.T_file;
      curseur : Ptr_noeud;
      tmp : file.T_file;
   Begin
      curseur := ab;
      if curseur /= null then
         afficher_noeud(curseur.all.f_info);
         file.enfiler(une_file, curseur.all.enfants);
         defiler(une_file, tmp);
      else
         raise arbre_vide;
      end if;
   end afficher_arbre;

end p_arbre;
