open Ocamlbuild_plugin

let ( & ) f x = f x

let ocaml_dir = "/usr/lib/ocaml"

let ocamlmklib = "ocamlmklib"

let irrlicht_include = "/usr/include/irrlicht"

let c_objs =
  ["utils.o"; "irr_base_warp.o"; "irr_core_warp.o";  "irr_io_warp.o";
  "irr_gui_warp.o"; "irr_video_warp.o"; "irr_scene_warp.o"; "irr_warp.o";
  "irr_enums_warp.o"]

let c_headers =
  ["global.h"; "irr_enums_warp_conv.h"; "irr_enums_warp_values.h";
  "irr_base_warp.h";  "irr_enums_warp.h"; "methods_hash_values.h";
  "irr_core_warp.h"; "utils.h"; "irr_enums_warp_poly_values.h"]

let () = dispatch & function
  | Before_options ->
      Options.hygiene := false;
  | After_rules ->
      flag ["ocaml"; "doc"] (A "-hide-warnings");
      rule "make_enums"
        ~prods:["irr_enums_warp_values.h"; "irr_enums_warp_poly_values.h";
          "irr_enums_warp_conv.h"; "irr_enums_warp_conv.cpp"; "irr_enums.mli";
          "irr_enums.ml"]
        ~deps:["enums/main.byte"; "hash_values/main.byte"; "irr_enums.txt"]
        (fun _ _ ->
          Seq [Cmd(S[A "enums/main.byte"; Px "irr_enums.txt"]);
          Cmd(S[A "hash_values/main.byte"; Px "irr_enums_poly_values.txt";
            Sh ">"; Px "irr_enums_warp_poly_values.h"]);
          Cmd(S [A "cp"; Px "irr_enums.mli"; Px "irr_enums.ml"])]);
      rule "make_method_hash_values"
        ~prod:"methods_hash_values.h"
        ~deps:["hash_values/main.byte"; "methods_hash_values.txt"]
        (fun _ _ ->
          Cmd(S [A "hash_values/main.byte"; Px "methods_hash_values.txt";
            Sh ">"; Px "methods_hash_values.h"])
        );
      rule "o_of_cpp" ~prod:"%.o" ~deps:("%.cpp" :: c_headers) (fun env _ ->
        Cmd (S [A "g++"; A "-fPIC"; A "-I"; A irrlicht_include; A "-I";
        A ocaml_dir; A "-c"; Px (env "%.cpp")])
      );
      rule "make_stub"
        ~prods:["dllocaml-irrlicht_stub.so"; "libocaml-irrlicht_stub.a"]
        ~deps:c_objs
        (fun _ _ ->
          let c_objs1 = List.map (fun x -> A x) c_objs in
          Cmd (S [A ocamlmklib; A "-o"; A "ocaml-irrlicht_stub";
          A "-lIrrlicht"; A "-I"; A irrlicht_include; S c_objs1])
        );
      flag_and_dep ["ocaml"; "byte"; "link"; "library"]
        (S [A "-dllib"; Px "dllocaml-irrlicht_stub.so"]);
      flag ["ocaml"; "native"; "link"; "library"]
      (S [A "-cclib"; A "-lIrrlicht"]);
      flag ["file:hash_values/main.byte"] (A "-custom");
      dep ["file:hash_values/main.byte"] ["hash_values/hash.o"];
      dep ["file:irr_enums_warp.o"] ["irr_enums_warp_conv.cpp"]
  | _ -> ()
