open Ctypes
open Foreign

type t = unit ptr
let t_typ : t typ = ptr void

let create =
  foreign "gtk_renderer_cell_accessible_new" (ptr Cell_renderer.t_typ @-> returning (ptr Object.t_typ))
