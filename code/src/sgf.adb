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


   procedure print_enf_tree(data : in T_info; indent : in Integer) is
      m : Integer := length(data.name);
      tmp : String(1..m);
   Begin
      if indent = 0 then
         null;
      elsif indent = 1 then
         Put("\- ");
      else
         Put("|  ");
         for i in 1..indent loop
            Put("   ");
         end loop;
         if data.isFile then
            Put("|- ");
         else
            Put("\- ");
         end if;
      end if;
      tmp:= to_string(data.name);
      Put(data.name);
      new_line;
   end print_enf_tree;




   procedure print_all(data : in T_info; indent : in INteger) is
      m : Integer := length(data.name);
      tmp : String(1..m);
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



   procedure print_simpl (data : in T_info; indent : in INteger) is
   Begin
      Put(data.name);
      Put("     ");
   end print_simpl;



   procedure formatage_disque(sgf : in out T_sgf) is
      data : T_info;
   Begin
      init(sgf.root);
      sgf.taille := 0;
      data.name := To_Unbounded_String("\");
      data.isFile := False;
      data.taille := 10;
      data.droits := 750;
      creer_racine(sgf.root, data);
      set_arbre(sgf.root, sgf.noeud_courant);
   end formatage_disque;







   function repo_courant(sgf : in out T_sgf) return T_PATH IS
      tmp : T_arbre := sgf.noeud_courant;
      p : pile;
      pwd : Unbounded_String;
      pwd_path : T_path;
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
      pwd_path := traiter_path(pwd);
      return pwd_path;
   end repo_courant;




   function stockage_occupe(sgf : in out T_SGF) return Integer is
   Begin
      return sgf.taille;
   end stockage_occupe;




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
         elsif first = get_contenu(sgf.root).name or else first = "" then
            set_arbre(sgf.root, sgf.noeud_courant);
         elsif not ab_est_vide(tmp_ab) then
            if not get_contenu(tmp_ab).isFile then
               set_arbre(tmp_ab, sgf.noeud_courant);
            else
               chemin_incorrect := true;
            end if;
         else
            chemin_incorrect := true;
         end if;
         liste_cmd.enlever(tmp_path.chemin, first);
      end loop;

      if chemin_incorrect then
         raise chemin_invalide;
      end if;
   end change_dir;








   procedure creer_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; estFichier : in Boolean; existe : in Boolean) is
      data : T_info;
      old_path : T_path := repo_courant(sgf);
      tmp_path : T_PATH := path;
      tmp : T_info;
   Begin
      -- je récuppère l'avant dernier mot du path => c'est le nom du dossier ou je dois créer mon fichier/dossier
      tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      liste_cmd.enlever(tmp_path.chemin, tmp.name);
      -- put(tmp.name);
      -- je cherche le noeud de l'arbre correspondant au nom et j'y pointe le noeud_courant local à la procédure
      change_dir(sgf, tmp_path);
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
         data.taille := length(data.contenu) * 100;
         data.droits := 666;
      else
         data.taille := 10000;
         data.droits := 777;
      end if;
      if (sgf.taille + data.taille) >= 10**9 then
         raise stockage_plein;
      end if;
      if existe then
         modifier(sgf.noeud_courant, data);
      else
         ajouter_enfants(sgf.noeud_courant, data);
      end if;
      change_dir(sgf, old_path);
      sgf.taille := sgf.taille + data.taille;
   end creer_fichier_dossier;







   procedure liste_contenu(sgf : in out T_sgf; path : in T_PATH; dir_fils : in Boolean; all_info : in Boolean)  is

      tmp_name : Unbounded_String;
      tmp_noeud : T_arbre := SGF.noeud_courant;

   Begin
      change_dir(sgf, path);
      if dir_fils then
         if all_info then -- ls -l -A
            affiche_all(sgf.noeud_courant);
         else -- ls -A
            affiche_enf_tree(sgf.noeud_courant);
         end if;
      else
         if all_info then  --ls -l
            affiche_enf_det(sgf.noeud_courant);
         else -- ls
            affiche_simpl(sgf.noeud_courant);
         end if;
      end if;
      sgf.noeud_courant := tmp_noeud;
      New_Line;
   end liste_contenu;



   procedure change_droits(sgf : in out T_sgf; path : in T_path; n : in Integer) is
      tmp : T_path;
      data : T_info;
   Begin
      tmp := repo_courant(sgf);
      change_dir(sgf, path);
      data := get_contenu(sgf.noeud_courant);
      data.droits := n;
      modifier(sgf.noeud_courant, data);
      change_dir(sgf, tmp);
   end change_droits;



   procedure change_name (sgf : in out T_SGF; path : in T_PATH; name : in Unbounded_String) is
      tmp : T_path;
      data : T_info;
   Begin
      tmp := repo_courant(sgf);
      change_dir(sgf, path);
      data := get_contenu(sgf.noeud_courant);
      data.name := name;
      modifier(sgf.noeud_courant, data);
      change_dir(sgf, tmp);
   end change_name;



   procedure supp_fichier_dossier(sgf : in out T_sgf; path : in T_PATH; isFile : in Boolean) is
      tmp : T_info;
      tmp_noeud : T_Arbre;
   Begin
      if not isFile then
         tmp.name := liste_cmd.get_contenu(liste_cmd.get_next(path.chemin_inv));
      else
         tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      end if;
      set_arbre(find(sgf.noeud_courant, tmp), tmp_noeud);
      remove(sgf.root, get_contenu(tmp_noeud));
      sgf.taille := sgf.taille - get_contenu(tmp_noeud).taille;
   end supp_fichier_dossier;




   procedure affiche_fichier(sgf : in out T_sgf; path : in T_path) is
      tmp : T_info;
      ab_tmp : T_arbre;
      cannot_print : EXCEPTION;
   Begin
      tmp.name := liste_cmd.get_contenu(path.chemin_inv);
      set_arbre(find(sgf.root, tmp), ab_tmp);
      if not ab_est_vide(ab_tmp) then
         if get_contenu(ab_tmp).isFile then
            Put_Line(get_contenu(ab_tmp).contenu);
         else
            raise chemin_invalide;
         end if;
      else
         raise cannot_print;
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
   end archive_dir;




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
      -- path := traiter_path(To_Unbounded_String("/../kaycee"));
      supp_fichier_dossier(sgf, path, true);
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
