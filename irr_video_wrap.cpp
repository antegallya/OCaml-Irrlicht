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

/*SMaterialLayer MaterialLayer_val(value v) {
	SMaterialLayer ml;
	ml.AnisotropicFilter = Int_val(Field(v, 0));
	ml.BilinearFilter = Bool_val(Field(v, 1));
	ml.LODBias = Int_val(Field(v, 2));
	if(Is_block(Field(v, 3)))
			ml.Texture = (ITexture*) Field(Field(v, 3), 0);
	ml.TextureWrapU = texture_clamp_val(Field(v, 4));
	ml.TextureWrapV = texture_clamp_val(Field(v, 5));
	ml.TrilinearFilter = Bool_val(Field(v, 6));
	ml.setTextureMatrix(Matrix4_val(Field(v, 7)));
	return ml;
}

value copy_MaterialLayer(SMaterialLayer ml) {
	CAMLparam0();
	CAMLlocal2(r, tmp);
	printf("Hello1");
	fflush(stdout);
	r = caml_alloc(8, 0);
	Store_field(r, 0, Val_int(ml.AnisotropicFilter));
	Store_field(r, 1, Val_bool(ml.BilinearFilter));
	Store_field(r, 2, Val_int(ml.LODBias));
	if(ml.Texture == NULL) tmp = Val_int(0);
	else {
		tmp = caml_alloc(1, 0);
		Store_field(tmp, 0, (value) ml.Texture);
	}
	Store_field(r, 3, tmp);
	Store_field(r, 4, Val_texture_clamp((E_TEXTURE_CLAMP) ml.TextureWrapU));
	Store_field(r, 5, Val_texture_clamp((E_TEXTURE_CLAMP) ml.TextureWrapV));
	Store_field(r, 6, Val_bool(ml.TrilinearFilter));
	Store_field(r, 7, copy_matrix4(ml.getTextureMatrix()));
	printf("Hello2");
	fflush(stdout);
	CAMLreturn(r);
}*/

extern "C" CAMLprim value ml_SMaterialLayer_set_BilinearFilter(
		value v_layer, value v_b)
{
	((SMaterialLayer*) v_layer)->BilinearFilter = Bool_val(v_b);
	return Val_unit;
}

/* Stub for SMaterial class */

/*SMaterial Material_val(value v) {
	SMaterial m;
	int i;
	m.AmbientColor = SColor_val(Field(v, 0));
	m.AntiAliasing = anti_aliasing_mode_val(Field(v, 1));
	m.BackfaceCulling = Bool_val(Field(v, 2));
	m.ColorMask = color_plane_val(Field(v, 3));
	m.ColorMaterial = colormaterial_val(Field(v, 4));
	m.DiffuseColor = SColor_val(Field(v, 5));
	m.EmissiveColor = SColor_val(Field(v, 6));
	m.FogEnable = Bool_val(Field(v, 7));
	m.FrontfaceCulling = Bool_val(Field(v, 8));
	m.GouraudShading = Bool_val(Field(v, 9));
	m.Lighting = Bool_val(Field(v, 10));
	m.MaterialType = material_type_val(Field(v, 11));
	m.MaterialTypeParam = Double_val(Field(v, 12));
	m.MaterialTypeParam2 = Double_val(Field(v, 13));
	m.NormalizeNormals = Bool_val(Field(v, 14));
	m.PointCloud = Bool_val(Field(v, 15));
	m.Shininess = Double_val(Field(v, 16));
	m.SpecularColor = SColor_val(Field(v, 17));
	for(i = 0; i < Wosize_val(Field(v, 18)); i++) {
		m.TextureLayer[i] = MaterialLayer_val(Field(Field(v, 18), i));
	}
	m.Thickness = Double_val(Field(v, 19));
	m.Wireframe = Bool_val(Field(v, 20));
	m.ZBuffer = comparison_func_val(Field(v, 21));
	m.ZWriteEnable = Bool_val(Field(v, 22));
	return m;
}

value copy_material(SMaterial m) {
	CAMLparam0();
	CAMLlocal3(v, tmp, tmp2);
	int i;
	v = caml_alloc(23, 0);
	Store_field(v, 0, copy_SColor(m.AmbientColor));
	Store_field(v, 1, Val_anti_aliasing_mode(m.AntiAliasing));
	Store_field(v, 2, Val_bool(m.BackfaceCulling));
	Store_field(v, 3, Val_color_plane(m.ColorMask));
	Store_field(v, 4, Val_colormaterial(m.ColorMaterial));
	Store_field(v, 5, copy_SColor(m.DiffuseColor));
	Store_field(v, 6, copy_SColor(m.EmissiveColor));
	Store_field(v, 7, Val_bool(m.FogEnable));
	Store_field(v, 8, Val_bool(m.FrontfaceCulling));
	Store_field(v, 9, Val_bool(m.GouraudShading));
	Store_field(v, 10, Val_bool(m.Lighting));
	Store_field(v, 11, Val_material_type(m.MaterialType));
	Store_field(v, 12, copy_double(m.MaterialTypeParam));
	Store_field(v, 13, copy_double(m.MaterialTypeParam2));
	Store_field(v, 14, Val_bool(m.NormalizeNormals));
	Store_field(v, 15, Val_bool(m.PointCloud));
	Store_field(v, 16, copy_double(m.Shininess));
	Store_field(v, 17, copy_SColor(m.SpecularColor));
	tmp = caml_alloc(MATERIAL_MAX_TEXTURES, 0);
	printf("Hello3 %d\n", (int) Wosize_val(tmp));
	printf("%d\n", (int) Wosize_val(tmp));
	fflush(stdout);
	for(i = 0; i < MATERIAL_MAX_TEXTURES; i++) {
		printf(">> %d\n", (int) Wosize_val(tmp));
		fflush(stdout);
		tmp2 = copy_MaterialLayer(m.TextureLayer[i]);
		printf("== %d\n", (int) Wosize_val(tmp));
		fflush(stdout);
		Store_field(tmp, i, tmp2);
		printf("<< %d\n", (int) Wosize_val(tmp));
		fflush(stdout);
	}
	Field(tmp, 0);
	printf("Hello4 %d %d\n", MATERIAL_MAX_TEXTURES, (int) Wosize_val(tmp));
	fflush(stdout);
	Store_field(v, 18, tmp);
	Store_field(v, 19, copy_double(m.Thickness));
	Store_field(v, 20, Val_bool(m.Wireframe));
	Store_field(v, 21, Val_comparison_func(m.ZBuffer));
	Store_field(v, 22, Val_bool(m.ZWriteEnable));
	CAMLreturn(v);
}*/

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
