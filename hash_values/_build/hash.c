#include<stdio.h>
#include<caml/mlvalues.h>
#include<caml/alloc.h>

CAMLprim value get_hash_value(value v) {
	char* variant = String_val(v);
	int i = caml_hash_variant(variant);
	char r[255];
	sprintf(r, "%d", i);
	return caml_copy_string(r);
}

