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
      Put_Line("a) Create a new file system");
      Put_Line("b) Find the current directory");
      Put_Line("c) Create a new file");
      Put_Line("d) Show filecontent");
      Put_Line("e) Modify an existing file");
      Put_Line("f) Create a folder");
      Put_Line("g) Go to a different directory");
      Put_Line("h) List files & folders");
      Put_Line("i) Remove a file");
      Put_Line("j) Remove a folder");
      Put_Line("k) Archive a folder");
      Put_line("l) Change a folder's name");
      Put_line("m) Change a folder's rights");
      Put_line("n) Find the current disk's storage occupancy");
      Put_Line("o) Copy a file from this repository to another");
      Put_Line("p) Move a file from this repository to another");
      Put_line("q) Exit this SGF (non reversible!)");
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
         unbounded_io.Get_Line(cmd_str);
         cmd := parser.traiter_cmd(cmd_str);
         ihm.traiter_cmd(le_sgf, cmd);
      end loop;
   end saisie_libre;


end CLI;
