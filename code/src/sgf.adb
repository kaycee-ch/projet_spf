with liste_gen; use liste_gen;
with arbre; use arbre;

package body sgf is

   procedure creer_fichier(path : String; file_name : float) is
      temp : liste;
      file_info : T_noeud;
   Begin
      temp := creer_liste_vide;
      file_info := (
      inserer_en_tete(temp, file_info);


   end creer_fichier;
end sgf;
