with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with ada.strings.Unbounded; use ada.strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with parser; use parser;
with p_arbre;
with p_liste_gen;

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
      Put(data.name);
      new_line;
   end print_str;


   procedure print_all(data : in T_info; indent : In Integer) is
      m : Integer := length(data.name);
      tmp : String(1..m);
      -- str : String(1..3);
   Begin
      Put("Type : ");
      if data.isFile then
         Put_line("File");
      else
         Put_line("Folder");
      end if;
      tmp:= to_string(data.name);
      Put("Name : ");
      Put_Line(tmp);
      Put("Size : ");
      Put_Line(Integer'Image(data.taille));
      Put("Rights : ");
      Put_line(Integer'Image(data.droits));
      new_line;
   end print_all;


   procedure formatage_disque(sgf : in out T_sgf) is
      data : T_info;
   Begin
      init(sgf.root);
      data.name := To_Unbounded_String("\");
      data.isFile := False;
      creer_racine(sgf.root, data);
      set_arbre(sgf.root, sgf.noeud_courant);
   end formatage_disque;


   function repo_courant(sgf : in out T_sgf) return Unbounded_String IS
      tmp : T_arbre := sgf.noeud_courant;
      p : pile;
      pwd : Unbounded_String;
   Begin
      creer_pile_vide(p);
      while not ab_est_vide(tmp) loop
         empiler(p, get_contenu(tmp).name);
         tmp := get_parent(tmp);
      end loop;
      while not est_vide(p) loop
         append(pwd, "/");
         append(pwd, depiler(p));
      end loop;
      put(pwd);
      new_line;
      return pwd;
   end repo_courant;



   procedure change_dir(sgf : in out T_sgf; destination : in T_PATH) is
      tmp_path : T_path := destination;
      first : Unbounded_String;
      tmp_ab : T_arbre;
      tmp_data : T_info;
      chemin_incorrect, isLast : Boolean := false;
      chemin_invalide : EXCEPTION;
   Begin

      while not chemin_incorrect and not liste_cmd.est_vide(liste_cmd.get_next(tmp_path.chemin)) loop
         first := liste_cmd.get_contenu(liste_cmd.get_next(tmp_path.chemin));
         -- put_line(first);
         tmp_data.name := first;
         tmp_ab := cherche_enfant(sgf.noeud_courant, tmp_data);
         if first = "." then
            set_arbre(sgf.noeud_courant, sgf.noeud_courant);
         elsif first = ".." then
            if not ab_est_vide(get_parent(sgf.noeud_courant)) then
               set_arbre(get_parent(sgf.noeud_courant), sgf.noeud_courant);
            else
               set_arbre(sgf.noeud_courant, sgf.noeud_courant);
            end if;
         elsif first = get_contenu(sgf.root).name then
            set_arbre(sgf.root, sgf.noeud_courant);
         elsif not ab_est_vide(tmp_ab) and then not get_contenu(tmp_ab).isFile then
            set_arbre(tmp_ab, sgf.noeud_courant);
         else
            chemin_incorrect := true;
         end if;
         liste_cmd.enlever(tmp_path.chemin, first);
      end loop;
      if chemin_incorrect then
         raise chemin_invalide;
      end if;
      Put_Line("Directory has been changed");
   end change_dir;



   procedure creer_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; estFichier : in Boolean; existe : in Boolean) is
      data : T_info;
      tmp : T_info;
      ab_tmp : T_arbre;
   Begin
      -- je récuppère l'avant dernier mot du path => c'est le nom du dossier ou je dois créer mon fichier/dossier
      tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin_inv));
      -- put(tmp.name);
      -- je cherche le noeud de l'arbre correspondant au nom et j'y pointe le noeud_courant local à la procédure
      set_arbre(find(sgf.root, tmp), ab_tmp);
      -- affiche(ab_tmp);
      -- je récupère le dernier mot du path => c'est le nom du fichier/dossier que je crée
      data.name := liste_cmd.get_contenu(path.chemin_inv);
      -- put(data.name);
      data.isFile := estFichier;
      -- si le c'est un fichier et qu'il existe deja j'affiche le contenu
      if existe and then estFichier then
         Put_Line(data.contenu);
      end if;
      if estFichier then
         Text_IO.Put_Line("Saisissez le contenu du fichier");
         Get_line(data.contenu); text_io.Skip_Line;
         data.taille := length(data.contenu);
         data.droits := 666;
      else
         data.taille := 10;
         data.droits := 777;
      end if;
      if existe then
         -- modifier_noeud(noeud_courant, data);
         null;
      else
         ajouter_enfants(ab_tmp, data);
      end if;
      if estFichier then
         Put_Line("File created");
      else
         Put_Line("Folder created");
      end if;
   end creer_fichier_dossier;


   procedure liste_contenu(sgf : in out T_sgf; path : in T_PATH; dir_fils : in Boolean; all_info : in Boolean)  is

      procedure print_enf_all(l_enf : in liste_enf.T_liste) is
         tmp_data : T_info;
      Begin
         tmp_data := get_contenu(liste_enf.get_contenu(l_enf));
         Put("Type : ");
         if tmp_data.isFile then
            Put_line("File");
            Put("Size : ");
            Put_Line(Integer'Image(tmp_data.taille));
         else
            Put_line("Folder");
         end if;
         Put("Name : ");
         Put(tmp_data.name);
         New_Line;
         Put("Rights : ");
         Put_line(Integer'Image(tmp_data.droits));
         new_line;
      end print_enf_all;

      procedure print_enf_simpl (l_enf : in liste_enf.T_liste) is
         indent : Integer;
         tmp : UNbounded_String;
         str : String(1..3);
      Begin
         tmp := get_contenu(liste_enf.get_contenu(l_enf)).name;
         indent := profondeur(sgf.noeud_courant);
         if indent = 0 then
            null;
         elsif indent = 1 then
            Put("\- ");
         else
            Put("|    ");
            str := "\- ";
            Put(str, indent*indent);
         end if;
         Put(tmp);
         new_line;
      end print_enf_simpl;

      -- procedure afficher_enfants_simpl is new liste_enf.afficher_liste(print_enf_simpl);
      -- procedure afficher_enfants_all is new liste_enf.afficher_liste(print_enf_all);

      tmp_name : Unbounded_String;

   Begin
      -- change_dir(path);
      if dir_fils then
         if all_info then
            affiche_detail(sgf.noeud_courant);
         else
            affiche_simple(sgf.noeud_courant);
         end if;
      else
         if all_info then
            -- afficher_enfants_all(sgf.noeud_courant);
            null;
         else
            null;
         end if;
      end if;
      -- noeud_courant := tmp_noeud_cour;
      New_Line;
   end liste_contenu;


   procedure supp_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; isFile : in Boolean) is
      tmp : T_info;
      tmp_noeud : T_Arbre;
   Begin
      if isFile then
         tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin_inv));
      else
         tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      end if;
      set_arbre(find(sgf.noeud_courant, tmp), tmp_noeud);
      remove(sgf.root, get_contenu(tmp_noeud));
      Put_Line("Deleted");
   end supp_fichier_dossier;



   procedure affiche_fichier(sgf : in out T_sgf; path : in T_path) is
      tmp : T_info;
      ab_tmp : T_arbre;
   Begin
      tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      -- put(tmp.name);
      set_arbre(find(sgf.root, tmp), ab_tmp);
      if get_contenu(ab_tmp).isFile then
         Put_Line(get_contenu(ab_tmp).contenu);
      else
         raise chemin_invalide;
      end if;
   end affiche_fichier;

   procedure archive_dir (sgf : in out T_sgf; path : in T_PATH) is
      data, tmp : T_info;
      nom : Unbounded_String;
      tmp_noeud : T_arbre := sgf.noeud_courant;
   Begin
      tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      set_arbre(find(sgf.root, tmp), tmp_noeud);
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
      Put_Line("Folder compressed");
   end archive_dir;


   procedure copy_move(sgf : in out T_sgf; old_path : in T_PATH; new_path : in T_PATH; isFile : in Boolean; copy : in Boolean)  is
      tmp_ab : T_arbre;
   Begin
      if isFile then
         null;
      else
         -- forcement copier car on ne deplace pas un dossier
         set_arbre(sgf.root, tmp_ab);
      end if;
   end copy_move;


   procedure test (sgf : in out T_sgf) is
      path : T_path;
      path_str : Unbounded_String;
      tmp : T_arbre;
      -- data : T_info;
   Begin
      formatage_disque(sgf);
      -- affiche(arbre);
      -- affiche(noeud_courant);
      -- repo_courant(sgf);
      path := traiter_path(To_Unbounded_String("/\/home/"));
      -- put(liste_cmd.get_contenu(liste_cmd.get_last(path.chemin)));
      creer_fichier_dossier(sgf, path, false, False);
      path := traiter_path(To_Unbounded_String("/\/home/kaycee/"));
      creer_fichier_dossier(sgf, path, false, false);
      change_dir(sgf, path);
      -- path_str := repo_courant(sgf);

      path := traiter_path(To_Unbounded_String("/\/home/kaycee/test.txt"));
      creer_fichier_dossier(sgf, path, true, false);
      affiche_fichier(sgf, path);
      path := traiter_path(to_unbounded_string("/\/"));
      liste_contenu(sgf, path, true, true);
      -- path := traiter_path(To_Unbounded_String("/../kaycee"));
      -- supp_fichier_dossier(sgf, path, false);
      -- path := traiter_path(To_Unbounded_String("/\/home/"));
      -- archive_dir(sgf, path);
      -- change_dir(sgf, path);
      -- path_str := repo_courant(sgf);
      -- path := traiter_path(to_unbounded_string("./projet"));
      -- change_dir(sgf, path);
      --  path := traiter_path(repo_courant(sgf));
      --  change_dir(sgf, path);
      --  path_str := repo_courant(sgf);
      --  liste_contenu(sgf, path, true, true);
      -- change_dir(sgf, path);
      -- affiche(arbre);
      -- change_dir(sgf, path);
      -- repo_courant(sgf);

      -- path := traiter_path(To_Unbounded_String("/\/home/kaycee/projet/sgf.gpr"));
      -- creer_fichier_dossier(sgf, path, true, false);

      -- path := traiter(To_Unbounded_String("/\/home/kaycee/projet/sgf.gpr"));
      -- affiche(sgf.root);
      -- affiche_fichier(sgf, path);
      -- path := traiter_path(To_Unbounded_String("/\"));
      -- liste_contenu(sgf, path, true, false);
      path := traiter_path(To_Unbounded_String("/\/home/kaycee/projet/"));
      -- creer_fichier_dossier(sgf, path, false, false);
      -- archive_dir(sgf, path);
      -- supp_fichier_dossier(sgf, path);
      -- liste_contenu(sgf, path, true, false);
      -- change_dir(sgf, path);
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
      -- affiche(sgf.root);
   end test;

end sgf;
