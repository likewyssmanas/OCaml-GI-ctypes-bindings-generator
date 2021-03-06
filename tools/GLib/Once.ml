open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "Once"

let f_status = field t_typ "status" (Once_status.t_view)
let f_retval = field t_typ "retval" (ptr void)
let _ = seal t_typ

let init_enter =
  foreign "g_once_init_enter" (ptr void @-> returning (bool))
let init_leave =
  foreign "g_once_init_leave" (ptr void @-> uint64_t @-> returning (void))
