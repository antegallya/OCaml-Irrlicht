type obj = Irr_base.obj

(******************************************************************************)

(* Binding for class ICursorControl *)

(******************************************************************************)

external cursor_get_position : obj -> int Irr_core.pos_2d =
  "ml_ICursorControl_getPosition"

external cursor_set_visible : obj -> bool -> unit =
  "ml_ICursorControl_setVisible"

class cursor obj = object(self)
  inherit Irr_base.reference_counted obj
  method pos = cursor_get_position self#obj
  method set_visible b = cursor_set_visible self#obj b
end

(******************************************************************************)

(* Binding for class IGUIFont *)

(******************************************************************************)

external font_draw :
  obj -> string -> int Irr_core.rect -> Irr_core.color -> bool -> bool ->
    (int Irr_core.rect) option -> unit =
      "ml_IGUIFont_draw_bytecode"
      "ml_IGUIFont_draw_native"

class font obj = object(self)
  inherit Irr_base.reference_counted obj
  method draw text pos ?(hcenter = false) ?(vcenter = false) ?clip color =
    font_draw self#obj text pos color hcenter vcenter clip
end

(******************************************************************************)

(* Binding for class IGUIElement *)

(******************************************************************************)

class element obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  inherit Irr_base.event_receiver obj
end

(******************************************************************************)

(* Binding for class IGUIStaticText *)

(******************************************************************************)

external static_text_set_override_color : obj -> Irr_core.color -> unit =
  "ml_IGUIStaticText_setOverrideColor"

class static_text obj = object(self)
  inherit element obj
  method set_override_color c = static_text_set_override_color self#obj c
end

(******************************************************************************)

(* Binding for class IGUIImage *)

(******************************************************************************)

class image obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUISkin *)

(******************************************************************************)

external skin_set_font : obj -> obj -> Irr_enums.gui_default_font -> unit =
  "ml_IGUISkin_setFont"

class skin obj = object(self)
  inherit Irr_base.attribute_exchanging_object obj
  method set_font ?(which = `default) (font : font) =
    skin_set_font self#obj font#obj which
end

(******************************************************************************)

(* Binding for class IGUIButton *)

(******************************************************************************)

class button obj = object(self)
  inherit element obj
end

(******************************************************************************)

(* Binding for class IGUIEnvironment *)

(******************************************************************************)

external environment_add_image :
  obj -> obj -> int Irr_core.pos_2d -> bool -> obj option -> int ->
    string option -> obj =
      "ml_IGUIEnvironment_addImage_bytecode"
      "ml_IGUIEnvironment_addImage_native"

external environment_add_static_text :
  obj -> string -> int Irr_core.rect -> bool -> bool -> obj option -> int ->
    bool -> obj =
      "ml_IGUIEnvironment_addStaticText_bytecode"
      "ml_IGUIEnvironment_addStaticText_native"

external environment_draw_all : obj -> unit =
  "ml_IGUIEnvironment_drawAll"

external environment_get_built_in_font : obj -> obj =
  "ml_IGUIEnvironment_getBuiltInFont"

external environment_get_font : obj -> string -> obj =
  "ml_IGUIEnvironment_getFont"

external environment_get_skin : obj -> obj =
  "ml_IGUIEnvironment_getSkin"

class environment obj = object(self)
  inherit Irr_base.reference_counted obj
  method built_in_font =
    let obj = environment_get_built_in_font self#obj in
    object
      val env = self
      inherit font obj
    end
  method font filename =
    let obj = environment_get_font self#obj filename in
    object
      val env = self
      inherit font obj
    end
  method skin =
    let obj = environment_get_skin self#obj in
    object
      val env = self
      inherit skin obj
    end
  method add_image (image : Irr_video.texture) ?(use_alpha = true) ?parent
    ?(id = -1) ?text pos =
    let p = match parent with
    | None -> None
    | Some (x : element) -> Some x#obj in
    let obj =
      environment_add_image self#obj image#obj pos use_alpha p id text in
    object
      val env = self
      inherit image obj
    end
  method add_static_text text ?(border = false) ?(word_warp = true) ?parent
    ?(id = -1) ?(fill_bg = false) rect =
    let p = match parent with
    | None -> None
    | Some (x : element) -> Some x#obj in
    let obj =
      environment_add_static_text self#obj text rect border word_warp p id
      fill_bg in
    object
      val env = self
      inherit static_text obj
    end
  method draw_all = environment_draw_all self#obj
end
