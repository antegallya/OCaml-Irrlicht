#include "global.h"

/* Stub for class ICursorControl */

extern "C" CAMLprim value ml_ICursorControl_getPosition(value v_cursor) {
	return copy_pos2d_s32(((ICursorControl*) v_cursor)->getPosition());
}

extern "C" CAMLprim value ml_ICursorControl_setVisible(
		value v_cursor, value v_b)
{
	((ICursorControl*) v_cursor)->setVisible(Bool_val(v_b));
	return Val_unit;
}

/* Stub for class IGUIFont */

extern "C" CAMLprim value ml_IGUIFont_draw_native(
		value v_font, value v_text, value v_pos, value v_color, value v_hcenter,
		value v_vcenter, value v_clip)
{
	int text_size = caml_string_length(v_text);
	wchar_t text[2 * (text_size + 1)];
	mbstowcs(text, String_val(v_text), 2 * text_size);
	rect<s32> clip;
	rect<s32>* clip_ptr;
	if(v_clip == Val_int(0)) clip_ptr = NULL;
	else {
		clip = Rect_s32_val(Field(v_clip, 0));
		clip_ptr = &clip;
	}
	((IGUIFont*) v_font)->draw(text, Rect_s32_val(v_pos), SColor_val(v_color),
		Bool_val(v_hcenter), Bool_val(v_vcenter), clip_ptr);
	return Val_unit;
}

extern "C" value ml_IGUIFont_draw_bytecode(value* argv, int argn) {
	return ml_IGUIFont_draw_native(argv[0], argv[1], argv[2], argv[3], argv[4],
			argv[5], argv[6]);
}

/* Stub for class IGUIStaticText */

extern "C" value ml_IGUIStaticText_setOverrideColor(value v_text, value v_color)
{
	((IGUIStaticText*) v_text)->setOverrideColor(SColor_val(v_color));
	return Val_unit;
}

/* Stub for class IGUISkin */

extern "C" value ml_IGUISkin_setFont(
		value v_skin, value v_font, value v_which)
{
	((IGUISkin*) v_skin)->setFont((IGUIFont*) v_font,
		gui_default_font_val(v_which));
	return Val_unit;
}

/* Stub for class IGUIEnvironment */

extern "C" value ml_IGUIEnvironment_getBuiltInFont(value v_env) {
	return (value) ((IGUIEnvironment*) v_env)->getBuiltInFont();
}

extern "C" value ml_IGUIEnvironment_getFont(value v_env, value v_filename) {
	IGUIFont* font = ((IGUIEnvironment*) v_env)->getFont(String_val(v_filename));
	if(font == NULL) null_pointer_exn();
	return (value) font;
}

extern "C" value ml_IGUIEnvironment_addImage_native(
		value v_env, value v_image, value v_pos, value v_use_alpha, value v_parent,
		value v_id, value v_text)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int text_size;
	if(v_text == Val_int(0)) text_size = 0;
	else text_size = caml_string_length(Field(v_text, 0));
	wchar_t text_wc[text_size + 1];
	wchar_t* text;
	if(v_text == Val_int(0))
		text = NULL;
	else {
		mbstowcs(text_wc, String_val(Field(v_text, 0)), text_size);
		text = text_wc;
	}
	IGUIImage* gui_image = ((IGUIEnvironment*) v_env)->addImage(
			(ITexture*) v_image, Pos2d_s32_val(v_pos), Bool_val(v_use_alpha),
			parent, Int_val(v_id), text);
	if(gui_image == NULL) null_pointer_exn();
	return (value) gui_image;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addImage_bytecode(
		value* argv, int argn)
{
	return ml_IGUIEnvironment_addImage_native(argv[0], argv[1], argv[2], argv[3],
			argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_IGUIEnvironment_addStaticText_native(
		value v_env, value v_text, value v_rect, value v_border, value v_word_warp,
		value v_parent, value v_id, value v_fill_bg)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int text_size = strlen(String_val(v_text));
	wchar_t text[text_size + 1];
	mbstowcs(text, String_val(v_text), text_size + 1);
	return (value) ((IGUIEnvironment*) v_env)->addStaticText(text,
			Rect_s32_val(v_rect), Bool_val(v_border), Bool_val(v_word_warp), parent,
			Int_val(v_id), Bool_val(v_fill_bg));
}

extern "C" CAMLprim value ml_IGUIEnvironment_addStaticText_bytecode(
		value* argv, int argn)
{
	return ml_IGUIEnvironment_addStaticText_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6], argv[7]);
}

extern "C" CAMLprim value ml_IGUIEnvironment_drawAll(value v_env) {
	((IGUIEnvironment*) v_env)->drawAll();
	return Val_unit;
}

extern "C" CAMLprim value ml_IGUIEnvironment_getSkin(value v_env) {
	return (value) ((IGUIEnvironment*) v_env)->getSkin();
}

