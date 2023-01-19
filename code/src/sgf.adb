with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with ada.strings.Unbounded; use ada.strings.Unbounded;
with Ada.Text_IO;
with parser; use parser;
with p_arbre;

package body sgf is


   function cmp_name (x : in T_info; y : in T_info) return Boolean is
   Begin
      return x.name = y.name;
   end cmp_name;

   procedure formatage_disque is
      data : T_info;
   Begin
      init(arbre);
      data.name := To_Unbounded_String("\");
      data.isFile := False;
      creer_racine(arbre, data);
      set_arbre(arbre, noeud_courant);
   end formatage_disque;


   function repo_courant return Unbounded_String is
   Begin
      return get_contenu(noeud_courant).name;
   end repo_courant;


   procedure change_dir(destination : in T_PATH) is
      data : T_info;
      new_noeud : T_arbre;
   Begin
      data.name := liste_cmd.get_contenu(destination.chemin);
      set_arbre(cherche(arbre, data), noeud_courant);
      put(get_contenu(noeud_courant).name);
   end change_dir;


   procedure creer_fichier_dossier(path : in T_PATH; estFichier : in Boolean; existe : in Boolean) is
      data : T_info;
      tmp : T_info;
   Begin
      tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin));
      set_arbre(cherche(arbre, tmp), noeud_courant);
      data.name := liste_cmd.get_contenu(path.chemin);
      data.isFile := estFichier;
      data.taille := 0;
      if existe then
         Put_Line(data.contenu);
      end if;
      if estFichier then
         Text_IO.Put_Line("Saisissez le contenu du fichier");
         Get_line(data.contenu); text_io.Skip_Line;
         data.taille := 5; --Count(data.contenu);
      end if;
      if existe then
         -- modifier_noeud(noeud_courant, data);
         null;
      else
         -- Text_IO.put("ok");
         ajouter_enfants(noeud_courant, data);
         -- Text_IO.put("ko");
      end if;
   end creer_fichier_dossier;


   procedure liste_contenu(path : in T_PATH; dir_fils : Boolean)  is
   Begin
      if dir_fils then
         null;
         --print_all(noeud_courant);
      else
         null;
         --print_fils(noeud_courant);
      end if;
   end liste_contenu;


   procedure supp_fichier_dossier(path : in T_PATH) is
      tmp : T_info;
   Begin
      tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin));
      set_arbre(cherche(arbre, tmp), noeud_courant);
      -- remove(arbre, get_contenu(noeud_courant));
   end supp_fichier_dossier;


   procedure archive_dir (path : in T_PATH) is
      data, tmp : T_info;
      nom : Unbounded_String;
   Begin
      tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin));
      set_arbre(cherche(arbre, tmp), noeud_courant);
      nom := get_contenu(noeud_courant).name;
      append(nom, To_Unbounded_String(".zip"));
      data.isFile := True;
      data.taille := 0;
   end archive_dir;


   procedure test (ab : in out T_arbre; noeud : in out T_arbre) is
      path : T_path;
   Begin
      formatage_disque;
      Put_line(repo_courant);
      path := traiter(To_Unbounded_String("/test/"));
      -- put(liste_cmd.get_contenu(path.chemin));
      creer_fichier_dossier(path, false, False);
      creer_fichier_dossier(path, true, true);
      creer_fichier_dossier(path, true, true);
      -- put(get_contenu(noeud).name);
      -- put_line(repo_courant);
   end test;

end sgf;
