with file_gen;

generic
   TYPE T_contenu is private;

   with function is_equals(x : in T_contenu; y : in T_contenu) return Boolean;

package p_arbre is

   arbre_vide, data_absente : EXCEPTION;

   TYPE T_arbre is private;


   procedure init (ab : out T_arbre);
   -- semantique : cette procedure initialise ab à null, c'est le futur pointeur sur la racine
   -- pre : /
   -- post : {ab = null}
   -- exception : /


   procedure creer_racine(ab : in out T_arbre; data : in T_contenu);
   -- semantique : cette procedure crée le noeud racine et initialise son contenu à data
   -- pre : /
   -- post : {ab /= null}, {ab.all.f_info = data}
   -- exception : /


   procedure ajouter_enfants(ab : in out T_arbre; data : in T_contenu);
   -- semantique : cette procedure ajoute un noeud "enfants" à ab avec data pour contenu
   -- pre : /
   -- post : /
   -- exception : arbre_vide si ab = null


   function cherche_enfant(ab : in T_arbre; data : in T_contenu) return T_arbre;
   -- semantique : cette fonction parcourt les enfants directs de ab et compare leur contenu avec data,
   --              s'il y a correspondance on renvoie l'addresse de l'enfant qui a data pour contenu
   --              si on a parcouru tous les enfants sans trouver data, on renvoie null;
   -- pre : /
   -- post : cherche_enfant(ab, data).all.f_info = data ou cherche_enfant(ab, data) = null
   -- exception : arbre_vide si ab = null


   function find(ab : in T_arbre; data : in T_contenu) return T_arbre;
   -- semantique : cette fonction parcourt en récursif tous les noeuds en dessous de ab et compare leur contenu avec data,
   --              s'il y a correspondance on renvoie l'address du noeud qui a data pour contenu
   --              si on a parcouru tous les noeuds sans trouver data, on renvoie null
   -- pre : /
   -- post : find(ab, data).all.f_info = data ou find(ab, data) = null
   -- exception : arbre_vide si ab = null


   procedure remove (ab : in out T_arbre; data : in T_contenu);
   -- semantique : cette procédure cherche le noeud dont le contenu correspond à data, supprime le pointeur et enlève le noeud en question de la liste de senfants de son parent
   -- pre : /
   -- post : find(ab, data) = null
   -- exception : data_absente si find(ab, data) = null;


   function get_root(ab : in T_arbre) return T_arbre;
   -- semantique : cette fonction récursive retourne le pointeur sur la racine de l'arbre quelque soit son noeud passé en paramètre
   -- pre : /
   -- post : {get_root(ab).all.parent = null}
   -- exception : arbre_vide si ab = null


   function get_contenu (ab : in T_arbre) return T_contenu;
   -- semantique : cette fonction de type 'getter' renvoie le contenu du noeud passé en paramètre et sera utile lors de l'exportation de son module puisque l'arbre est en private
   -- pre : /
   -- post : {get_contenu(ab).all.f_info = ab.all.f_info}
   -- exception : arbre_vide si ab = null;


   procedure set_arbre(ab : in T_arbre; ab2 : out T_arbre);
   -- semantique : cette procédure de type 'setter' prend deux arbres en paramètres et affecte le premier au deuxième
   -- pre : /
   -- post : {(ab2 = ab) = True}
   -- exception : /


   function ab_est_vide (ab : in T_arbre) return Boolean;
   -- semantique : cette function renvoie vrai si l'arbre est vide, faux sinon
   -- pre : /
   -- post : {(ab_est_vide(ab) = (ab = null)) = true}
   -- exception : /


   function profondeur(ab : in T_arbre) return Integer;
   -- semantique : cette fonction renvoie la 'profondeur' ou 'l'étage' du noeud passé en paramètre, autrement dit, elle compte le nombre de noeud entre ab et la racine de l'arbre
   -- pre : {ab /= null}
   -- post : /
   -- exception : /


   function get_parent (ab : in T_arbre) return T_arbre;
   -- semantique : cette fonction de type 'getter' renvoie le parent du noeud passé en paramètre et sera utile lors de l'exportation de son module puisque l'arbre est en private
   --              si le noeud passé en paramètre est la racine, on renvoie null
   -- pre : /
   -- post : {(get_parent(ab).all.parent = ab.all.parent) = True}
   -- exception : arbre_vide si ab = null


   procedure modifier (ab : in out T_arbre; new_data : in T_contenu);
   -- semantique : cette procédure modifie le contenu de ab et le rempplace par data
   -- pre : /
   -- post : {(ab.all.f_info = new_data) = true}
   -- exception : arbre_vide si ab = null


   procedure supp_enfants (ab : in out T_arbre);
   -- semantique : cette procédure supprime tous les enfants de ab
   -- pre : /
   -- post : {(ab.all.enfant = null) = true }
   -- exception : arbre_vide si ab = null


   generic
      with procedure afficher_noeud(n : in T_contenu; indent : in Integer);
   procedure print_every(Ab : in T_arbre);
   -- semantique : cette fonction affiche tous les noeuds en dessous de ab en faisant un parcours préfixe
   -- pre : /
   -- post : /
   -- exception : arbre_vide si ab = null

   generic
      with procedure afficher_noeud(n : in T_contenu; indent : in Integer);
   procedure print_just(ab : in T_arbre);

private
   TYPE T_noeud;
   TYPE T_arbre is access T_noeud;

   package file is new file_gen(T_element => T_arbre);
   use file;

   TYPE T_cellule;
   TYPE T_liste is access T_cellule;
   TYPE T_cellule is record
      valeur : T_arbre;
      suivant : T_liste;
   end record;

   TYPE T_noeud is record
      f_info : T_contenu;
      parent : T_arbre;
      enfants : file.liste_elem.T_liste;
   end record;

end p_arbre;
