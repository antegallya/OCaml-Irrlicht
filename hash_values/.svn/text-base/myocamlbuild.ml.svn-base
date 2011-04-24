open Ocamlbuild_plugin

let ( & ) f x = f x

let () = dispatch & function
  | After_rules ->
      flag ["ocaml"; "byte"; "link"] (A "-custom");
      dep ["ocaml"; "link"] ["hash.o"]
  | _ -> ()
