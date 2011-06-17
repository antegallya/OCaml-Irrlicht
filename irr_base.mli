(** This module implements some of the namespace irr *)

(** Abstract type for a valid C/C++ pointer. Not for common users *)
type obj

(** Exception raised when a NUL pointer try to be converted to a CAML value *)
exception Null_pointer_exn

(** Class IReferenceCounted *)
class reference_counted : obj -> object
  method obj : obj
  method drop_bool : bool
  method drop : unit
end

(** Class ITimer *)
class timer : obj -> object
  inherit reference_counted
  method time : int
end

(** Class IAttributeExchangingObject *)
class attribute_exchanging_object : obj -> object
  inherit reference_counted
end

(** Class SKeyInput *)
type key_input = {
  ki_char : char;
  ki_control : bool;
  ki_key : Irr_enums.key_code;
  ki_pressed_down : bool;
  ki_shift : bool;
}

val key_count : int

val int_of_key : Irr_enums.key_code -> int

(** Class SMouseInput *)
type mouse_input = {
  mi_left_pressed : bool;
  mi_middle_pressed : bool;
  mi_right_pressed : bool;
  mi_control : bool;
  mi_event : Irr_enums.mouse_input_event;
  mi_shift : bool;
  mi_weel : float;
  mi_x : int;
  mi_y : int;
}

(** Class SGUIEvent *)
type gui_event = {
  ge_caller : int;
  ge_element : int;
  ge_type : Irr_enums.gui_event_type
}

(** Class SEvent *)
type event = [
| `key_input of key_input
| `mouse_input of mouse_input
| `other]

(** Class SKeyMap *)
type key_map = Irr_enums.key_action * Irr_enums.key_code

(** Class IEventReceiver *)
class event_receiver : obj -> object
  method obj : obj
  (*method on_event : unit*)
end

class event_receiver_fun : (event -> bool) -> object
  inherit event_receiver
end
