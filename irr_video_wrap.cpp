/* C++ stub for the Irr_video module */

#include "global.h"

void rendering_failed_exn() {
	static value* e = NULL;
	if(e == NULL)
		e = caml_named_value("Rendering_failed_exn");
	caml_raise_constant(*e);
}

/* Stub for ITexture class */

extern "C" CAMLprim value ml_ITexture_getOriginalSize(value v_tex) {
	return copy_dimension2d_u32(((ITexture*) v_tex)->getOriginalSize());
}

/* Stub for SMaterialLayer class */

extern "C" CAMLprim value ml_SMaterialLayer_set_BilinearFilter(
		value v_layer, value v_b)
{
	((SMaterialLayer*) v_layer)->BilinearFilter = Bool_val(v_b);
	return Val_unit;
}

/* Stub for SMaterial class */

extern "C" CAMLprim value ml_SMaterial_TextureLayer(value v_mat, value v_i) {
	return (value) &((SMaterial*) v_mat)->TextureLayer[Int_val(v_i)];
}

extern "C" CAMLprim value ml_SMaterial_set_AntiAliasing(
		value v_mat, value v_mode)
{
	((SMaterial*) v_mat)->AntiAliasing = anti_aliasing_mode_val(v_mode);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_get_Wireframe(value v_mat) {
	return Val_bool(((SMaterial*) v_mat)->Wireframe);
}

extern "C" CAMLprim value ml_SMaterial_get_PointCloud(value v_mat) {
	return Val_bool(((SMaterial*) v_mat)->PointCloud);
}

extern "C" CAMLprim value ml_SMaterial_get_MaterialType(value v_mat) {
	return Val_material_type(((SMaterial*) v_mat)->MaterialType);
}

extern "C" CAMLprim value ml_SMaterial_setTexture(
		value v_mat, value v_i, value v_tex)
{
	((SMaterial*) v_mat)->setTexture(Int_val(v_i), (ITexture*) v_tex);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_set_Lighting(value v_mat, value v_flag) {
	((SMaterial*) v_mat)->Lighting = Bool_val(v_flag);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_set_NormalizeNormals(
		value v_mat, value v_flag)
{
	((SMaterial*) v_mat)->NormalizeNormals = Bool_val(v_flag);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_set_Wireframe(value v_mat, value v_flag) 
{
	((SMaterial*) v_mat)->Wireframe = Bool_val(v_flag);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_create(value vunit) {
	SMaterial* mat = new SMaterial;
	if(mat == NULL) null_pointer_exn();
	return (value) mat;
}

extern "C" CAMLprim value ml_SMaterial_destroy(value v_mat) {
	delete ((SMaterial*) v_mat);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_set_AmbientColor(
		value v_mat, value v_color)
{
	((SMaterial*) v_mat)->AmbientColor = SColor_val(v_color);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_get_AmbientColor(value v_mat) {
	return copy_SColor(((SMaterial*) v_mat)->AmbientColor);
}

extern "C" CAMLprim value ml_SMaterial_get_AntiAliasing(value v_mat) {
	return Val_anti_aliasing_mode(((SMaterial*) v_mat)->AntiAliasing);
}

extern "C" CAMLprim value ml_SMaterial_set_BackfaceCulling(
		value v_mat, value v_flag)
{
	((SMaterial*) v_mat)->BackfaceCulling = Bool_val(v_flag);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_get_BackfaceCulling(value v_mat) {
	return Val_bool(((SMaterial*) v_mat)->BackfaceCulling);
}

extern "C" CAMLprim value ml_SMaterial_setFlag(
		value v_mat, value v_flag, value v_b)
{
	((SMaterial*) v_mat)->setFlag(material_flag_val(v_flag), Bool_val(v_b));
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_getFlag(value v_mat, value v_flag) {
	return Bool_val(((SMaterial*) v_mat)->getFlag(material_flag_val(v_flag)));
}

extern "C" CAMLprim value ml_SMaterial_set_SpecularColor(
		value v_mat, value v_color)
{
	((SMaterial*) v_mat)->SpecularColor = SColor_val(v_color);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_set_ColorMask(
		value v_mat, value v_mask)
{
	((SMaterial*) v_mat)->ColorMask <- color_plane_val(v_mask);
	return Val_unit;
}

extern "C" CAMLprim value ml_SMaterial_get_ColorMask(value v_mat) {
	return Val_color_plane(((SMaterial*) v_mat)->ColorMask);
}

/* Stub for IVideoDriver class */

extern "C" CAMLprim value ml_IVideoDriver_beginScene(value v_driver,
		value v_backbuffer, value v_zbuffer, value v_color)
{
	IVideoDriver* driver = (IVideoDriver*) v_driver;
	if(!driver->beginScene(Bool_val(v_backbuffer), Bool_val(v_zbuffer),
				SColor_val(v_color)))
		rendering_failed_exn();
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_endScene(value v_driver) {
	IVideoDriver* driver = (IVideoDriver*) v_driver;
	if(!driver->endScene())
		rendering_failed_exn();
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_getTexture(
		value v_driver, value v_filename)
{
	ITexture* tex =
		((IVideoDriver*) v_driver)->getTexture(String_val(v_filename));
	if(tex == NULL) null_pointer_exn();
	return (value) tex;
}

extern "C" CAMLprim value ml_IVideoDriver_getFPS(value v_driver) {
	return Val_int(((IVideoDriver*) v_driver)->getFPS());
}

extern "C" CAMLprim value ml_IVideoDriver_getName(value v_driver) {
	const wchar_t* wc_name = ((IVideoDriver*) v_driver)->getName();
	int n = wcslen(wc_name);
	char name[2 * (n + 1)];
	wcstombs(name, wc_name, 2 * n);
	return caml_copy_string(name);
}

extern "C" CAMLprim value ml_IVideoDriver_draw2DImage_native(
		value v_driver, value v_tex, value v_dst, value v_src, value v_clip,
		value v_color, value v_uacot)
{
	rect<s32> clip;
	rect<s32>* clip_ptr;
	if(v_clip == Val_int(0)) clip_ptr = NULL;
	else {
		clip = Rect_s32_val(v_clip);
		clip_ptr = &clip;
	}
	((IVideoDriver*) v_driver)->draw2DImage((ITexture*) v_tex,
		Pos2d_s32_val(v_dst), Rect_s32_val(v_src), clip_ptr,
		SColor_val(v_color), Bool_val(v_uacot));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_draw2DImage_bytecode(
		value* argv, int argn)
{
	return ml_IVideoDriver_draw2DImage_native(argv[0], argv[1], argv[2], argv[3],
			argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_IVideoDriver_draw2DImage_scale_native(
		value v_driver, value v_tex, value v_dst, value v_src, value v_clip,
		value v_colors, value v_alpha)
{
	rect<s32> clip;
	rect<s32>* clip_ptr;
	if(v_clip == Val_int(0)) clip_ptr = NULL;
	else {
		clip = Rect_s32_val(Field(v_clip, 0));
		clip_ptr = &clip;
	}
	SColor colors[4];
	SColor* colors_ptr;
	if(v_colors == Val_int(0)) colors_ptr = NULL;
	else {
		int i;
		for(i = 0; i < 4; i++)
			colors[i] = SColor_val(Field(v_colors, i));
		colors_ptr = colors;
	}
	((IVideoDriver*) v_driver)->draw2DImage((ITexture*) v_tex,
		Rect_s32_val(v_dst), Rect_s32_val(v_src), clip_ptr, colors_ptr,
		Bool_val(v_alpha));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_draw2DImage_scale_bytecode(
		value* argv, int argn)
{
	return ml_IVideoDriver_draw2DImage_scale_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_IVideoDriver_makeColorKeyTexture1(
		value v_driver, value v_tex, value v_pos, value v_zero_texels)
{
	((IVideoDriver*) v_driver)->makeColorKeyTexture((ITexture*) v_tex,
		Pos2d_s32_val(v_pos), Bool_val(v_zero_texels));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_draw2DRectangle(
		value v_driver, value v_color, value v_pos, value v_clip)
{
	rect<s32> clip;
	rect<s32>* clip_ptr;
	if(v_clip == Val_int(0)) clip_ptr = NULL;
	else {
		clip = Rect_s32_val(Field(v_clip, 0));
		clip_ptr = &clip;
	}
	((IVideoDriver*) v_driver)->draw2DRectangle(SColor_val(v_color),
		Rect_s32_val(v_pos), clip_ptr);
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_getMaterial2D(value v_driver) {
	return (value) &((IVideoDriver*) v_driver)->getMaterial2D();
}

extern "C" CAMLprim value ml_IVideoDriver_enableMaterial2D(
		value v_driver, value v_b)
{
	((IVideoDriver*) v_driver)->enableMaterial2D(Bool_val(v_b));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_setTextureCreationFlag(
		value v_driver, value v_flag, value v_b)
{
	((IVideoDriver*) v_driver)->setTextureCreationFlag(
		texture_creation_flag_val(v_flag), Bool_val(v_b));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_setTransform(
		value v_driver, value v_state, value v_mat)
{
	((IVideoDriver*) v_driver)->setTransform(transformation_state_val(v_state),
		Matrix4_val(v_mat));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_draw3DTriangle(
		value v_driver, value v_tri, value v_color)
{
	((IVideoDriver*) v_driver)->draw3DTriangle(Triangle3df_val(v_tri),
		SColor_val(v_color));
	return Val_unit;
}

extern "C" CAMLprim value ml_IVideoDriver_setMaterial(
		value v_driver, value v_mat)
{
	SMaterial mat = *((SMaterial*) v_mat);
	((IVideoDriver*) v_driver)->setMaterial(mat);
	return Val_unit;
}
