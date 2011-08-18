#include "global.h"

value Val_some(value v)
{
    CAMLparam1(v);
    CAMLlocal1(some);
    some = caml_alloc_small(1, 0);
    Field(some, 0) = v;
    CAMLreturn(some);
}

void null_pointer_exn() {
	static value*  e = NULL;
	if(e == NULL) {
		e = caml_named_value("Null_pointer_exn");
	}
	caml_raise_constant(*e);
}

CAML_object::CAML_object(value v1) {
	v = v1;
	caml_register_global_root(&v);
}

value CAML_object::get_object() {
	return v;
}

value CAML_object::get_method(int m) {
	return caml_get_public_method(v, m);
}

value CAML_object::call_method0(int m) {
	return caml_callback(get_method(m), v);
}

CAML_object::~CAML_object() {
	caml_remove_global_root(&v);
}

