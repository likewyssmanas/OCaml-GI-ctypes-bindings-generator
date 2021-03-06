open Ctypes
open Foreign

type t = Not_found | Invalid_uri

let of_value v =
  if v = Unsigned.UInt32.of_int 0 then Not_found
  else if v = Unsigned.UInt32.of_int 1 then Invalid_uri
  else raise (Invalid_argument "Unexpected Recent_chooser_error value")

let to_value = function
  | Not_found -> Unsigned.UInt32.of_int 0
  | Invalid_uri -> Unsigned.UInt32.of_int 1

let t_view = view ~read:of_value ~write:to_value uint32_t

