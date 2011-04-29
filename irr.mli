(* This module implements some of the namespace irr *)

type obj = Irr_base.obj

(** Class Irrlicht Device *)
class device : obj -> Irr_base.event_receiver -> object
  inherit Irr_base.reference_counted
  method close : unit
  method color_format : Irr_enums.color_format
  method cursor : Irr_gui.cursor
  method run : bool
  method driver : Irr_video.driver
  method file_system : Irr_io.file_system
  method gui_env : Irr_gui.environment
  method scene_manager : Irr_scene.manager
  method timer : Irr_base.timer
  method set_window_caption : string -> unit
  method set_event_receiver : Irr_base.event_receiver -> unit
  method set_on_event : (Irr_base.event -> bool) -> unit
  method set_resizable : bool -> unit
  method is_window_active : bool
  method yield : unit
  method get_type : Irr_enums.device_type
end 

val create_device :
  ?dtype:Irr_enums.driver_type -> ?size:(int * int) -> ?bits:int ->
    ?fullscreen:bool -> ?stencilbuffer:bool -> ?vsync:bool ->
    ?on_event:(Irr_base.event -> bool) ->
    ?receiver:Irr_base.event_receiver -> unit -> device
