DESTDIR=#/usr/local/lib

all :
	ocamlbuild all.otarget

clean :
	ocamlbuild -clean

install :
	ocamlfind install -destdir $(DESTDIR) irrlicht META _build/*.cma _build/*.cmxa _build/irr*.cmi _build/*.a _build/*.so

uninstall:
	ocamlfind remove -destdir $(DESTDIR) irrlicht
