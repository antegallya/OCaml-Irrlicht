/* C++ stub for the module Irr_base */

#include "irr_base_wrap.h"

using namespace irr;

extern "C" CAMLprim value ml_get_key_count(value unit) {
	return Val_int(KEY_KEY_CODES_COUNT);
}

extern "C" CAMLprim value ml_int_of_key(value v_key) {
	return Val_int(key_code_val(v_key));
}

/* Stub for class IReference_counted */

extern "C" CAMLprim value ml_IReferenceCounted_drop(value v) {
	IReferenceCounted* rc = (IReferenceCounted*) v;
	return Val_bool(rc->drop());
}

/* Stub for class IAttributeExchanginObject */

extern "C" CAMLprim value ml_IAttributeExchangingObject_drop(value v) {
	IAttributeExchangingObject* rc = (IAttributeExchangingObject*) v;
	return Val_bool(rc->drop());
}

/* Stub for class ITimer */

extern "C" CAMLprim value ml_ITimer_getTime(value v_timer) {
	return Val_int(((ITimer*) v_timer)->getTime());
}

/* Stub for class SKeyInput */

value copy_SKeyInput(SEvent::SKeyInput ki) {
	value v;
	v = caml_alloc(5, 0);
	Store_field(v, 0, Val_int(ki.Char));
	Store_field(v, 1, Val_bool(ki.Control));
	Store_field(v, 2, Val_key_code(ki.Key));
	Store_field(v, 3, Val_bool(ki.PressedDown));
	Store_field(v, 4, Val_bool(ki.Shift));
	return v;
}

SEvent::SKeyInput SKeyInput_val(value v) {
	SEvent::SKeyInput ki;
	ki.Char = Int_val(Field(v, 0));
	ki.Control = Bool_val(Field(v, 1));
	ki.Key = key_code_val(Field(v, 2));
	ki.PressedDown = Bool_val(Field(v, 3));
	ki.Shift = Bool_val(Field(v, 4));
	return ki;
}

/* Stub for class SMouseEvent */

value copy_SMouseInput(SEvent::SMouseInput mi) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(9, 0);
	Store_field(v, 0, Val_bool(mi.isLeftPressed()));
	Store_field(v, 1, Val_bool(mi.isMiddlePressed()));
	Store_field(v, 2, Val_bool(mi.isRightPressed()));
	Store_field(v, 3, Val_bool(mi.Control));
	Store_field(v, 4, Val_mouse_input_event(mi.Event));
	Store_field(v, 5, Val_bool(mi.Shift));
	Store_field(v, 6, copy_double(mi.Wheel));
	Store_field(v, 7, Val_int(mi.X));
	Store_field(v, 8, Val_int(mi.Y));
	CAMLreturn(v);
}

/* Stub for class SGUIEvent */

value copy_SGUIEvent(SEvent::SGUIEvent ge) {
	CAMLparam0();
	CAMLlocal1(v);
	v = caml_alloc(3, 0);
	Store_field(v, 0, Val_int(ge.Caller->getID()));
	if(ge.Element == NULL) Store_field(v, 1, Val_int(0));
	else Store_field(v, 1, copy_Some(Val_int(ge.Element->getID())));
	Store_field(v, 2, Val_gui_event_type(ge.EventType));
	CAMLreturn(v);
}

/* Stub for class SEvent */

value copy_SEvent(SEvent e) {
	CAMLparam0();
	CAMLlocal1(v);
	switch(e.EventType) {
		case EET_KEY_INPUT_EVENT :
			v = caml_alloc(2, 0);
			Store_field(v, 0, Val_key_input);
			Store_field(v, 1, copy_SKeyInput(e.KeyInput));
			break;
		case EET_MOUSE_INPUT_EVENT :
			v = caml_alloc(2, 0);
			Store_field(v, 0, Val_mouse_input);
			Store_field(v, 1, copy_SMouseInput(e.MouseInput));
			break;
	  case EET_GUI_EVENT:
			v = caml_alloc(2, 0);
			Store_field(v, 0, Val_gui_event);
			Store_field(v, 1, copy_SGUIEvent(e.GUIEvent));
			break;
		default:
			v = Val_other;
	}
	CAMLreturn(v);
}

SEvent SEvent_val(value v) {
	SEvent e;
	if(v == Val_other) caml_failwith("SEvent_val");
	switch(Field(v, 0)) {
		case Val_key_input :
			e.EventType = EET_KEY_INPUT_EVENT;
			e.KeyInput = SKeyInput_val(Field(v, 1));
			break;
		default:
			caml_failwith("SEvent_val");
	}
	return e;
}

/* Stub for class IEventReceiver */

class CAML_IEventReceiver : public IEventReceiver {
	private:
		value v_on_event;
	public:
		CAML_IEventReceiver(value v) {
			v_on_event = v;
			caml_register_generational_global_root(&v_on_event);
		}
		bool OnEvent(const SEvent &event) {
			return Bool_val(caml_callback(v_on_event, copy_SEvent(event)));
		}
		~CAML_IEventReceiver() {
			caml_remove_generational_global_root(&v_on_event);
		}
};

extern "C" CAMLprim value ml_CAML_IEventReceiver_create(value v) {
	CAML_IEventReceiver* er = new CAML_IEventReceiver(v);
	if(er == NULL) null_pointer_exn();
	return (value) er;
}

extern "C" CAMLprim value ml_CAML_IEventReceiver_destroy(value v) {
	CAML_IEventReceiver* er = (CAML_IEventReceiver*) v;
	delete er;
	return Val_unit;
}

