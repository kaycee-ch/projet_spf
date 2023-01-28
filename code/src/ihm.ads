with ada.strings.Unbounded; use ada.strings.Unbounded;
with parser; use parser;
with sgf; use sgf;

package IHM is

   commande_inconnu : EXCEPTION;

   procedure traiter_cmd(le_sgf : in out T_sgf; cmd : in T_COMMAND);

   procedure help(commande : in Unbounded_String);

   procedure traiter_choix (le_sgf : in out T_sgf; choix : in Character);

   procedure traiter_ls (le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_command; path : in out T_path);

   procedure traiter_pwd (le_sgf : in out T_sgf; cmd : in T_command; path : in out T_path);

   procedure traiter_nano (le_sgf : in out T_sgf; menu : in Boolean; existe : in Boolean; cmd : in T_command; path : in out T_path);

   procedure traiter_mkdir(le_sgf : in out T_sgf; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);

   procedure traiter_cd(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);

   procedure traiter_tar(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);

   procedure traiter_cat(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);

   procedure traiter_rm(le_sgf : in out T_SGF; menu : in Boolean; cmd : in T_COMMAND; path : in out T_path);


end IHM;
