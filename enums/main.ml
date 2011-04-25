open Expr
open Printf

(* Read the description file *)
let get_dec () =
  let lexbuf = Lexing.from_channel (open_in "irr_enums.txt") in
  Parser.enums Lexer.token lexbuf

let ml_name e s =
  let s1 = String.sub s e.prefix (String.length s - e.prefix) in
  let s2 = String.lowercase s1 in
  if not e.poly then s2.[0] <- Char.uppercase s2.[0];
  if s2 = "end" then "ends" else s2

(* Create the mli file *)

let print_ml_type e file =
  if e.poly = true then (
    fprintf file "type %s = [\n" e.name;
    List.iter (fun s -> fprintf file "| `%s\n" (ml_name e s)) e.values;
    fprintf file "]\n\n"
  ) else (
    fprintf file "type %s = \n" e.name;
    List.iter (fun s -> fprintf file "| %s\n" (ml_name e s)) e.values;
    fprintf file "\n"
  )

let create_mli enums =
  let file = open_out "irr_enums.mli" in
  List.iter (fun e -> print_ml_type e file) enums;
  flush file;
  close_out file

(* Create the C header for the values *)

let create_c_header_values_aux e file =
  if e.poly  = false then
  let _ = List.fold_left (fun i s ->
    fprintf file "#define Val_%s Val_int(%d)\n" (ml_name e s) i;
    i + 1) 0 e.values in
  ()

let create_c_header_values enums =
  let file = open_out "irr_enums_wrap_values.h" in
  List.iter (fun e -> create_c_header_values_aux e file) enums;
  flush file;
  close_out file

(* Create the config file for the polymorphic values *)

let create_config_poly_values_aux e file =
  if e.poly = true then
  List.iter (fun s ->
    fprintf file "Val_%s %s,\n" (ml_name e s) (ml_name e s)
  ) e.values

let create_config_poly_values enums =
  let file = open_out "irr_enums_poly_values.txt" in
  List.iter (fun e -> create_config_poly_values_aux e file) enums;
  flush file;
  close_out file

(* Print the function Val_xxx *)
let val_enum e file =
  let f x = fprintf file x in
  f "value Val_%s(%s x) {\n" e.name e.c_name;
  f "  switch(x) {\n";
  List.iter (fun s ->
    f "    case %s : return Val_%s;\n" s (ml_name e s)
  ) e.values;
  f "    default : return 0;\n";
  fprintf file "  }\n}\n\n"

(* Print the function xxx_val *)
let enum_val e file =
  let f x = fprintf file x in
  f "%s %s_val(value v) {\n" e.c_name e.name;
  f "  switch(v) {\n";
  List.iter (fun s ->
    f "    case Val_%s : return %s;\n" (ml_name e s) s
  ) e.values;
  f "    default : return %s;\n" (List.hd e.values);
  fprintf file "  }\n}\n\n"

(* Create the C implentation of conversions file *)
let create_c_conv_impl enums =
  let file = open_out "irr_enums_wrap_conv.cpp" in
  List.iter (fun e ->
    val_enum e file;
    enum_val e file
  ) enums;
  flush file;
  close_out file

(* Print the header of conversions *)

let create_c_conv_header enums =
  let file = open_out "irr_enums_wrap_conv.h" in
  List.iter (fun e ->
    fprintf file "value Val_%s(%s);\n" e.name e.c_name;
    fprintf file "%s %s_val(value);\n\n" e.c_name e.name
  ) enums;
  flush file;
  close_out file

let () =
  let enums = get_dec () in
  create_mli enums;
  create_c_header_values enums;
  create_c_conv_header enums;
  create_c_conv_impl enums;
  create_config_poly_values enums
