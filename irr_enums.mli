type driver_type = [
| `null
| `software
| `burningsvideo
| `direct3d8
| `direct3d9
| `opengl
]

type key_code = [
| `lbutton
| `rbutton
| `cancel
| `mbutton
| `xbutton1
| `xbutton2
| `back
| `tab
| `clear
| `return
| `shift
| `control
| `menu
| `pause
| `capital
| `kana
| `junja
| `final
| `hanja
| `escape
| `convert
| `nonconvert
| `accept
| `modechange
| `space
| `prior
| `next
| `ends
| `home
| `left
| `up
| `right
| `down
| `select
| `print
| `execut
| `snapshot
| `insert
| `delete
| `help
| `key_0
| `key_1
| `key_2
| `key_3
| `key_4
| `key_5
| `key_6
| `key_7
| `key_8
| `key_9
| `key_a
| `key_b
| `key_c
| `key_d
| `key_e
| `key_f
| `key_g
| `key_h
| `key_i
| `key_j
| `key_k
| `key_l
| `key_m
| `key_n
| `key_o
| `key_p
| `key_q
| `key_r
| `key_s
| `key_t
| `key_u
| `key_v
| `key_w
| `key_x
| `key_y
| `key_z
| `lwin
| `rwin
| `apps
| `sleep
| `numpad0
| `numpad1
| `numpad2
| `numpad3
| `numpad4
| `numpad5
| `numpad6
| `numpad7
| `numpad8
| `numpad9
| `multiply
| `add
| `separator
| `subtract
| `decimal
| `divide
| `f1
| `f2
| `f3
| `f4
| `f5
| `f6
| `f7
| `f8
| `f9
| `f10
| `f11
| `f12
| `f13
| `f14
| `f15
| `f16
| `f17
| `f18
| `f19
| `f20
| `f21
| `f22
| `f23
| `f24
| `numlock
| `scroll
| `lshift
| `rshift
| `lcontrol
| `rcontrol
| `lmenu
| `rmenu
| `plus
| `comma
| `minus
| `period
| `attn
| `crsel
| `exsel
| `ereof
| `play
| `zoom
| `pa1
| `oem_clear
| `key_codes_count
]

type material_flag = [
| `wireframe
| `pointcloud
| `gouraud_shading
| `lighting
| `zbuffer
| `zwrite_enable
| `back_face_culling
| `front_face_culling
| `bilinear_filter
| `trilinear_filter
| `anisotropic_filter
| `fog_enable
| `normalize_normals
| `texture_wrap
| `anti_aliasing
| `color_mask
| `color_material
]

type key_action = [
| `move_forward
| `move_backward
| `strafe_left
| `strafe_right
| `jump_up
| `crouch
]

type mouse_input_event = [
| `lmouse_pressed_down
| `rmouse_pressed_down
| `mmouse_pressed_down
| `lmouse_left_up
| `rmouse_left_up
| `mmouse_left_up
| `mouse_moved
| `mouse_wheel
| `lmouse_double_click
| `rmouse_double_click
| `mmouse_double_click
| `lmouse_triple_click
| `rmouse_triple_click
| `mmouse_triple_click
]

type md2_animation_type = [
| `stand
| `run
| `attack
| `pain_a
| `pain_b
| `pain_c
| `jump
| `flip
| `salute
| `fallback
| `wave
| `point
| `crouch_stand
| `crouch_walk
| `crouch_attack
| `crouch_pain
| `crouch_death
| `death_fallback
| `death_fallforward
| `death_fallbackslow
| `boom
]

type file_archive_type = [
| `zip
| `gzip
| `folder
| `pak
| `npk
| `tar
| `unknown
]

type anti_aliasing_mode = [
| `off
| `simple
| `quality
| `line_smooth
| `full_basic
| `alpha_to_coverage
]

type terrain_patch_size = [
| `tps_9
| `tps_17
| `tps_33
| `tps_65
| `tps_129
]

type material_type = [
| `solid
| `solid_2_layer
| `lightmap
| `lightmap_add
| `lightmap_m2
| `lightmap_m4
| `lightmap_lighting
| `lightmap_lighting_m2
| `lightmap_lighting_m4
| `detail_map
| `reflection_2_layer
| `transparent_add_color
| `transparent_alpha_channel
| `transparent_alpha_channel_ref
| `transparent_vertex_alpha
| `transparent_reflection_2_layer
| `normal_map_solid
| `normal_map_transparent_add_color
| `normal_map_transparent_vertex_alpha
| `parallax_map_solid
| `parallax_map_transparent_add_color
| `parallax_map_transparent_vertex_alpha
| `onetexture_blend
| `force_32bit
]

type texture_creation_flag = [
| `always_16_bit
| `always_32_bit
| `optimized_for_quality
| `optimized_for_speed
| `create_mip_maps
| `no_alpha_channel
| `allow_non_power_2
]

type gui_default_font = [
| `default
| `button
| `window
| `menu
| `tooltip
]

type texture_clamp = [
| `repeat
| `clamp
| `clamp_to_edge
| `clamp_to_border
| `mirror
| `mirror_clamp
| `mirror_clamp_to_edge
| `mirror_clamp_to_border
]

type color_plane = [
| `none
| `alpha
| `red
| `green
| `blue
| `rgb
| `all
]

type colormaterial = [
| `none
| `diffuse
| `ambient
| `emissive
| `specular
| `diffuse_and_ambient
]

type comparison_func = [
| `never
| `lessequal
| `equal
| `less
| `notequal
| `greaterequal
| `greater
| `always
]

type transformation_state = [
| `view
| `world
| `projection
| `texture_0
| `texture_1
| `texture_2
| `texture_3
]

