type obj = Irr_base.obj

(******************************************************************************)

(* Binding of class IrrlichtDevice *)

(******************************************************************************)

external create_device : Irr_enums.driver_type -> int Irr_core.dimension_2d ->
  int -> bool -> bool -> bool -> obj -> obj
  = "ml_createDevice_bytecode" "ml_createDevice_native"

external device_run : obj -> bool = "ml_IrrlichtDevice_run"

external device_get_cursor_control : obj -> obj =
  "ml_IrrlichtDevice_getCursorControl"

external device_get_gui_environment : obj -> obj =
  "ml_IrrlichtDevice_getGUIEnvironment"

external device_get_video_driver : obj -> obj =
  "ml_IrrlichtDevice_getVideoDriver"

external device_get_scene_manager : obj -> obj =
  "ml_IrrlichtDevice_getSceneManager"

external device_get_timer : obj -> obj = "ml_IrrlichtDevice_getTimer"

external device_set_window_caption : obj -> string -> unit =
  "ml_IrrlichtDevice_setWindowCaption"

external device_get_file_system : obj -> obj =
  "ml_IrrlichtDevice_getFileSystem"

external device_set_event_receiver : obj -> obj -> unit =
  "ml_IrrlichtDevice_setEventReceiver"

external device_is_window_active : obj -> bool =
  "ml_IrrlichtDevice_isWindowActive"

external device_yield : obj -> unit = "ml_IrrlichtDevice_yield"

external device_set_resizable : obj -> bool -> unit =
  "ml_IrrlichtDevice_setResizable"

external device_close_device : obj -> unit = "ml_IrrlichtDevice_closeDevice"

external device_get_color_format : obj -> Irr_enums.color_format =
  "ml_IrrlichtDevice_getColorFormat"

let free x = () (*(print_endline "big free"; x#drop; print_endline "big free
done")*)

class device obj er =
  object(self)
    val mutable er = er
    inherit Irr_base.reference_counted obj
    method close = device_close_device self#obj
    method color_format = device_get_color_format self#obj
    method run = device_run self#obj
    method cursor =
      let obj = device_get_cursor_control self#obj in
      object
        val device = self
        inherit Irr_gui.cursor obj
      end
    method driver =
      let driver_obj = device_get_video_driver self#obj in
      object
        inherit Irr_video.driver driver_obj 
        val device = self
      end
    method file_system =
      let obj = device_get_file_system self#obj in
      object
        val device = self
        inherit Irr_io.file_system obj
      end
    method gui_env =
      let obj = device_get_gui_environment self#obj in
      object
        val device = self
        inherit Irr_gui.environment obj
      end
    method scene_manager =
      let manager_obj = device_get_scene_manager self#obj in
      object
        inherit Irr_scene.manager manager_obj
        val device = self
      end
    method timer =
      let obj = device_get_timer self#obj in
      object
        val device = self
        inherit Irr_base.timer obj
      end
    method set_window_caption s = device_set_window_caption self#obj s
    method set_event_receiver (r : Irr_base.event_receiver) =
      device_set_event_receiver self#obj r#obj;
      er <- r
    method set_on_event f =
      self#set_event_receiver (new Irr_base.event_receiver_fun f)
    method set_resizable b = device_set_resizable self#obj b
    method is_window_active = device_is_window_active self#obj
    method yield = device_yield self#obj
  end

let create_device ?(dtype = `software) ?(size = (640, 480)) ?(bits = 16)
  ?(fullscreen = false) ?(stencilbuffer = false) ?(vsync = false)
  ?(on_event = fun _ -> false)
  ?(receiver = new Irr_base.event_receiver_fun on_event) () =
  let obj =
    create_device dtype size bits fullscreen stencilbuffer vsync receiver#obj in
  object(self)
    inherit device obj receiver
    initializer Gc.finalise free self
  end
