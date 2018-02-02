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

open Ctypes
open Foreign
open GObject_introspection

(* Check is the argument is of the same type of the of the current module in
 * which the bindings are generated.
 * For example, if this code generator is parsing arguments of a function that
 * has to be defined in the Core module, when it finds an argument with the
 * type Core.a_type, in order to compile, this type should be written as "a_type".
 * *)
let filter_same_argument_type_as_container container_name (ocaml_type, ctypes_typ) =
  let open Binding_utils in
  let module_pattern = container_name ^ "." in
  let ocaml_type' = string_pattern_remove ocaml_type module_pattern in
  let ctypes_typ' = string_pattern_remove ctypes_typ module_pattern in
  (ocaml_type', ctypes_typ')

let check_if_types_are_not_from_core =
  filter_same_argument_type_as_container "Core"

type func_types = | Not_handled of string
                  | Skipped of string
                  | Type_names of (string * string) list

let get_return_types callable container skip_types =
  if Callable_info.skip_return callable then Type_names [("unit", "void")]
  else let ret = Callable_info.get_return_type callable in
    let may_be_null = Callable_info.may_return_null callable in
    match Binding_utils.type_info_to_bindings_types ret may_be_null with
    | Binding_utils.Not_implemented tag_name -> Not_handled tag_name
    | Types {ocaml = ocaml_type; ctypes = ctypes_typ} ->
        let types = filter_same_argument_type_as_container container (ocaml_type, ctypes_typ) in
        if Binding_utils.match_one_of ocaml_type skip_types then Skipped ocaml_type
        else Type_names [types]
      (* TODO : how to free the returned data
      match Callable_info.get_caller_owns callable with
      | Arg_info.Nothing -> ()
      | Arg_info.Container -> ()
      | Arg_info.Everything -> ()
      *)

(* Build function bindings :
 * - get the Callable_info
 * - find out the numbers of arguments
 *   - for each argument :
 *     - get the direction :
 *       - in
 *       - out
 *       - in/out
 *     - get the transfert method
 *       - nothing
 *       - container
 *       - everything
 *     - get the Type_info
 *       - get the Tag (scalar data or complex data)
 *     - find out if it is a pointer
 *)

type arg = Not_implemented of string
         | Skipped of string
         | Arg of {name : string; ocaml_type : string; ctypes_type : string; type_info : Type_info.t structure ptr option}

type arg_lists = {in_list : arg list; out_list : arg list; in_out_list : arg list}

type args = No_args | Args of arg_lists

let has_out_arg = function
  | No_args -> false
  | Args args -> if List.length args.out_list > 0 then true else false

let has_in_out_arg = function
  | No_args -> false
  | Args args -> if List.length args.in_out_list > 0 then true else false

let has_not_implemented_arg = function
  | No_args -> None
  | Args args ->
    let search =
      List.find_opt (fun a -> match a with
                              | Not_implemented _ -> true
                              | _ -> false)
    in
    match search args.in_list with
    | Some a -> Some a
    | None -> match search args.out_list with
              | Some a -> Some a
              | None -> search args.in_out_list

let has_skipped_arg = function
  | No_args -> None
  | Args args ->
    let search l =
      List.find_opt (fun a -> match a with
                              | Skipped _ -> true
                              | _ -> false) l
    in
    match search args.in_list with
    | Some a -> Some a
    | None -> match search args.out_list with
              | Some a -> Some a
              | None -> search args.in_out_list

(* Get the escaped name (valid OCaml variable name) of the argument. Raise a Failure
 * exception. It is an error to try to get the name of the argument while I should
 * skeep / not implement the function bindings *)
let get_escaped_arg_names =
  List.map (fun a ->
    match a with
    | Not_implemented message -> raise (Failure (Printf.sprintf "get_escaped_arg_names : Not_implemented -> %s" message))
    | Skipped message -> raise (Failure (Printf.sprintf "get_escaped_arg_names : Skipped -> %s" message))
    | Arg arg -> Binding_utils.ensure_valid_variable_name arg.name
)

let get_escaped_arg_name = function
  | Not_implemented message -> raise (Failure (Printf.sprintf "get_escaped_arg_names : Not_implemented -> %s" message))
  | Skipped message -> raise (Failure (Printf.sprintf "get_escaped_arg_names : Skipped -> %s" message))
  | Arg arg -> Binding_utils.ensure_valid_variable_name arg.name

(* get the OCaml type of an argument and raise an exception if it is not implemented
 * or if it is skipped. *)
let get_ocaml_type = function
  | Not_implemented message -> raise (Failure (Printf.sprintf "get_ocaml_type : Not_implemented -> %s" message))
  | Skipped message -> raise (Failure (Printf.sprintf "get_ocaml_type : Skipped -> %s" message))
  | Arg arg -> arg.ocaml_type

(* get the Ctypes type of an argument and raise an exception if it is not implemented
 * or if it is skipped. *)
let get_ctypes_type = function
  | Not_implemented message -> raise (Failure (Printf.sprintf "get_ocaml_type : Not_implemented -> %s" message))
  | Skipped message -> raise (Failure (Printf.sprintf "get_ocaml_type : Skipped -> %s" message))
  | Arg arg -> arg.ctypes_type

(* get the Type_info.t of an argument or raise an exception if it is not
 * implemented or if it is skipped. *)
let get_type_info = function
  | Not_implemented message -> raise (Failure (Printf.sprintf "get_type_info : Not_implemented -> %s" message))
  | Skipped message -> raise (Failure (Printf.sprintf "get_type_info : Skipped -> %s" message))
  | Arg arg -> arg.type_info

let get_args_information callable container skip_types =
  let n = Callable_info.get_n_args callable in
  let is_method = Callable_info.is_method callable in
  if n = 0 && not is_method then No_args
  else (
    let fetch_arg_info arg =
      let t_info = Arg_info.get_type arg in
      let may_be_null = Arg_info.may_be_null arg in
      match Binding_utils.type_info_to_bindings_types t_info may_be_null with
      | Binding_utils.Not_implemented tag_name -> Not_implemented tag_name
      | Types {ocaml = ocaml_type'; ctypes = ctypes_type'} ->
          let (ocaml_type, ctypes_type) = filter_same_argument_type_as_container container (ocaml_type', ctypes_type') in
          if Binding_utils.match_one_of ocaml_type skip_types then Skipped ocaml_type
          else let name = ( let info' = Arg_info.to_baseinfo arg in
                            match Base_info.get_name info' with
                            | None -> raise (Failure "It should have a name :Bind_function Arg_info.in")
                            | Some s -> s ) in
          Arg {name; ocaml_type; ctypes_type; type_info = Some t_info}
    in
    let append_self_if_needed l =
      if is_method then
         let arg = Arg { name = "self";
                         ocaml_type = "t structure ptr";
                         ctypes_type = "ptr t_typ";
                         type_info = None } in
         arg :: l
      else l
    in
    let rec _each_arg i {in_list; out_list; in_out_list} =
      if i >= n then { in_list = append_self_if_needed (List.rev in_list);
                       out_list = List.rev out_list;
                       in_out_list = List.rev in_out_list;
                     }
      else (
        let arg = Callable_info.get_arg callable i in
           match Arg_info.get_direction arg with
           | Arg_info.In -> _each_arg (i + 1) {in_list = (fetch_arg_info arg) :: in_list; out_list; in_out_list}
           | Arg_info.Out -> _each_arg (i + 1 ) {in_list; out_list = (fetch_arg_info arg) :: out_list; in_out_list}
           | Arg_info.InOut -> _each_arg (i + 1) {in_list; out_list; in_out_list = (fetch_arg_info arg) :: in_out_list}
      )
    in
    let empty_args = {in_list = []; out_list = []; in_out_list = []} in
    Args (_each_arg 0 empty_args)
  )

let generate_callable_bindings_when_only_in_arg callable name symbol arguments ret_types sources =
  let open Binding_utils in
  let mli = Sources.mli sources in
  let ml = Sources.ml sources in
  let (ocaml_ret, ctypes_ret) = List.hd ret_types in
  let _ = File.bprintf mli "val %s:\n  " name in
  if Callable_info.can_throw_gerror callable then (
    let ocaml_ret' = if ocaml_ret = "string" then "string option" else ocaml_ret in
    let ctypes_ret' = if ctypes_ret = "string" then "string_opt" else ctypes_ret in
    let _ = match arguments with
      | No_args ->
        let _ = File.bprintf mli "unit -> (%s, Error.t structure ptr option) result\n" ocaml_ret' in
        let _ = File.bprintf ml "let %s () =\n" name in
        let name_raw = name ^ "_raw" in
        let _ = File.bprintf ml "  let %s =\n    foreign \"%s\" " name_raw symbol in
        let _ = File.bprintf ml "(ptr_opt (ptr_opt Error.t_typ) @-> returning (%s))\n  in\n" ctypes_ret' in
        let _ = File.buff_add_line ml "  let err_ptr_ptr = allocate (ptr_opt Error.t_typ) None in" in
        File.bprintf ml "  let value = %s (Some err_ptr_ptr) in\n" name_raw
      | Args args ->
        let _ = File.bprintf mli "%s -> (%s, Error.t structure ptr option) result\n" (String.concat " -> " (List.map (fun a -> get_ocaml_type a) args.in_list)) ocaml_ret' in
        let arg_names = get_escaped_arg_names args.in_list |> String.concat " " in
        let _ = File.bprintf ml "let %s %s =\n" name arg_names in
        let name_raw = name ^ "_raw" in
        let _ = File.bprintf ml "  let %s =\n    foreign \"%s\" " name_raw symbol in
        let _ = File.bprintf ml "(%s" (String.concat " @-> " (List.map (fun a -> get_ctypes_type a) args.in_list)) in
        let _ = File.bprintf ml "@-> ptr_opt (ptr_opt Error.t_typ) @-> returning (%s))\n  in\n" ctypes_ret' in
        let _ = File.buff_add_line ml "  let err_ptr_ptr = allocate (ptr_opt Error.t_typ) None in" in
        File.bprintf ml "  let value = %s %s (Some err_ptr_ptr) in\n" name_raw arg_names
    in
    let _ = File.buff_add_line ml "  match (!@ err_ptr_ptr) with" in
    let _ = File.buff_add_line ml "   | None -> Ok value" in
    let _ = File.buff_add_line ml "   | Some _ -> let err_ptr = !@ err_ptr_ptr in" in
    let _ = File.buff_add_line ml "     let _ = Gc.finalise (function | Some e -> Error.free e | None -> () ) err_ptr in" in
    File.buff_add_line ml "     Error (err_ptr)"
  ) else (
    let _ = File.bprintf ml "let %s =\n  foreign \"%s\" " name symbol in
    let _ = match arguments with
      | No_args -> let _ = File.bprintf mli "%s" "unit" in
        File.bprintf ml "(%s" "void"
      | Args args -> let _ = File.bprintf mli "%s" (String.concat " -> " (List.map (fun a -> get_ocaml_type a) args.in_list)) in
        File.bprintf ml "(%s" (String.concat " @-> " (List.map (fun a -> get_ctypes_type a) args.in_list))
    in
    let _ = File.bprintf mli " -> %s\n" ocaml_ret in
    File.bprintf ml " @-> returning (%s))\n" ctypes_ret
  )

let generate_callable_bindings_when_out_args callable name symbol arguments ret_types sources =
  let open Binding_utils in
  let (ocaml_ret, ctypes_ret) = List.hd ret_types in
  let mli = Sources.mli sources in
  let ml = Sources.ml sources in
  let _ = File.bprintf mli "(* Not implemented %s - out argument not handled\n" symbol in
  let _ = File.bprintf ml "(* Not implemented %s - out argument not handled\n" symbol in
  let _ = match arguments with
    | No_args -> raise (Failure "generate_callable_bindings_when_out_args with No_args")
    | Args args ->
      let ocaml_types_out =
        List.map (fun a -> get_ocaml_type a) args.out_list
        |> function
          | [] -> Printf.sprintf "(%s)" ocaml_ret
          | ocaml_args -> let all_elements =
            if ocaml_ret = "unit" then ocaml_args else ocaml_ret :: ocaml_args
            in Printf.sprintf "(%s)" (String.concat " * " all_elements)
      in
      (* signature helper in the ml file *)
      let _ = File.bprintf ml "\n(* %s" (match args.in_list with
        | [] -> "unit"
        | h :: t -> (String.concat " -> " (List.map (fun a -> get_ocaml_type a) args.in_list)))
      in
      let _ = File.bprintf ml " -> %s*)\n" ocaml_types_out in
      (* signature helper in the ml file *)
      let function_decl = name :: (match args.in_list with | [] -> "()" :: [] | _ -> get_escaped_arg_names args.in_list) in
      let _ = File.bprintf ml "let %s =\n" (String.concat " " function_decl) in
      let _ = File.bprintf mli "val %s :\n" name in
      let _ = File.bprintf mli "  %s" (match args.in_list with | [] -> "unit" | _ -> (String.concat " -> " (List.map (fun a -> get_ocaml_type a) args.in_list))) in
      let _ = File.bprintf mli " -> %s\n" ocaml_types_out in
      let _ = List.iter (fun a ->
        let name = get_escaped_arg_name a in
        match get_type_info a with
        | None -> raise (Failure "generate_callable_bindings_when_out_args: no typeinfo for arg")
        | Some type_info ->
            match allocate_type_bindings type_info name with
            | None -> raise (Failure "generate_callable_bindings_when_out_args: unable to get type to allocate")
            | Some (s, _) -> File.bprintf ml "  %s" s
      ) args.out_list in
      let _ = File.bprintf ml "  let %s_raw =\n" name in
      let _ = File.bprintf ml "    foreign \"%s\" (%s " symbol (String.concat " @-> " (List.map (fun a -> get_ctypes_type a) args.in_list)) in
      let _ = File.bprintf ml "@-> %s" (String.concat " @-> " (List.map (fun a -> "ptr " ^ (get_ctypes_type a)) args.out_list)) in
      let _ = File.bprintf ml " @-> returning %s)\n  in\n" ctypes_ret in
      let _ = File.bprintf ml "  let ret = %s_raw %s %s in\n" name (String.concat " " (List.map (fun a -> get_escaped_arg_name a) args.in_list))
                                                            (String.concat " " (List.map (fun a -> (get_escaped_arg_name a) ^ "_ptr") args.out_list)) in
      let _ = List.iter (fun a ->
        let name = get_escaped_arg_name a in
        match get_type_info a with
        | None -> raise (Failure "generate_callable_bindings_when_out_args: no typeinfo for arg")
        | Some type_info ->
            match allocate_type_bindings type_info name with
            | None -> raise (Failure "generate_callable_bindings_when_out_args: unable to get type to allocate")
            | Some (_, g) -> File.bprintf ml "  let %s = %s in\n" name g
      ) args.out_list in
      if ocaml_ret = "unit" then
        match args.out_list with
        | [] -> File.buff_add_line ml "  (ret)"
        | _ -> File.bprintf ml "  (%s)\n" (String.concat ", " (List.map (fun a -> get_escaped_arg_name a) args.out_list))
      else File.bprintf ml "  (ret, %s)\n" (String.concat ", " (List.map (fun a -> get_escaped_arg_name a) args.out_list))
   (* generate the function return types with the args out
   generate the function signature with only "in args"
   allocate the args out
   create the raw function binding
   call it
   return the args out value
   *)
  in
  let _ = File.buff_add_line mli "*)" in
  File.buff_add_line ml "*)"

let should_be_implemented args sources symbol =
  let open Binding_utils in
  let get_info_for_non_usable_arg = function
      | Arg _ -> raise (Failure "get_info_for_non_usable_arg: this should never has been reached")
      | Not_implemented message -> message
      | Skipped message -> message
  in
  match has_not_implemented_arg args with
  | Some arg -> let coms = Printf.sprintf "Not implemented %s type %s not implemented" symbol (get_info_for_non_usable_arg arg) in
      let _ = Sources.buffs_add_comments sources coms in false
  | None -> match has_skipped_arg args with
    | Some arg -> let coms = Printf.sprintf " %s type %s skipped" symbol (get_info_for_non_usable_arg arg) in
    let _ = Sources.buffs_add_skipped sources coms in false
    | None -> true

let append_ctypes_function_bindings raw_name info container sources skip_types =
  let open Binding_utils in
  let symbol = Function_info.get_symbol info in
  let name = Binding_utils.ensure_valid_variable_name (if raw_name = "" then symbol else raw_name) in
  let callable = Function_info.to_callableinfo info in
  let args = get_args_information callable container skip_types in
  if should_be_implemented args sources symbol then (
        match get_return_types callable container skip_types with
        | Not_handled t ->
            let coms = Printf.sprintf "Not implemented %s return type %s not handled" symbol t in
            Sources.buffs_add_comments sources coms
        | Skipped t ->let coms = Printf.sprintf "%s return type %s" symbol t in
            Sources.buffs_add_skipped sources coms
        | Type_names ret_types ->
            if has_out_arg args then
              generate_callable_bindings_when_out_args callable name symbol args ret_types sources
            else if has_in_out_arg args then
              let coms  = Printf.sprintf "Not implemented %s - in out argument not handled" symbol in
              Sources.buffs_add_comments sources coms
            else generate_callable_bindings_when_only_in_arg callable name symbol args ret_types sources
    )

let parse_function_info info sources skip_types =
  let open Binding_utils in
  match Base_info.get_name info with
  | None -> ()
  | Some name ->
     let info' = Function_info.from_baseinfo info in
     let _ = append_ctypes_function_bindings name info' "Core" sources skip_types in
     let _ = Sources.buffs_add_eol sources in
     Sources.write_buffs sources
