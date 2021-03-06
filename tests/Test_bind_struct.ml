(*
 * Copyright 2017-2018 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-GObject-Introspection.
 *
 * OCaml-GObject-Introspection is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-GObject-Introspection is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-GObject-Introspection.  If not, see <http://www.gnu.org/licenses/>.
 *)

open Test_utils
open OUnit2
open GI_bindings_generator
open GObject_introspection

let get_struct_info namespace struct_name =
  match Repository.find_by_name namespace struct_name with
  | None -> None
  | Some bi ->
    match Base_info.get_type bi with
    | Base_info.Struct -> let si = Struct_info.from_baseinfo bi in
      Some si
    | _ -> None

let struct_test namespace struct_name fn =
  match get_struct_info namespace struct_name with
  | None -> assert_equal_string struct_name "No base info found"
  | Some (info) -> fn info

let test_append_ctypes_struct_declaration test_ctxt =
  let namespace = "GLib" in
  let name = "Array" in
  let writer = fun name info sources -> (
    let _ = Bind_struct.append_ctypes_struct_declaration name sources in
    Binding_utils.Sources.write_buffs sources
  )
  in
  let mli = "type t\n\
             val t_typ : t structure typ\n" in
  let ml = "type t\n\
            let t_typ : t structure typ = structure \"Array\"\n" in
  struct_test namespace name (fun info ->
    test_writing test_ctxt info name writer mli ml
    )

let test_append_ctypes_struct_field_declarations test_ctxt =
  let namespace = "GLib" in
  let name = "SList" in
  let writer = fun n i srcs -> (
    let _ = Bind_struct.append_ctypes_struct_field_declarations n i srcs [] in
    Binding_utils.Sources.write_buffs srcs
  )
  in
  let mli = "val f_data: (unit ptr, t structure) field\n\
             val f_next: (t structure ptr, t structure) field\n" in
  let ml = "let f_data = field t_typ \"data\" (ptr void)\n\
            let f_next = field t_typ \"next\" (ptr t_typ)\n\
            let _ = seal t_typ\n" in
  struct_test namespace name (fun info ->
      test_writing test_ctxt info name writer mli ml
  )

let tests =
  "GObject Introspection Bind_struct tests" >:::
  [
    "Bind_struct append ctypes struct declaration" >:: test_append_ctypes_struct_declaration;
  (*  "Bind_struct append ctypes struct field declarations" >:: test_append_ctypes_struct_field_declarations *)
  ]
