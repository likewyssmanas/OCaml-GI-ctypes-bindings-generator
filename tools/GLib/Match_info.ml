open Ctypes
open Foreign

type t
let t_typ : t structure typ = structure "Match_info"

let expand_references self string_to_expand =
  let expand_references_raw =
    foreign "g_match_info_expand_references" (ptr t_typ @-> string @-> ptr (ptr_opt Error.t_typ) @-> returning (string_opt))
  in
  let err_ptr_ptr = allocate (ptr_opt Error.t_typ) None in
  let ret = expand_references_raw self string_to_expand err_ptr_ptr in
  match (!@ err_ptr_ptr) with
  | None -> Ok ret
  | Some _ -> let err_ptr = !@ err_ptr_ptr in
    let _ = Gc.finalise (function | Some e -> Error.free e | None -> () ) err_ptr in
    Error (err_ptr)
let fetch =
  foreign "g_match_info_fetch" (ptr t_typ @-> int32_t @-> returning (string_opt))
(*Not implemented g_match_info_fetch_all return type C Array type for Types.Array tag not handled*)
let fetch_named =
  foreign "g_match_info_fetch_named" (ptr t_typ @-> string @-> returning (string_opt))
let fetch_named_pos self name =
  let fetch_named_pos_raw =
    foreign "g_match_info_fetch_named_pos" (ptr t_typ @-> string @-> ptr (int32_t) @-> ptr (int32_t) @-> returning (bool))
  in
  let start_pos_ptr = allocate int32_t Int32.zero in
  let end_pos_ptr = allocate int32_t Int32.zero in
  let ret = fetch_named_pos_raw self name start_pos_ptr end_pos_ptr in
  let start_pos = !@ start_pos_ptr in
  let end_pos = !@ end_pos_ptr in
  (ret, start_pos, end_pos)
let fetch_pos self match_num =
  let fetch_pos_raw =
    foreign "g_match_info_fetch_pos" (ptr t_typ @-> int32_t @-> ptr (int32_t) @-> ptr (int32_t) @-> returning (bool))
  in
  let start_pos_ptr = allocate int32_t Int32.zero in
  let end_pos_ptr = allocate int32_t Int32.zero in
  let ret = fetch_pos_raw self match_num start_pos_ptr end_pos_ptr in
  let start_pos = !@ start_pos_ptr in
  let end_pos = !@ end_pos_ptr in
  (ret, start_pos, end_pos)
let free =
  foreign "g_match_info_free" (ptr t_typ @-> returning (void))
let get_match_count =
  foreign "g_match_info_get_match_count" (ptr t_typ @-> returning (int32_t))
let get_regex =
  foreign "g_match_info_get_regex" (ptr t_typ @-> returning (ptr Regex.t_typ))
let get_string =
  foreign "g_match_info_get_string" (ptr t_typ @-> returning (string_opt))
let is_partial_match =
  foreign "g_match_info_is_partial_match" (ptr t_typ @-> returning (bool))
let matches =
  foreign "g_match_info_matches" (ptr t_typ @-> returning (bool))
let next self =
  let next_raw =
    foreign "g_match_info_next" (ptr t_typ @-> ptr (ptr_opt Error.t_typ) @-> returning (bool))
  in
  let err_ptr_ptr = allocate (ptr_opt Error.t_typ) None in
  let ret = next_raw self err_ptr_ptr in
  match (!@ err_ptr_ptr) with
  | None -> Ok ret
  | Some _ -> let err_ptr = !@ err_ptr_ptr in
    let _ = Gc.finalise (function | Some e -> Error.free e | None -> () ) err_ptr in
    Error (err_ptr)
let incr_ref =
  foreign "g_match_info_ref" (ptr t_typ @-> returning (ptr t_typ))
let unref =
  foreign "g_match_info_unref" (ptr t_typ @-> returning (void))
