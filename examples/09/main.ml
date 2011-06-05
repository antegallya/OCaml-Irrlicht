let normalize (x, y, z) =
  let len = sqrt (x *. x +. y *. y +. z *. z) in
  (x /. len, y /. len, z /. len)

module Colour_func : sig
  type t = float -> float -> float -> Irr_core.color
  val grey : t
  val yellow : t
  val white : t
end = struct
  type t = float -> float -> float -> Irr_core.color
  let grey x y z =
    let n = int_of_float (255. *. z) in
    Irr_core.color_ARGB 255 n n n
  let yellow x y z =
    let aux w = 128 + int_of_float (127. *. w) in
    Irr_core.color_ARGB 255 (aux x) (aux y) 255
  let white x y z = Irr_core.color_ARGB 255 255 255 255
end

module Generate_func : sig
  type t = int -> int -> float -> float
  val eggbox : t
  val moresine : t
  val justexp : t
end = struct
  type t = int -> int -> float -> float
  let eggbox x y s =
    let r = 4. *. sqrt (float_of_int (x * x + y * y)) /. s in
    let aux z = cos (0.2 *. float_of_int z) in
    let z = exp (-. r *. 2.) *. (aux x) *. (aux y) in
    0.25 +. 0.25 *. z
  let moresine x y s =
    let xx = 0.3 *. (float_of_int x) /. s in
    let yy = 12. *. (float_of_int y) /. s in
    let z = sin (xx *. xx +. yy) *. sin (xx +. yy *. yy) in
    0.25 +. 0.25 *. z
  let justexp x y s =
    let aux z = 6. *. (float_of_int z) /. s in
    let xx = aux x and yy = aux y in
    let z = xx *. xx +. yy *. yy in
    0.3 *. z *. cos (xx *. yy)
end

module Height_map : sig
  type t
  val create : int -> int -> t
  val generate : t -> Generate_func.t -> unit
  val width : t -> int
  val height : t -> int
  val calc : t -> Generate_func.t -> int -> int -> float
  val set : t -> int -> int -> float -> unit
  val set_i : t -> int -> float -> unit
  val get : t -> int -> int -> float
  val get_normal : t -> int -> int -> float -> Irr_core.vector3df
end = struct
  type t = {width : int; height : int; s : float; data : float array}
  let create w h =
    let s = sqrt (float_of_int (w * w + h * h)) in
    let data = Array.make (w * h) 0. in
    {width = w; height = h; s = s; data = data}
  let set_i map x z = map.data.(x) <- z
  let set map x y z = set_i map (y * map.width + x) z
  let get map x y = map.data.(y * map.width + x)
  let calc map f x y =
    let aux z d = int_of_float (float z -. float d *. 0.5) in
    f (aux x map.width) (aux y map.height) map.s
  let width map = map.width
  let height map = map.height
  let generate map f =
    for y = 0 to map.height - 1 do
      for x = 0 to map.width - 1 do
        set map x y (calc map f x y)
      done
    done
  let get_normal map x y s =
    let zc = get map x y in
    let zl, zr =
      if x = 0 then let zr = get map (x + 1) y in (zc +. zc -. zr, zr)
      else if x = map.width - 1 then
        let zl = get map (x - 1) y in (zl, zc +. zc -. zl)
      else (get map (x - 1) y, get map (x + 1) y) in
    let zu, zd =
      if y = 0 then let zd = get map x (y + 1) in (zc +. zc -. zd, zd)
      else if y = map.height - 1 then
        let zu = get map x (y - 1) in (zu, zc +. zc -. zu)
      else (get map x (y - 1), get map x (y + 1)) in
    normalize (s *. 2. *. (zl -. zr), 4., s *. 2. *. (zd -. zu))
end

module Mesh : sig
  type t
  val create : unit -> t
  val init :
    t -> Height_map.t -> float -> Colour_func.t -> Irr_video.driver -> unit
  val add_strip :
    t -> Height_map.t -> Colour_func.t -> int -> int -> int -> unit
  val get_mesh : t -> Irr_scene.fresh_mesh 
end = struct
  type t =
    {mutable width : int; mutable height : int; mutable scale : float;
    mesh : Irr_scene.fresh_mesh;
    mutable buffers : Irr_scene.fresh_mesh_buffer list}
  let create () =
    {width = 0; height = 0; scale = 0.; mesh = new Irr_scene.fresh_mesh;
    buffers = []}
  let add_strip mesh hm cf y0 y1 buf_num =
    let buf =
      if buf_num < mesh.mesh#buffer_count then List.nth mesh.buffers buf_num
      else
        let buf = new Irr_scene.fresh_mesh_buffer in
        mesh.buffers <- mesh.buffers @ [buf];
        mesh.mesh#add_buffer (buf :> Irr_scene.mesh_buffer);
        buf in
    buf#set_vertices_used ((1 + y1 - y0) * mesh.width);
    let i = ref 0 in
    for y = y0 to y1 do
      for x = 0 to mesh.width - 1 do
        let z = Height_map.get hm x y in
        let xx = float x /. float mesh.width in
        let yy = float y /. float mesh.height in
        let pos = (float x, mesh.scale *. z, float y) in
        let normal = Height_map.get_normal hm x y mesh.scale in
        let color = cf xx yy z and t_coords = (xx, yy) in
        let vert =
          {Irr_video.Vertex.pos = pos; normal = normal; color = color;
          t_coords = t_coords} in
        buf#set_vertex !i vert;
        incr i
      done
    done;
    i := 0;
    buf#set_indices_used (6 * (mesh.width - 1) * (y1 - y0));
    for y = y0 to y1 - 1 do
      for x = 0 to mesh.width - 1 do
        let n = (y - y0) * mesh.width + x in
        let list = [0; mesh.height; mesh.height + 1; mesh.height + 1; 1; 0] in
        let aux di = buf#set_index !i (n + di); incr i in
        List.iter aux list
      done
    done;
    buf#recalculate_bounding_box
  let init mesh hm scale cf (driver : Irr_video.driver) =
    mesh.scale <- scale;
    mesh.width <- Height_map.width hm;
    mesh.height <- Height_map.height hm;
    let mp = driver#max_prim_count in
    let sw = mp / (6 * mesh.height) in
    let rec aux i y0 =
      if y0 >= mesh.height then ()
      else (
        let y1 = min (y0 + sw) (mesh.height - 1) in
        add_strip mesh hm cf y0 y1 i;
        aux (i + 1) (y0 + sw)) in
    aux 0 0;
    mesh.mesh#recalculate_bounding_box
  let get_mesh mesh = mesh.mesh
end

let () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver and smgr = device#scene_manager in
  device#set_window_caption "Irrlicht Example for SMesh usage";
  let mesh = Mesh.create () in
  let hm = Height_map.create 255 255 in
  Height_map.generate hm  Generate_func.eggbox;
  Mesh.init mesh hm 50. Colour_func.grey driver;
  let mesh_node = smgr#add_mesh_node (Mesh.get_mesh mesh :> Irr_scene.mesh) in
  mesh_node#set_material_flag `back_face_culling false;
  let node = smgr#add_light_node ~pos:(0., 100., 0.)
    ~color:(Irr_core.colorf_RGB 1. 0.6 0.7) ~radius:500. () in
  let light_att = (0., 1. /. 500., 0.) in
  node#set_data (Irr_video.Light.cons node#data ~attenuation:light_att ());
  let anim = smgr#create_fly_circle ~center:(0., 150., 0.) ~radius:250. () in
  node#add_animator anim;
  let camera = smgr#add_camera_fps () in
  camera#set_pos (-20., 150., -20.);
  camera#set_target (200., -80., 150.);
  camera#set_far_value (20000.);
  while device#run do
    driver#begin_scene ();
    smgr#draw_all;
    driver#end_scene
  done
