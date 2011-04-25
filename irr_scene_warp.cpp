/* C++ stub for module Irr_scene */

#include "global.h"

/* Stub for class ISceneNode */
		
extern "C" CAMLprim value ml_ISceneNode_getPosition(value v_node) {
	return copy_vector3df(((ISceneNode*) v_node)->getPosition());
}

extern "C" CAMLprim value ml_ISceneNode_addAnimator(
		value v_node, value v_anim)
{
	((ISceneNode*) v_node)->addAnimator((ISceneNodeAnimator*) v_anim);
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setMaterialFlag(
		value v_node, value v_flag, value v_b)
{
	((ISceneNode*) v_node)->setMaterialFlag(
		material_flag_val(v_flag), Bool_val(v_b));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setMaterialTexture(
		value v_node, value v_layer, value v_tex)
{
	((ISceneNode*) v_node)->setMaterialTexture(
		Int_val(v_layer), (ITexture*) v_tex);
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setMaterialType(
		value v_node, value v_type)
{
	((ISceneNode*) v_node)->setMaterialType(material_type_val(v_type));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setPosition(value v_node, value v_pos) {
	((ISceneNode*) v_node)->setPosition(Vector3df_val(v_pos));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setRotation(value v_node, value v_rot) {
	((ISceneNode*) v_node)->setRotation(Vector3df_val(v_rot));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setScale(value v_node, value v_scale) {
	((ISceneNode*) v_node)->setScale(Vector3df_val(v_scale));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setTriangleSelector(
		value v_node, value v_ts)
{
	((ISceneNode*) v_node)->setTriangleSelector((ITriangleSelector*) v_ts);
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_setVisible(value v_node, value v_b) {
	((ISceneNode*) v_node) ->setVisible(Bool_val(v_b));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_getAbsolutePosition(value v_node) {
	return copy_vector3df(((ISceneNode*) v_node)->getAbsolutePosition());
}

extern "C" CAMLprim value ml_ISceneNode_getMaterial(value v_node, value v_i) {
	return (value) &((ISceneNode*) v_node)->getMaterial(Int_val(v_i));
}

extern "C" CAMLprim value ml_ISceneNode_setID(value v_node, value v_n) {
	((ISceneNode*) v_node)->setID(Int_val(v_n));
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_getID(value v_node) {
	return Val_int(((ISceneNode*) v_node)->getID());
}

extern "C" CAMLprim value ml_ISceneNode_addChild(value v_node, value v_child) {
	((ISceneNode*) v_node)->addChild((ISceneNode*) v_child);
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneNode_clone(value v_node, value v_parent) {
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	return (value) ((ISceneNode*) v_node)->clone(parent);
}

extern "C" CAMLprim value ml_ISceneNode_getAutomaticCulling(value v_node) {
	return Val_culling_type(((ISceneNode*) v_node)->getAutomaticCulling());
}

/* Stub for class IAnimatedMesh */

extern "C" value ml_IAnimatedMesh_getMesh(
		value v_am, value v_frame, value v_detail_lv, value v_start, value v_end)
{
	return (value) ((IAnimatedMesh*) v_am)->getMesh(0 /*Int_val(v_frame),
			Int_val(v_detail_lv), Int_val(v_start), Int_val(v_end)*/);
}

/* Stub for class IAnimatedMeshSceneNode */

extern "C" CAMLprim value ml_IAnimatedMeshSceneNode_setAnimationSpeed(
		value v_node, value v_speed)
{
	((IAnimatedMeshSceneNode*) v_node)->setAnimationSpeed(Double_val(v_speed));
	return Val_unit;
}

extern "C" CAMLprim value ml_IAnimatedMeshSceneNode_setFrameLoop(
		value v_node, value v_begin, value v_end)
{
	return Val_bool(((IAnimatedMeshSceneNode*) v_node)->setFrameLoop(
				Int_val(v_begin), Int_val(v_end)));
}
	
extern "C" CAMLprim value ml_IAnimatedMeshSceneNode_setMD2Animation(
		value v_node, value v_type)
{
	return Val_bool(((IAnimatedMeshSceneNode*) v_node)->setMD2Animation(
			md2_animation_type_val(v_type)));
}

/* Stub for class ICameraSceneNode */

extern "C" CAMLprim value ml_ICameraSceneNode_setFarValue(
		value v_cam, value v_x)
{
	((ICameraSceneNode*) v_cam)->setFarValue(Double_val(v_x));
	return Val_unit;
}

extern "C" CAMLprim value ml_ICameraSceneNode_setTarget(
		value v_cam, value v_pos)
{
	((ICameraSceneNode*) v_cam)->setTarget(Vector3df_val(v_pos));
	return Val_unit;
}

extern "C" CAMLprim value ml_ICameraSceneNode_getTarget(value v_cam) {
	return copy_vector3df(((ICameraSceneNode*) v_cam)->getTarget());
}

/* Stub for ITerrainSceneNode */

extern "C" CAMLprim value ml_ITerrainSceneNode_scaleTexture(
		value v_terrain, value v_x, value v_y)
{
	((ITerrainSceneNode*) v_terrain)->scaleTexture(Double_val(v_x),
		Double_val(v_y));
	return Val_unit;
}

extern "C" CAMLprim value ml_ITerrainSceneNode_getHeight(
		value v_terrain, value v_x, value v_y)
{
	return copy_double(((ITerrainSceneNode*) v_terrain)->getHeight(
				Double_val(v_x), Double_val(v_y)));
}

/* Stub for class IBillboardSceneNode */

extern "C" CAMLprim value ml_IBillboardSceneNode_setSize(
		value v_node, value v_d)
{
	((IBillboardSceneNode*) v_node)->setSize(Dimension2d_f32_val(v_d));
	return Val_unit;
}

/* Stub for class IMeshSceneNode */

extern "C" CAMLprim value ml_IMeshSceneNode_getMesh(value v_node) {
	return (value) ((IMeshSceneNode*) v_node)->getMesh();
}

/* Stub for class ISceneCollisionManager */

extern "C" CAMLprim value
ml_ISceneCollisionManager_getSceneNodeAndCollisionPointFromRay(
		value v_manager, value v_ray, value v_id, value v_root, value v_ndo)
{
	CAMLparam0();
	CAMLlocal2(v, r);
	ISceneNode* root;
	if(Is_block(v_root)) root = (ISceneNode*) Field(v_root, 0);
	else root = NULL;
	vector3df Point;
	triangle3df Triangle;
	ISceneCollisionManager* m = (ISceneCollisionManager*) v_manager;
	ISceneNode* node = m->getSceneNodeAndCollisionPointFromRay(
			Line3df_val(v_ray), Point, Triangle, Int_val(v_id), root,
			Bool_val(v_ndo));
	if(node == NULL) CAMLreturn(Val_int(0));
	v = caml_alloc(3, 0);
	Store_field(v, 0, (value) node);
	Store_field(v, 1, copy_vector3df(Point));
	Store_field(v, 2, copy_triangle3df(Triangle));
	r = caml_alloc(1, 0);
	Store_field(r, 0, v);
	CAMLreturn(r);
}

/* Stub for class ISceneManager */

extern "C" CAMLprim value ml_ISceneManager_addAnimatedMeshSceneNode_native(
		value v_manager, value v_mesh, value v_parent, value v_id, value v_pos,
		value v_rot, value v_scale)
{
	ISceneNode* parent;
	if(v_parent = Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	return (value) ((ISceneManager*) v_manager)->addAnimatedMeshSceneNode(
			(IAnimatedMesh*) v_mesh, parent, Int_val(v_id), Vector3df_val(v_pos),
			Vector3df_val(v_rot));
}

extern "C" CAMLprim value ml_ISceneManager_addAnimatedMeshSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addAnimatedMeshSceneNode_native(argv[0], argv[1],
			argv[2], argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_addCameraSceneNode_native(
		value v_manager, value v_parent, value v_pos, value v_lookat, value v_id,
		value v_make_active)
{
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	ICameraSceneNode* node = ((ISceneManager*) v_manager)->addCameraSceneNode(
			parent, Vector3df_val(v_pos), Vector3df_val(v_lookat), Int_val(v_id),
			Bool_val(v_make_active));
	if(node == NULL) null_pointer_exn();
	return (value) node;
}

extern "C" CAMLprim value ml_ISceneManager_addCameraSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addCameraSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5]);
}

extern "C" CAMLprim value ml_ISceneManager_addCameraSceneNodeFPS_native(
		value v_manager, value v_parent, value v_rs, value v_ms, value v_id,
		value v_km, value v_km_size, value v_nvm, value v_js, value v_im,
		value v_ma)
{
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) v_parent;
	int km_size = Int_val(v_km_size);
	SKeyMap km[km_size];
	value v_km_tmp = v_km, v_tmp;
	int i;
	for(i = 0; i < km_size; i++) {
		v_tmp = Field(v_km_tmp, 0);
		km[i].Action = key_action_val(Field(v_tmp, 0));
		km[i].KeyCode = key_code_val(Field(v_tmp, 1));
		v_km_tmp = Field(v_km_tmp, 1);
	}
	ICameraSceneNode* node =
		((ISceneManager*) v_manager)->addCameraSceneNodeFPS(
			parent, Double_val(v_rs), Double_val(v_ms), Int_val(v_id), km, km_size,
			Bool_val(v_nvm), Double_val(v_js), Bool_val(v_im), Bool_val(v_ma));
	if(node == NULL) null_pointer_exn();
	return (value) node;
}

extern "C" CAMLprim value ml_ISceneManager_addCameraSceneNodeFPS_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addCameraSceneNodeFPS_native(argv[0], argv[1],
			argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9],
			argv[10]);
}

extern "C" CAMLprim value ml_ISceneManager_drawAll(value v_manager) {
	((ISceneManager*) v_manager)->drawAll();
	return Val_unit;
}

extern "C" CAMLprim value ml_ISceneManager_getMesh(
		value v_manager, value v_file)
{
	IAnimatedMesh* mesh =
		((ISceneManager*) v_manager)->getMesh(String_val(v_file));
	if(mesh == NULL) null_pointer_exn();
	return (value) mesh;
}

extern "C" CAMLprim value ml_ISceneManager_addMeshSceneNode_native(
		value v_manager, value v_mesh, value v_parent, value v_id, value v_pos,
		value v_rot, value v_scale)
{
	IMeshSceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (IMeshSceneNode*) Field(v_parent, 0);
	return (value) ((ISceneManager*) v_manager)->addMeshSceneNode((IMesh*) v_mesh,
			parent, Int_val(v_id), Vector3df_val(v_pos), Vector3df_val(v_rot),
			Vector3df_val(v_scale));
}

extern "C" CAMLprim value ml_ISceneManager_addMeshSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addMeshSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_addOctreeSceneNode(
		value v_manager, value v_mesh, value v_parent, value v_id, value v_min)
{
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	IMeshSceneNode* node = ((ISceneManager*) v_manager)->addOctreeSceneNode(
			(IMesh*) v_mesh, parent, Int_val(v_id), Int_val(v_min));
	if(node == NULL) null_pointer_exn();
	return (value) node;
}

extern "C" CAMLprim value ml_ISceneManager_addSphereSceneNode_native(
		value v_manager, value v_radius, value v_poly_count, value v_parent,
		value v_id, value v_pos, value v_rot, value v_scale)
{
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	return (value) ((ISceneManager*) v_manager)->addSphereSceneNode(
			Double_val(v_radius), Int_val(v_poly_count), parent, Int_val(v_id),
			Vector3df_val(v_pos), Vector3df_val(v_rot), Vector3df_val(v_scale));
}

extern "C" CAMLprim value ml_ISceneManager_addSphereSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addSphereSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6], argv[7]);
}

extern "C" CAMLprim value ml_ISceneManager_addCubeSceneNode_native(
		value v_manager, value v_size, value v_parent, value v_id, value v_pos,
		value v_rot, value v_scale)
{
	ISceneNode* parent;
	if(v_parent == Val_int(0)) parent = NULL;
	else parent = (ISceneNode*) Field(v_parent, 0);
	return (value) ((ISceneManager*) v_manager)->addCubeSceneNode(
			Double_val(v_size), parent, Int_val(v_id), Vector3df_val(v_pos),
			Vector3df_val(v_rot), Vector3df_val(v_scale));
}

extern "C" CAMLprim value ml_ISceneManager_addCubeSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addCubeSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_addTerrainSceneNode_native(
		value v_manager, value v_filename, value v_parent, value v_id, value v_pos,
		value v_rot, value v_scale, value v_color, value v_max_lod,
		value v_patch_size, value v_smooth_factor,
		value v_add_also_if_heightmap_empty)
{
	ISceneNode* parent;
	if(Is_block(v_parent)) parent = (ISceneNode*) Field(v_parent, 0);
	else parent = NULL;
	return (value) ((ISceneManager*) v_manager)->addTerrainSceneNode(
		String_val(v_filename), parent, Int_val(v_id), Vector3df_val(v_pos),
		Vector3df_val(v_rot), Vector3df_val(v_scale), SColor_val(v_color),
		Int_val(v_max_lod), terrain_patch_size_val(v_patch_size),
		Int_val(v_smooth_factor), Bool_val(v_add_also_if_heightmap_empty));
}

extern "C" CAMLprim value ml_ISceneManager_addTerrainSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addTerrainSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9],
			argv[10], argv[11]);
}

extern "C" CAMLprim value ml_ISceneManager_addSkyBoxSceneNode_native(
		value v_manager, value v_top, value v_bottom, value v_left, value v_right,
		value v_front, value v_back, value v_parent, value v_id)
{
	ISceneNode* parent;
	if(Is_block(v_parent)) parent = (ISceneNode*) Field(v_parent, 0);
	else parent = NULL;
	ISceneNode* r = ((ISceneManager*) v_manager)->addSkyBoxSceneNode(
			(ITexture*) v_top, (ITexture*) v_bottom, (ITexture*) v_left,
			(ITexture*) v_right, (ITexture*) v_front, (ITexture*) v_back,
			parent, Int_val(v_id));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value ml_ISceneManager_addSkyBoxSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addSkyBoxSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

extern "C" CAMLprim value ml_ISceneManager_addSkyDomeSceneNode_native(
		value v_manager, value v_texture, value v_hori_res, value v_vert_res,
		value v_texture_percentage, value v_sphere_percentage, value v_radius,
		value v_parent, value v_id)
{
	ISceneNode* parent;
	if(Is_block(v_parent)) parent = (ISceneNode*) Field(v_parent, 0);
	else parent = NULL;
	ISceneNode* r = ((ISceneManager*) v_manager)->addSkyDomeSceneNode(
			(ITexture*) v_texture, Int_val(v_hori_res), Int_val(v_vert_res),
			Double_val(v_texture_percentage), Double_val(v_sphere_percentage),
			Double_val(v_radius), parent, Int_val(v_id));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value ml_ISceneManager_addSkyDomeSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addSkyDomeSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

extern "C" CAMLprim value ml_ISceneManager_addBillboardSceneNode_native(
		value v_manager, value v_parent, value v_size, value v_pos, value v_id,
		value v_color_top, value v_color_bottom)
{
	ISceneNode* parent;
	if(Is_block(v_parent)) parent = (ISceneNode*) Field(v_parent, 0);
	else parent = NULL;
	ISceneNode* r = ((ISceneManager*) v_manager)->addBillboardSceneNode(
			parent, Dimension2d_f32_val(v_size), Vector3df_val(v_pos),
			Int_val(v_id), SColor_val(v_color_top), SColor_val(v_color_bottom));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value ml_ISceneManager_addBillboardSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addBillboardSceneNode_native(argv[0], argv[1],
			argv[2], argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_createFlyCircleAnimator_native(
		value v_manager, value v_center, value v_radius, value v_speed, value v_dir, 		value v_start, value v_radius_e)
{
	return (value) ((ISceneManager*) v_manager)->createFlyCircleAnimator(
			Vector3df_val(v_center), Double_val(v_radius), Double_val(v_speed),
			Vector3df_val(v_dir), Double_val(v_start), Double_val(v_radius_e));
}

extern "C" CAMLprim value ml_ISceneManager_createFlyCircleAnimator_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_createFlyCircleAnimator_native(argv[0], argv[1],
			argv[2], argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_createFlyStraightAnimator_native(
		value v_manager, value v_start, value v_end, value v_time, value v_loop,
		value v_pingpong)
{
	return (value) ((ISceneManager*) v_manager)->createFlyStraightAnimator(
			Vector3df_val(v_start), Vector3df_val(v_end), Int_val(v_time),
			Bool_val(v_loop), Bool_val(v_pingpong));
}

extern "C" CAMLprim value ml_ISceneManager_createFlyStraightAnimator_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_createFlyStraightAnimator_native(argv[0], argv[1],
			argv[2], argv[3], argv[4], argv[5]);
}

extern "C" CAMLprim value ml_ISceneManager_createTerrainTriangleSelector(
		value v_manager, value v_node, value v_lod)
{
	ITriangleSelector* r =
		((ISceneManager*) v_manager)->createTerrainTriangleSelector(
	  (ITerrainSceneNode*) v_node, Int_val(v_lod));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value
	ml_ISceneManager_createCollisionResponseAnimator_native(
			value v_manager, value v_world, value v_node, value v_ellipsoid_radius,
			value v_gravity_per_second, value v_ellipsoid_translation,
			value v_sliding)
{
	return (value) ((ISceneManager*) v_manager)->createCollisionResponseAnimator(
			(ITriangleSelector*) v_world, (ISceneNode*) v_node,
			Vector3df_val(v_ellipsoid_radius), Vector3df_val(v_gravity_per_second),
			Vector3df_val(v_ellipsoid_translation), Double_val(v_sliding));
}

extern "C" CAMLprim value
	ml_ISceneManager_createCollisionResponseAnimator_bytecode(
			value* argv, int argn)
{
	return ml_ISceneManager_createCollisionResponseAnimator_native(argv[0],
			argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

extern "C" CAMLprim value ml_ISceneManager_createOctreeTriangleSelector(
		value v_manager, value v_mesh, value v_node, value v_mppn)
{
	ITriangleSelector* r =
		((ISceneManager*) v_manager)->createOctreeTriangleSelector(
			(IMesh*) v_mesh, (ISceneNode*) v_node, Int_val(v_mppn));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value ml_ISceneManager_getSceneCollisionManager(
		value v_manager)
{
	return (value) ((ISceneManager*) v_manager)->getSceneCollisionManager();
}

extern "C" CAMLprim value ml_ISceneManager_createTriangleSelector(
		value v_manager, value v_node)
{
	ITriangleSelector* s = ((ISceneManager*) v_manager)->createTriangleSelector(
			(IAnimatedMeshSceneNode*) v_node);
	if(s == NULL) null_pointer_exn();
	return (value) s;
}

extern "C" CAMLprim value ml_ISceneManager_addLightSceneNode_native(
		value v_manager, value v_parent, value v_pos, value v_color, value v_radius,
		value v_id)
{
	ISceneNode* parent;
	if(Is_block(v_parent)) parent = (ISceneNode*) Field(v_parent, 0);
	else parent = NULL;
	ILightSceneNode* r = ((ISceneManager*) v_manager)->addLightSceneNode(parent,
			Vector3df_val(v_pos), SColorf_val(v_color), Double_val(v_radius),
			Int_val(v_id));
	if(r == NULL) null_pointer_exn();
	return (value) r;
}

extern "C" CAMLprim value ml_ISceneManager_addLightSceneNode_bytecode(
		value* argv, int argn)
{
	return ml_ISceneManager_addLightSceneNode_native(argv[0], argv[1], argv[2],
			argv[3], argv[4], argv[5]);
}
