with ada.strings.Unbounded; use ada.strings.Unbounded;
with parser; use parser;
with sgf; use sgf;

package IHM is

   procedure traiter_cmd(le_sgf : in out T_sgf; cmd : in T_COMMAND);

   procedure help(commande : in Unbounded_String);

   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character);

end IHM;
