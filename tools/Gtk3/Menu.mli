open Ctypes

type t
val t_typ : t typ

val create :
  unit -> Widget.t ptr
val create_from_model :
  Menu_model.t ptr -> Widget.t ptr
val get_for_attach_widget :
  Widget.t ptr -> List.t structure (* Not implemented : interface *) ptr
val attach :
  t -> Widget.t ptr -> Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.uint32 -> Unsigned.uint32 -> unit
(*Not implemented gtk_menu_attach_to_widget type callback not implemented*)
val detach :
  t -> unit
val get_accel_group :
  t -> Accel_group.t ptr
val get_accel_path :
  t -> string option
val get_active :
  t -> Widget.t ptr
val get_attach_widget :
  t -> Widget.t ptr
val get_monitor :
  t -> int32
val get_reserve_toggle_size :
  t -> bool
val get_tearoff_state :
  t -> bool
val get_title :
  t -> string option
val place_on_monitor :
  t -> Monitor.t ptr -> unit
val popdown :
  t -> unit
(*Not implemented gtk_menu_popup type callback not implemented*)
(*Not implemented gtk_menu_popup_at_pointer type union not implemented*)
(*Not implemented gtk_menu_popup_at_rect type union not implemented*)
(*Not implemented gtk_menu_popup_at_widget type union not implemented*)
(*Not implemented gtk_menu_popup_for_device type callback not implemented*)
val reorder_child :
  t -> Widget.t ptr -> int32 -> unit
val reposition :
  t -> unit
val set_accel_group :
  t -> Accel_group.t ptr option -> unit
val set_accel_path :
  t -> string option -> unit
val set_active :
  t -> Unsigned.uint32 -> unit
val set_monitor :
  t -> int32 -> unit
val set_reserve_toggle_size :
  t -> bool -> unit
val set_screen :
  t -> Screen.t ptr option -> unit
val set_tearoff_state :
  t -> bool -> unit
val set_title :
  t -> string -> unit
