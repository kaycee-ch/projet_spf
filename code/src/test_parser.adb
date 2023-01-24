with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Text_IO.Unbounded_IO; use Text_IO.Unbounded_IO;
with parser; use parser;
with Ada.Text_IO;

procedure test_parser is
   phrase : Unbounded_String;
   cmd : T_command;
   path : T_path;


Begin
   --test_cmd;
   phrase := (To_Unbounded_String("/home/kaycee/n7/prog"));
   path := traiter(phrase);
end test_parser;
