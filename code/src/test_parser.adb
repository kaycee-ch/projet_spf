with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with parser; use parser;
with Ada.Text_IO;

procedure test_parser is
   phrase : Unbounded_String;
   cmd : T_command;
   path : T_PATH;


Begin
   Get_Line(phrase);
   --  cmd := parse_cmd(phrase);
   --  print(cmd.options);
   --  print(cmd.arguments);
   path := parse_path(phrase);
   print(path.chemin);
   end test_parser;
