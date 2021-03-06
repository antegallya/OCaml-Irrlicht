(** This module implements some part of irr::gui *)

type obj = Irr_base.obj

(** Class ICursorControl *)
class cursor : obj -> object
  inherit Irr_base.reference_counted
  method pos : int Irr_core.pos_2d
  method rel_pos : float Irr_core.pos_2d
  method set_visible : bool -> unit
end

(** Class IGUIFont *)
class font : obj -> object
  inherit Irr_base.reference_counted
  method draw : string -> int Irr_core.rect -> ?hcenter:bool -> ?vcenter:bool ->
    ?clip:int Irr_core.rect -> int Irr_core.color -> unit
end

(** Class IGUIElement *)
class element : obj -> object
  inherit Irr_base.attribute_exchanging_object
  inherit Irr_base.event_receiver
end

(** Class IGUIStaticText *)
class static_text : obj -> object
  inherit element
  method set_override_color : int Irr_core.color -> unit
end

(** Class IGUIImage *)
class image : obj -> object
  inherit element
end

(** Class IGUISkin *)
class skin : obj -> object
  inherit Irr_base.attribute_exchanging_object
  method set_font : ?which:Irr_enums.gui_default_font -> font -> unit
  method color : Irr_enums.gui_default_color -> int Irr_core.color
  method set_color : Irr_enums.gui_default_color -> int Irr_core.color -> unit
end

val default_color_count : int

val default_color_of_int : int -> Irr_enums.gui_default_color

(** Class IGUIButton *)
class button : obj -> object
  inherit element
end

(** Class IGUIContextMenu *)
class context_menu : obj -> object
  inherit element
  method add_item : ?command_id:int -> ?enabled:bool -> ?has_submenu:bool ->
    ?checked:bool -> ?auto_checking:bool -> string -> int
  method add_separator : unit
  method set_close_handling : Irr_enums.context_menu_close -> unit
end

(** Class IGUIScrollBar *)
class scroll_bar : obj -> object
  inherit element
  method set_max : int -> unit
  method set_pos : int -> unit
  method pos : int
end

(** Class IGUIListBox *)
class list_box : obj -> object
  inherit element
  method add_item : ?icon:int -> string -> int
end

(** Class IGUIEditBox *)
class edit_box : obj -> object
  inherit element
end

(** Class IGUIWindow *)
class window : obj -> object
  inherit element
end

(** Class IGUIFileOpenDialog *)
class file_open_dialog : obj -> object
  inherit element
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
  method add_static_text : string -> ?border:bool -> ?word_wrap:bool ->
    ?parent:element -> ?id:int -> ?fill_bg:bool -> int Irr_core.rect ->
    static_text
  method add_button :
    ?parent:element -> ?id:int -> ?text:string -> ?tooltiptext:string ->
      int Irr_core.rect -> button
  method add_menu :
    ?parent:element -> ?id:int -> unit -> context_menu
  method add_scroll_bar :
    bool -> ?parent:element -> ?id:int -> int Irr_core.rect -> scroll_bar
  method add_list_box :
    ?parent:element -> ?id:int -> ?draw_bg:bool -> int Irr_core.rect -> list_box
  method add_edit_box :
    string -> ?border:bool -> ?parent:element -> ?id:int -> int Irr_core.rect ->
      edit_box
  method add_window :
    ?modal:bool -> ?text:string -> ?parent:element -> ?id:int ->
      int Irr_core.rect -> window
  method add_file_open_dialog :
    ?title:string -> ?modal:bool -> ?parent:element -> ?id:int -> unit ->
      file_open_dialog
  method draw_all : unit
end
