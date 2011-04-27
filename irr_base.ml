type obj

exception Null_pointer_exn

let () = Callback.register_exception "Null_pointer_exn" Null_pointer_exn

(** Some structures from Irrlicht *)

type key_input = {
  ki_char : char;
  ki_control : bool;
  ki_key : Irr_enums.key_code;
  ki_pressed_down : bool;
  ki_shift : bool
}

type mouse_input = {
  mi_left_pressed : bool;
  mi_middle_pressed : bool;
  mi_right_pressed : bool;
  mi_control : bool;
  mi_event : Irr_enums.mouse_input_event;
  mi_shift : bool;
  mi_weel : float;
  mi_x : int;
  mi_y : int
}

type event = [
| `key_input of key_input
| `mouse_input of mouse_input
| `other]

type key_map = Irr_enums.key_action * Irr_enums.key_code

external get_key_count : unit -> int = "ml_get_key_count"

let key_count = get_key_count ()

external int_of_key : Irr_enums.key_code -> int = "ml_int_of_key"

(******************************************************************************)

(* Binding of IReferenceCounted class *)

(******************************************************************************)

(* C/C++ interface *)

external reference_counted_drop : obj -> bool = "ml_IReferenceCounted_drop"

(* Ocaml class *)

class reference_counted obj = object(self)
  val obj = obj
  method obj = obj
  method drop_bool = reference_counted_drop self#obj
  method drop = ignore self#drop_bool
end

(******************************************************************************)

(* Binding for class ITime *)

(******************************************************************************)

external timer_get_time : obj -> int = "ml_ITimer_getTime"

class timer obj = object(self)
  inherit reference_counted obj
  method time = timer_get_time self#obj
end

(******************************************************************************)

(* Binding for class IAttributeExchangingObject *)

(******************************************************************************)

external attribute_exchanging_object_drop : obj -> bool =
  "ml_IAttributeExchangingObject_drop"

class attribute_exchanging_object obj = object(self)
  inherit reference_counted obj
  method drop_bool = attribute_exchanging_object_drop self#obj
end

(******************************************************************************)

(* Binding of IEventReceiver *)

(******************************************************************************)

(* C/C++ interface *)

external event_receiver_create : (event -> bool) -> obj =
  "ml_CAML_IEventReceiver_create"

external event_receiver_destroy : obj -> unit =
  "ml_CAML_IEventReceiver_destroy"

(*external event_receiver_on_event : obj -> unit = "ml_IEventReceiver_OnEvent"*)

(* Ocaml classes *)

class event_receiver (obj : obj) = object(self)
  val obj = obj
  method obj = obj
  (*method on_event = event_receiver_on_event self#obj*)
end

let free x = event_receiver_destroy x#obj

class event_receiver_fun f = object(self)
  inherit event_receiver (event_receiver_create f)
  initializer Gc.finalise free self
end
