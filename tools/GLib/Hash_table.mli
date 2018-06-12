open Ctypes

type t
val t_typ : t structure typ

val add :
  t structure ptr -> unit ptr option -> bool
val contains :
  t structure ptr -> unit ptr option -> bool
val destroy :
  t structure ptr -> unit
val insert :
  t structure ptr -> unit ptr option -> unit ptr option -> bool
val lookup :
  t structure ptr -> unit ptr option -> unit ptr option
val lookup_extended :
  t structure ptr -> unit ptr option -> (bool * unit ptr option * unit ptr option)
val remove :
  t structure ptr -> unit ptr option -> bool
val remove_all :
  t structure ptr -> unit
val replace :
  t structure ptr -> unit ptr option -> unit ptr option -> bool
val size :
  t structure ptr -> Unsigned.uint32
val steal :
  t structure ptr -> unit ptr option -> bool
val steal_all :
  t structure ptr -> unit
val unref :
  t structure ptr -> unit