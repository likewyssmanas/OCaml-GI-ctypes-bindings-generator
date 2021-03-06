open Ctypes

type t
val t_typ : t structure typ

val add_group :
  t structure ptr -> Option_group.t structure ptr -> unit
val add_main_entries :
  t structure ptr -> Option_entry.t structure ptr -> string option -> unit
val free :
  t structure ptr -> unit
val get_description :
  t structure ptr -> string option
val get_help :
  t structure ptr -> bool -> Option_group.t structure ptr option -> string option
val get_help_enabled :
  t structure ptr -> bool
val get_ignore_unknown_options :
  t structure ptr -> bool
val get_main_group :
  t structure ptr -> Option_group.t structure ptr
val get_strict_posix :
  t structure ptr -> bool
val get_summary :
  t structure ptr -> string option
(*Not implemented g_option_context_parse type C Array type for Types.Array tag not implemented*)
(*Not implemented g_option_context_parse_strv type C Array type for Types.Array tag not implemented*)
val set_description :
  t structure ptr -> string option -> unit
val set_help_enabled :
  t structure ptr -> bool -> unit
val set_ignore_unknown_options :
  t structure ptr -> bool -> unit
val set_main_group :
  t structure ptr -> Option_group.t structure ptr -> unit
val set_strict_posix :
  t structure ptr -> bool -> unit
val set_summary :
  t structure ptr -> string option -> unit
(*Not implemented g_option_context_set_translate_func type callback not implemented*)
val set_translation_domain :
  t structure ptr -> string -> unit
