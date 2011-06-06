all :
	ocamlbuild all.otarget

clean :
	ocamlbuild -clean

install :
	ocamlfind install irrlicht META _build/*.cma _build/*.cmxa _build/irr*.cmi _build/*.a _build/*.so

uninstall:
	ocamlfind remove irrlicht
