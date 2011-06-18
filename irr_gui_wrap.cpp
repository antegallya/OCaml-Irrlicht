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

/* Stub for class IGUIScrollBar */

extern "C" value ml_IGUIScrollBar_setMax(value v_sb, value v_n) {
	((IGUIScrollBar*) v_sb)->setMax(Int_val(v_n));
	return Val_unit;
}

extern "C" value ml_IGUIScrollBar_setPos(value v_sb, value v_n) {
	((IGUIScrollBar*) v_sb)->setPos(Int_val(v_n));
	return Val_unit;
}

/* Stub for class IGUIListBox */

extern "C" value ml_IGUIListBox_addItem(value v_lb, value v_text, value v_icon) {
	int text_size = strlen(String_val(v_text));
	wchar_t text[text_size + 1];
	mbstowcs(text, String_val(v_text), text_size + 1);
	return Val_int(((IGUIListBox*) v_lb)->addItem(text, Int_val(v_icon)));
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

extern "C" CAMLprim value ml_IGUIEnvironment_addButton_native(
		value v_env, value v_rect, value v_parent, value v_id, value v_text,
		value v_tooltiptext)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int text_size, tooltiptext_size;
	if(v_text == Val_int(0)) text_size = 0;
	else text_size = strlen(String_val(Field(v_text, 0)));
	if(v_tooltiptext == Val_int(0)) tooltiptext_size = 0;
	else tooltiptext_size = strlen(String_val(Field(v_tooltiptext, 0)));
	wchar_t text_data[text_size + 1], tooltiptext_data[tooltiptext_size + 1];
	wchar_t *text, *tooltiptext;
	if(v_text == Val_int(0)) text = NULL;
	else {
		mbstowcs(text_data, String_val(Field(v_text, 0)), text_size + 1);
		text = text_data;
	}
	if(v_tooltiptext == Val_int(0)) tooltiptext = NULL;
	else {
		mbstowcs(tooltiptext_data, String_val(Field(v_tooltiptext, 0)),
				tooltiptext_size + 1);
		tooltiptext = tooltiptext_data;
	}
	IGUIButton* button = ((IGUIEnvironment*) v_env)->addButton(
			Rect_s32_val(v_rect), parent, Int_val(v_id), text, tooltiptext);
	if(button == NULL) null_pointer_exn();
	return (value) button;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addButton_bytecode(
		value* argv, int argn) {
	return ml_IGUIEnvironment_addButton_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5]);
}

extern "C" CAMLprim value ml_IGUIEnvironment_addScrollBar(
		value v_env, value v_h, value v_rect, value v_parent, value v_id)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	IGUIScrollBar* sb = ((IGUIEnvironment*) v_env)->addScrollBar(Bool_val(v_h),
			Rect_s32_val(v_rect), parent, Int_val(v_id));
	if(sb == NULL) null_pointer_exn();
	return (value) sb;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addListBox(
		value v_env, value v_rect, value v_parent, value v_id, value v_dbg)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	IGUIListBox* lb = ((IGUIEnvironment*) v_env)->addListBox(Rect_s32_val(v_rect),
			parent, Int_val(v_id), Bool_val(v_dbg));
	if(lb == NULL) null_pointer_exn();
	return (value) lb;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addEditBox_native(
		value v_env, value v_text, value v_rect, value v_border, value v_parent,
		value v_id)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int text_size = strlen(String_val(v_text));
	wchar_t text[text_size + 1];
	mbstowcs(text, String_val(v_text), text_size + 1);
	IGUIEditBox* eb = ((IGUIEnvironment*) v_env)->addEditBox(text,
			Rect_s32_val(v_rect), Bool_val(v_border), parent, Int_val(v_id));
	if(eb == NULL) null_pointer_exn();
	return (value) eb;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addEditBox_bytecode(
		value* argv, int argn)
{
	return ml_IGUIEnvironment_addEditBox_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5]);
}

extern "C" CAMLprim value ml_IGUIEnvironment_addWindow_native(
		value v_env, value v_rect, value v_modal, value v_text, value v_parent,
		value v_id)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int text_size;
	if(v_text == Val_int(0)) text_size = 0;
	else text_size = strlen(String_val(Field(v_text, 0)));
	wchar_t text_data[text_size + 1];
	wchar_t* text;
	if(v_text == Val_int(0)) text = NULL;
	else {
		mbstowcs(text_data, String_val(Field(v_text, 0)), text_size + 1);
		text = text_data;
	}
	IGUIWindow* window = ((IGUIEnvironment*) v_env)->addWindow(
			Rect_s32_val(v_rect), Bool_val(v_modal), text, parent, Int_val(v_id));
	if(window == NULL) null_pointer_exn();
	return (value) window;
}

extern "C" CAMLprim value ml_IGUIEnvironment_addWindow_bytecode(
		value* argv, int argn)
{
	return ml_IGUIEnvironment_addWindow_native(argv[0], argv[1], argv[2], argv[3],
			argv[4], argv[5]);
}

extern "C" CAMLprim value ml_IGUIEnvironment_addFileOpenDialog(
		value v_env, value v_title, value v_modal, value v_parent, value v_id)
{
	IGUIElement* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IGUIElement*) Field(v_parent, 0);
	int title_size;
	if(v_title == Val_int(0)) title_size = 0;
	else title_size = strlen(String_val(Field(v_title, 0)));
	wchar_t title_data[title_size + 1];
	wchar_t* title;
	if(v_title == Val_int(0)) title = NULL;
	else {
		mbstowcs(title_data, String_val(Field(v_title, 0)), title_size + 1);
		title = title_data;
	}
	IGUIFileOpenDialog* fod = ((IGUIEnvironment*) v_env)->addFileOpenDialog(
			title, Bool_val(v_modal), parent, Int_val(v_id));
	if(fod == NULL) null_pointer_exn();
	return (value) fod;
}

