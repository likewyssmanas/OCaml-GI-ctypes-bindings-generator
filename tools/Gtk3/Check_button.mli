open Ctypes

type t
val t_typ : t typ

val create :
  unit -> Widget.t ptr
val create_with_label :
  string -> Widget.t ptr
val create_with_mnemonic :
  string -> Widget.t ptr
