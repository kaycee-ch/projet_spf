with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with ada.strings.Unbounded; use ada.strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with parser; use parser;
with p_arbre;

package body sgf is


   function cmp_name (x : in T_info; y : in T_info) return Boolean is
   Begin
      return x.name = y.name;
   end cmp_name;

   function is_equal (a : in T_arbre; b : in T_arbre) return Boolean is
   Begin
      return get_contenu(a).name = get_contenu(b).name;
   end is_equal;


   procedure print_str(data : in T_info; indent : in Integer) is
      m : Integer := length(data.name);
      tmp : String(1..m);
      str : String(1..3);
   Begin
      if indent = 0 then
         null;
      elsif indent = 1 then
         Put("\- ");
      else
         Put("|    ");
         str := "\- ";
         Put(str, indent*indent);
      end if;
      tmp:= to_string(data.name);
      Put(tmp);
      new_line;
   end print_str;


   procedure formatage_disque(sgf : in out T_sgf) is
      data : T_info;
   Begin
      init(sgf.root);
      data.name := To_Unbounded_String("\");
      data.isFile := False;
      creer_racine(sgf.root, data);
      set_arbre(sgf.root, sgf.noeud_courant);
   end formatage_disque;


   procedure repo_courant(sgf : in out T_sgf) is
      tmp : T_arbre := sgf.noeud_courant;
      p : pile;
   Begin
      creer_pile_vide(p);
      while not ab_est_vide(tmp) loop
         empiler(p, get_contenu(tmp).name);
         tmp := get_parent(tmp);
      end loop;
      -- afficher_pile(p);
      while not est_vide(p) loop
         put("/");
         Put(depiler(p));
      end loop;
   end repo_courant;


   procedure change_dir(sgf : in out T_sgf; destination : in T_PATH) is
      tmp_path : T_path := destination;
      first : Unbounded_String;
      tmp_ab : T_arbre;
      tmp_data : T_info;
      chemin_incorrect, isLast : Boolean := false;
      chemin_invalide : EXCEPTION;
   Begin
      -- Traiter la liste des étapes
      tmp_data.name := liste_cmd.get_contenu(tmp_path.chemin);
      tmp_ab := cherche(sgf.root, tmp_data);
      -- put(tmp_data.name);
      if get_contenu(tmp_ab).isFile then
         isLast := liste_cmd.est_vide(liste_cmd.get_next(tmp_path.chemin_inv));
      else
         isLast := liste_cmd.est_vide(tmp_path.chemin_inv);
      end if;
      while not isLast and not chemin_incorrect loop
         first := liste_cmd.get_contenu(tmp_path.chemin_inv);
         if first = to_unbounded_string(".") then
            set_arbre(sgf.noeud_courant, sgf.noeud_courant);
         elsif first = ".." then
            if not ab_est_vide(get_parent(sgf.noeud_courant)) then
               set_arbre(get_parent(sgf.noeud_courant), sgf.noeud_courant);
            else
               set_arbre(sgf.noeud_courant, sgf.noeud_courant);
            end if;
         else
            tmp_data.name := liste_cmd.get_contenu(liste_cmd.get_next(tmp_path.chemin_inv));
            tmp_ab := cherche(sgf.root, tmp_data);
            if not isLast then-- liste_cmd.contient(liste_cmd.get_enfants(noeud_courant), tmp_ab) then
               set_arbre(tmp_ab, sgf.noeud_courant);
            else
               chemin_incorrect := true;
            end if;
            liste_cmd.enlever(tmp_path.chemin_inv, first);
         end if;
      end loop;
      if chemin_incorrect then
         raise chemin_invalide;
      end if;
   end change_dir;


   procedure creer_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; estFichier : in Boolean; existe : in Boolean) is
      data : T_info;
      tmp : T_info;
      ab_tmp : T_arbre;
   Begin
      -- je récuppère l'avant dernier mot du path => c'est le nom du dossier ou je dois créer mon fichier/dossier
      tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin));
      -- put(tmp.name);
      -- je cherche le noeud de l'arbre correspondant au nom et j'y pointe le noeud_courant local à la procédure
      set_arbre(cherche(sgf.root, tmp), ab_tmp);
      -- affiche(ab_tmp);
      -- je récupère le dernier mot du path => c'est le nom du fichier/dossier que je crée
      data.name := liste_cmd.get_contenu(path.chemin);
      data.isFile := estFichier;
      data.taille := 0;
      -- si le c'est un fichier et qu'il existe deja j'affiche le contenu
      if existe and then estFichier then
         Put_Line(data.contenu);
      end if;
      if estFichier then
         Text_IO.Put_Line("Saisissez le contenu du fichier");
         Get_line(data.contenu); text_io.Skip_Line;
         data.taille := 5; --ada.strings.unbounded.count(data.contenu);
      end if;
      if existe then
         -- modifier_noeud(noeud_courant, data);
         null;
      else
         ajouter_enfants(ab_tmp, data);
      end if;
      -- affiche(ab_tmp);
   end creer_fichier_dossier;


   procedure liste_contenu(sgf : in out T_sgf; path : in T_PATH; dir_fils : Boolean)  is

      procedure print_enf (n : in Unbounded_String) is
      Begin
         Put_Line(n);
      end print_enf;

      procedure afficher_enfants is new liste_cmd.afficher_liste(print_enf);

   Begin
      -- change_dir(path);
      if dir_fils then
         affiche(sgf.noeud_courant);
      else
         -- afficher_enfants(noeud_courant);
         null;
      end if;
      -- noeud_courant := tmp_noeud_cour;
      New_Line;
   end liste_contenu;


   procedure supp_fichier_dossier(sgf : in out T_sgf; path : in T_PATH) is
      tmp : T_info;
      tmp_noeud : T_Arbre;
   Begin
      tmp.name := liste_cmd.get_contenu(path.chemin);
      -- put(tmp.name);
      set_arbre(cherche(sgf.root, tmp), tmp_noeud);
         rm(sgf.root, get_contenu(tmp_noeud));
   end supp_fichier_dossier;


   procedure archive_dir (sgf : in out T_sgf; path : in T_PATH) is
      data, tmp : T_info;
      nom : Unbounded_String;
      tmp_noeud : T_arbre := sgf.noeud_courant;
   Begin
      tmp.name := liste_cmd.get_contenu(path.chemin);
      set_arbre(get_parent(cherche(sgf.root, tmp)), tmp_noeud);
      if get_contenu(tmp_noeud).isFile then
         raise chemin_invalide;
      else
         nom := get_contenu(tmp_noeud).name;
         append(nom, To_Unbounded_String(".zip"));
         data.name := nom;
         data.isFile := True;
         data.taille := 0;
         modifier(tmp_noeud, data);
         supp_enfants(tmp_noeud);
      end if;
   end archive_dir;


   procedure test (sgf : in out T_sgf) is
      path : T_path;
      tmp : T_arbre;
      -- data : T_info;
   Begin
      formatage_disque(sgf);
      -- affiche(arbre);
      -- affiche(noeud_courant);
      -- repo_courant;
      path := traiter(To_Unbounded_String("/\/home/"));
      -- put(liste_cmd.get_contenu(liste_cmd.get_last(path.chemin)));
      creer_fichier_dossier(sgf, path, false, False);
      path := traiter(To_Unbounded_String("/\/home/kaycee/"));
      creer_fichier_dossier(sgf, path, false, false);
      path := traiter(To_Unbounded_String("/\/home/kaycee/projet"));
      creer_fichier_dossier(sgf, path, false, false);
      -- affiche(arbre);
      -- repo_courant;
      -- change_dir(path);

      path := traiter(To_Unbounded_String("/\/home/kaycee/projet/sgf.gpr"));
      creer_fichier_dossier(sgf, path, true, false);

      path := traiter(To_Unbounded_String("/\/home/kaycee/projet/sgf.gpr"));
      liste_contenu(sgf, path, true);

      path := traiter(To_Unbounded_String("/\/home/kaycee/projet/sgf.gpr"));
      creer_fichier_dossier(sgf, path, false, false);
      archive_dir(sgf, path);
      -- supp_fichier_dossier(sgf, path);
      liste_contenu(sgf, path, true);
      -- change_dir(path);
      -- data.name := To_Unbounded_String("sgf.gpr");
      -- tmp := cherche(arbre, data);
      -- put(get_contenu(tmp).contenu);
      --creer_fichier_dossier(path, true, true);
      -- put(get_contenu(noeud).name);
      -- put_line(repo_courant);
      -- path := traiter(To_Unbounded_String("/\/test/projet"));
      -- creer_fichier_dossier(path, false, False);
      -- change_dir(path);
      -- put_line(repo_courant);
      -- affiche(arbre);
   end test;

end sgf;
