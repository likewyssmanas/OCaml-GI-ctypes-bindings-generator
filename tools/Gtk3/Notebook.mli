open Ctypes

type t
val t_typ : t typ

val create :
  unit -> Widget.t ptr
val append_page :
  t -> Widget.t ptr -> Widget.t ptr option -> int32
val append_page_menu :
  t -> Widget.t ptr -> Widget.t ptr option -> Widget.t ptr option -> int32
val detach_tab :
  t -> Widget.t ptr -> unit
val get_action_widget :
  t -> Pack_type.t -> Widget.t ptr option
val get_current_page :
  t -> int32
val get_group_name :
  t -> string option
val get_menu_label :
  t -> Widget.t ptr -> Widget.t ptr option
val get_menu_label_text :
  t -> Widget.t ptr -> string option
val get_n_pages :
  t -> int32
val get_nth_page :
  t -> int32 -> Widget.t ptr option
val get_scrollable :
  t -> bool
val get_show_border :
  t -> bool
val get_show_tabs :
  t -> bool
val get_tab_detachable :
  t -> Widget.t ptr -> bool
val get_tab_hborder :
  t -> Unsigned.uint16
val get_tab_label :
  t -> Widget.t ptr -> Widget.t ptr option
val get_tab_label_text :
  t -> Widget.t ptr -> string option
val get_tab_pos :
  t -> Position_type.t
val get_tab_reorderable :
  t -> Widget.t ptr -> bool
val get_tab_vborder :
  t -> Unsigned.uint16
val insert_page :
  t -> Widget.t ptr -> Widget.t ptr option -> int32 -> int32
val insert_page_menu :
  t -> Widget.t ptr -> Widget.t ptr option -> Widget.t ptr option -> int32 -> int32
val next_page :
  t -> unit
val page_num :
  t -> Widget.t ptr -> int32
val popup_disable :
  t -> unit
val popup_enable :
  t -> unit
val prepend_page :
  t -> Widget.t ptr -> Widget.t ptr option -> int32
val prepend_page_menu :
  t -> Widget.t ptr -> Widget.t ptr option -> Widget.t ptr option -> int32
val prev_page :
  t -> unit
val remove_page :
  t -> int32 -> unit
val reorder_child :
  t -> Widget.t ptr -> int32 -> unit
val set_action_widget :
  t -> Widget.t ptr -> Pack_type.t -> unit
val set_current_page :
  t -> int32 -> unit
val set_group_name :
  t -> string option -> unit
val set_menu_label :
  t -> Widget.t ptr -> Widget.t ptr option -> unit
val set_menu_label_text :
  t -> Widget.t ptr -> string -> unit
val set_scrollable :
  t -> bool -> unit
val set_show_border :
  t -> bool -> unit
val set_show_tabs :
  t -> bool -> unit
val set_tab_detachable :
  t -> Widget.t ptr -> bool -> unit
val set_tab_label :
  t -> Widget.t ptr -> Widget.t ptr option -> unit
val set_tab_label_text :
  t -> Widget.t ptr -> string -> unit
val set_tab_pos :
  t -> Position_type.t -> unit
val set_tab_reorderable :
  t -> Widget.t ptr -> bool -> unit
