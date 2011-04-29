/* C++ stub for the module Irr */

#include "global.h"

/* Stub for class IrrlichtDevice */

extern "C" CAMLprim value ml_createDevice_native(value v_dtype, value v_size,
		value v_bits, value v_fullscreen, value v_stencilbuffer, value v_vsync,
		value v_receiver)
{
	dimension2d<u32> size = Dimension2d_u32_val(v_size);
	IrrlichtDevice* device = createDevice(driver_type_val(v_dtype), size,
			Int_val(v_bits), Bool_val(v_fullscreen), Bool_val(v_stencilbuffer),
			Bool_val(v_vsync), (IEventReceiver*) v_receiver);
	if(device == NULL) null_pointer_exn();
 return (value) device;	
}

extern "C" CAMLprim value ml_createDevice_bytecode(value* argv, int argn) {
	return ml_createDevice_native(argv[0], argv[1], argv[2], argv[3], argv[4],
			argv[5], argv[6]);
}

extern "C" CAMLprim value ml_IrrlichtDevice_run(value v_device) {
	IrrlichtDevice* device = (IrrlichtDevice*)  v_device;
	return Val_bool(device->run());
}

extern "C" CAMLprim value ml_IrrlichtDevice_getVideoDriver(value v_device) {
	IrrlichtDevice* device = (IrrlichtDevice*) v_device;
	return (value) device->getVideoDriver();
}

extern "C" CAMLprim value ml_IrrlichtDevice_getSceneManager(value v_device) {
	IrrlichtDevice* device = (IrrlichtDevice*) v_device;
	return (value) device->getSceneManager();
}

extern "C" CAMLprim value ml_IrrlichtDevice_getCursorControl(value v_device) {
	return (value) ((IrrlichtDevice*) v_device)->getCursorControl();
}

extern "C" CAMLprim value ml_IrrlichtDevice_getGUIEnvironment(value v_device) {
	return (value) ((IrrlichtDevice*) v_device)->getGUIEnvironment();
}

extern "C" CAMLprim value ml_IrrlichtDevice_setWindowCaption(
		value v_device, value v_s)
{
	int n = strlen(String_val(v_s));
	wchar_t s[n + 1];
	mbstowcs(s, String_val(v_s), n);
	((IrrlichtDevice*) v_device)->setWindowCaption(s);
	return Val_unit;
}

extern "C" CAMLprim value ml_IrrlichtDevice_getFileSystem(value v_device) {
	return (value) ((IrrlichtDevice*) v_device)->getFileSystem();
}

extern "C" CAMLprim value ml_IrrlichtDevice_isWindowActive(value v_device) {
	return Val_bool(((IrrlichtDevice*) v_device)->isWindowActive());
}

extern "C" CAMLprim value ml_IrrlichtDevice_yield(value v_device) {
	((IrrlichtDevice*) v_device)->yield();
	return Val_unit;
}

extern "C" CAMLprim value ml_IrrlichtDevice_getTimer(value v_device) {
	return (value) ((IrrlichtDevice*) v_device)->getTimer();
}

extern "C" CAMLprim value ml_IrrlichtDevice_setEventReceiver(
		value v_device, value v_receiver)
{
	((IrrlichtDevice*) v_device)->setEventReceiver((IEventReceiver*) v_receiver);
	return Val_unit;
}

extern "C" CAMLprim value ml_IrrlichtDevice_setResizable(
    value v_device, value v_b)
{
  ((IrrlichtDevice*) v_device)->setResizable(Bool_val(v_b));
  return Val_unit;
}

extern "C" CAMLprim value ml_IrrlichtDevice_closeDevice(value v_device) {
	((IrrlichtDevice*) v_device)->closeDevice();
	return Val_unit;
}

extern "C" CAMLprim value ml_IrrlichtDevice_getColorFormat(value v_device) {
	return Val_color_format(((IrrlichtDevice*) v_device)->getColorFormat());
}

extern "C" CAMLprim value ml_IrrlichtDevice_getType(value v_device) {
	return Val_device_type(((IrrlichtDevice*) v_device)->getType());
}

