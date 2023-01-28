with Ada.Text_IO; use Ada.Text_IO;
with Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ihm; use ihm;
with sgf; use sgf;
with parser; use parser;

package body CLI is

   function affichage_deb return Boolean is
      choix_affichage : Character;
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
      return menu;
   end affichage_deb;


   procedure afficher_menu (choix : out Character) is
   Begin
      Put_Line("Que souhaitez-vous faire ?");
      Put_Line("z) Create a new file system");
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
      Put_line("l) Exit this SGF");
      Get(choix); Skip_Line;
   end afficher_menu;


   procedure menu(le_sgf : in out T_sgf; choix : in Character) is
   Begin
      traiter_choix(le_sgf, choix);
   end menu;


   procedure saisie_libre(le_sgf : in out T_sgf) is
      cmd : T_command;
      cmd_str : Unbounded_String;
   Begin
      loop
         unbounded_io.Get_line(cmd_str);
         Skip_line;
         cmd := traiter_cmd(cmd_str);
         traiter_cmd(le_sgf, cmd);
      end loop;
   end saisie_libre;


end CLI;
