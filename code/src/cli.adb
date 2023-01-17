with Ada.Text_IO; use Ada.Text_IO;
with Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- with ihm; use ihm;

package body CLI is

   function afficher_menu return Character is

      choix_affichage, choix_action : Character;
      menu : Boolean;
   Begin
      Put_Line("Affichage (m)enu ou Saisie (l)ibre");
      Get(choix_affichage);
      Skip_Line;
      case choix_affichage is
         when 'm' => menu := True;
         when 'l' => menu := False;
         when others => Put_Line("Saisie incorrect");
      end case;
      if menu then
         Put_Line("Que souhaitez-vous faire ?");
         Put_Line("a) Find the current directory");
         Put_Line("b) Create a new file");
         Put_Line("c) Modify an existing file");
         Put_Line("d) Create a folder");
         Put_Line("e) Go to a different directory");
         Put_Line("f) List everything in the current directory");
         Put_Line("g) Remove a file");
         Put_Line("h) Remove a folder");
         Put_Line("i) Move a file");
         Put_Line("j) Copy a file");
         Put_Line("k) Archive a folder");
      end if;

      Get(choix_action);
      return choix_action;

   end afficher_menu;


   procedure traiter_choix (choix : in Character) is
      f : Character;
      b, d, e, g, i, j, k : Unbounded_String;
      long_b : Integer;
   Begin
      case choix is
         when 'a' =>Put_Line("/...");
            -- get_repo_courant();
         when 'b' =>
            Put_Line("What is the filename ?");
            Unbounded_IO.Get_Line(b); Skip_line;
            long_b := Length(b);
            -- create_file(b);
         when 'c' =>
            null;
            -- modify_file;
         when 'd' =>
            Put_Line("What is the folder name ?");
            Unbounded_IO.Get_Line(d); Skip_line;
            long_b := Length(d);
            -- create_folder(b);
         when 'e' =>
            Put_Line("What is the destination path ?");
            Unbounded_IO.Get_Line(e); Skip_line;
            long_b := Length(e);
            -- go_to_dir();
         when 'f' =>
            Put_Line("List everything the children directory ? Y/N");
            --  Ada.Text_IO.Get_Line(f); Skip_line;
            --  case f is
            --     when 'Y' =>
            --        null;
            --        -- list_cd();
            --     when 'N' =>
            --        null;
            --        -- list_cd_all();
            --  end case;
         when 'g' =>
            Put_Line("What is the filename ?");
            Unbounded_IO.Get_Line(g); Skip_line;
            long_b := Length(g);
            -- rm_file();
         when 'i' =>
            Put_Line("What is the folder name ?");
            Unbounded_IO.Get_Line(i); Skip_line;
            long_b := Length(i);
            -- rm_folder();
         when 'j' =>
            Put_Line("What is the filename ?");
            Unbounded_IO.Get_Line(j); Skip_line;
            long_b := Length(j);
         when 'k' =>
            Put_Line("What is the folder name");
            Unbounded_IO.Get_Line(k); Skip_line;
            long_b := Length(k);
         when others =>
            Put_Line("Commande Inconnue");
      end case;
   end traiter_choix;

end CLI;
