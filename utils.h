/* Some general things for the CAML/C++ interface. */

#ifndef UTILS_H
#define UTILS_H

/* Standart C library */
extern "C" {
#include<stdio.h>
}

/* Caml headers */
extern "C" {
#include<caml/mlvalues.h>
#include<caml/memory.h>
#include<caml/callback.h>
#include<caml/fail.h>
#include<caml/alloc.h>
#include<caml/misc.h>
}

value Val_some(value);

/* Raise Null_pointer_exn */
void null_pointer_exn();

/* Class used to defined director classes */
class CAML_object {
	private:
		value v;
	public:
		CAML_object(value v1);
		value get_object();
		value get_method(int m);
		value call_method0(int m);
		~CAML_object();
};

#endif
