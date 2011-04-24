/* C++ stub for Irr_core module */

#include "irr_core_warp.h"

dimension2d<u32> Dimension2d_u32_val(value v) {
	return dimension2d<u32>(Int_val(Field(v, 0)), Int_val(Field(v, 1)));
}

value copy_dimension2d_u32(dimension2d<u32> d) {
	value v = caml_alloc(2, 0);
	Store_field(v, 0, Val_int(d.Width));
	Store_field(v, 1, Val_int(d.Height));
	return v;
}

dimension2d<f32> Dimension2d_f32_val(value v) {
	return dimension2d<f32>(Double_val(Field(v, 0)), Double_val(Field(v, 1)));
}

value copy_dimension2d_f32(dimension2d<f32> d) {
	CAMLparam0();
	CAMLlocal1(v);
	Store_field(v, 0, copy_double(d.Width));
	Store_field(v, 1, copy_double(d.Height));
	CAMLreturn(v);
}

position2d<s32> Pos2d_s32_val(value v) {
	return position2d<s32>(Int_val(Field(v, 0)), Int_val(Field(v, 1)));
}

value copy_pos2d_s32(position2d<s32> pos) {
	value v = caml_alloc(2, 0);
	Store_field(v, 0, Val_int(pos.X));
	Store_field(v, 1, Val_int(pos.Y));
	return v;
}

vector3df Vector3df_val(value v) {
	return vector3df(Double_val(Field(v, 0)), Double_val(Field(v, 1)),
			Double_val(Field(v, 2)));
}

value copy_vector3df(vector3df x) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(3, 0);
	Store_field(v, 0, caml_copy_double(x.X));
	Store_field(v, 1, caml_copy_double(x.Y));
	Store_field(v, 2, caml_copy_double(x.Z));
	CAMLreturn(v);
}

line3df Line3df_val(value v) {
	return line3d<f32>(Vector3df_val(Field(v, 0)), Vector3df_val(Field(v, 1)));
}

value copy_line3df(line3df l) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(2, 0);
	Store_field(v, 0, copy_vector3df(l.start));
	Store_field(v, 1, copy_vector3df(l.end));
	CAMLreturn(v);
}

triangle3df Triangle3df_val(value v) {
	return triangle3d<f32>(Vector3df_val(Field(v, 0)), Vector3df_val(Field(v, 1)),
			Vector3df_val(Field(v, 2)));
}

value copy_triangle3df(triangle3df t) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(3, 0);
	Store_field(v, 0, copy_vector3df(t.pointA));
	Store_field(v, 1, copy_vector3df(t.pointB));
	Store_field(v, 2, copy_vector3df(t.pointC));
	CAMLreturn(v);
}

rect<s32> Rect_s32_val(value v) {
	return rect<s32>(Int_val(Field(v, 0)), Int_val(Field(v, 1)),
			Int_val(Field(v, 2)), Int_val(Field(v, 3)));
}

SColor SColor_val(value v) {
	return SColor(Int_val(Field(v, 0)), Int_val(Field(v, 1)),
			Int_val(Field(v, 2)), Int_val(Field(v, 3)));
}

value copy_SColor(SColor c) {
	value v = caml_alloc(4, 0);
	Store_field(v, 0, Val_int(c.getAlpha()));
	Store_field(v, 1, Val_int(c.getRed()));
	Store_field(v, 2, Val_int(c.getGreen()));
	Store_field(v, 3, Val_int(c.getBlue()));
	return v;
}

SColorf SColorf_val(value v) {
	return SColorf(Double_field(v, 1), Double_field(v, 2), Double_field(v, 3),
			Double_field(v, 0));
}

value copy_SColorf(SColorf c) {
	value v = caml_alloc(4, Double_array_tag);
	Store_double_field(v, 0, c.a);
	Store_double_field(v, 1, c.r);
	Store_double_field(v, 2, c.g);
	Store_double_field(v, 3, c.b);
	return v;
}

matrix4 Matrix4_val(value v) {
	matrix4 mat;
	int i;
	for(i = 0; i < 16; i++) {
		mat[i] = Double_field(v, i);
	}
	return mat;
}

value copy_matrix4(matrix4 mat) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(16, Double_array_tag);
	int i;
	for(i = 0; i < 16; i++) {
		Store_double_field(v, i, mat[i]);
	}
	CAMLreturn(v);
}

