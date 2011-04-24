open Printf

external get_hash_value : string -> string = "get_hash_value"

let () =
  if Array.length Sys.argv <> 2 then (
    print_endline "USAGE : variants filename";
    exit 0
  );
  let filename = Sys.argv.(1) in
  let lexbuf = Lexing.from_channel (open_in filename) in
  let variants = Parser.variants Lexer.token lexbuf in
  List.iter (fun (n, v) ->
    printf "#define %s (%s)\n" n (get_hash_value v)
  ) variants;
  flush stdout
