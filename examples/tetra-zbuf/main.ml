open Printf
open Bigarray

(* Vertices of the octahedron. *)
let octahedron r =
  let a = 0.5 *. sqrt 2. *. r in
  [| (-.a, 0., -.a); (-.a, 0., a); (a, 0., a); (a, 0., -.a);
     (0., -.r, 0.); (0., r, 0.) |]

(* Convert those vertices to Irrlicht vertices. *)
let irr_vertices vertices =
  Array.map
    (fun vertice ->
      { Irr_video.Vertex.color = Irr_core.color_ARGB 255 255 255 255;
        pos = vertice;
        (* We don't care about normals and texture coordinates as we won't
           use texturing nor lighting. *)
        normal = (0., 0., 0.);
        t_coords = (0., 0.) } )
    vertices

let octa_vertices = octahedron 40.
(* We use use a slightly smaller octahedron to fill the ZBuffer in
   [draw_octahedron] to avoid glitches. In newer version of Irrlicht,
   we should use the depth bias introduced in PolygonOffsetFactor instead. *)
let irr_octa_vertices_biased = irr_vertices (octahedron 39.6)

(* Indexes defining the eight triangle faces of the octahedron using
   triangle fan. *)
let octa_indexes_up =
  Array1.of_array int16_signed c_layout [| 4; 0; 3; 2; 1; 0 |]
let octa_indexes_down =
  Array1.of_array int16_signed c_layout [| 5; 0; 1; 2; 3; 0 |]

let draw_edges (driver:Irr_video.driver) (material:Irr_video.material) color =
  for i = 0 to 3 do
    driver#draw_3d_line ~color octa_vertices.(4) octa_vertices.(i);
    driver#draw_3d_line ~color octa_vertices.(5) octa_vertices.(i);
    driver#draw_3d_line ~color octa_vertices.(i) octa_vertices.(succ i mod 4)
  done;;

let draw_octahedron (driver:Irr_video.driver) (material:Irr_video.material) =
  (* Fill the ZBuffer with the octahedron. *)
  material#set_color_mask `none;
  material#set_zbuffer `lessequal;
  material#set_zwrite true;
  driver#set_material material;
  driver#draw_vertex_primitive_list_16
    irr_octa_vertices_biased octa_indexes_up 4 `triangle_fan;
  driver#draw_vertex_primitive_list_16
    irr_octa_vertices_biased octa_indexes_down 4 `triangle_fan;
  material#set_color_mask `all;
  (* Draw back edges. *)
  material#set_zbuffer `greater;
  material#set_zwrite false;
  driver#set_material material;
  draw_edges driver material (Irr_core.color_ARGB 255 0 0 255);
  (* Draw front edges. *)
  material#set_zbuffer `lessequal;
  driver#set_material material;
  material#set_zwrite true;
  draw_edges driver material (Irr_core.color_ARGB 255 255 0 0)

let start_gui () =
  let device = Irr.create_device ~dtype:`opengl () in
  let driver = device#driver
  and smgr = device#scene_manager in
  let cam = smgr#add_camera_maya () in
  cam#set_pos (2., 2., 2.);
  cam#set_target (0., 0., 0.);
  let material = new Irr_video.material_fresh in
  material#set_lighting false;
  material#set_thickness 2.;
  let last_fps = ref (-1) in
  let driver_name = driver#name in
  while device#run do
    if device#is_window_active then (
      driver#begin_scene ~color:(Irr_core.color_ARGB 255 100 100 100) ();
      smgr#draw_all;
      draw_octahedron driver material;
      driver#end_scene;
      let fps = driver#fps in
      if !last_fps <> fps then (
        let str = sprintf "Geometry - [%s] FPS:%d"
          driver_name fps in
        device#set_window_caption str;
        last_fps := fps)
    ) else device#yield
  done;;

start_gui ();;
