open Printf

let () =
  let filename = Sys.argv.(1) in
  Sys.chdir "hash_values";
  let _ = Sys.command (sprintf "./main ../%s > gen.c" filename) in
  let _ =Sys.command "gcc -o gen -L /usr/lib/ocaml -lcamlrun gen.c" in
  let _ = Sys.command "gen" in
  ()
