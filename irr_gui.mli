(** This module implements some part of irr::gui *)

type obj = Irr_base.obj

(** Class ICursorControl *)
class cursor : obj -> object
  inherit Irr_base.reference_counted
  method pos : int Irr_core.pos_2d
  method set_visible : bool -> unit
end

(** Class IGUIFont *)
class font : obj -> object
  inherit Irr_base.reference_counted
  method draw : string -> int Irr_core.rect -> ?hcenter:bool -> ?vcenter:bool ->
    ?clip:int Irr_core.rect -> Irr_core.color -> unit
end

(** Class IGUIElement *)
class element : obj -> object
  inherit Irr_base.attribute_exchanging_object
  inherit Irr_base.event_receiver
end

(** Class IGUIStaticText *)
class static_text : obj -> object
  inherit element
  method set_override_color : Irr_core.color -> unit
end

(** Class IGUIImage *)
class image : obj -> object
  inherit element
end

(** Class IGUISkin *)
class skin : obj -> object
  inherit Irr_base.attribute_exchanging_object
  method set_font : ?which:Irr_enums.gui_default_font -> font -> unit
end

(** Class IGUIEnvironment *)
class environment : obj -> object
  inherit Irr_base.reference_counted
  method built_in_font : font
  method font : string -> font
  method skin : skin
  method add_image :
    Irr_video.texture -> ?use_alpha:bool -> ?parent:element -> ?id:int ->
      ?text:string -> int Irr_core.pos_2d -> image
  method add_static_text : string -> ?border:bool -> ?word_warp:bool ->
    ?parent:element -> ?id:int -> ?fill_bg:bool -> int Irr_core.rect ->
    static_text
  method draw_all : unit
end