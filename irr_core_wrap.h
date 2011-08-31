#ifndef ML_IRR_CORE_H
#define ML_IRR_CORE_H

#include "global.h"

dimension2d<u32> Dimension2d_u32_val(value);
value copy_dimension2d_u32(dimension2d<u32>);

dimension2d<f32> Dimension2d_f32_val(value);
value copy_dimension2d_f32(dimension2d<f32>);

position2d<s32> Pos2d_s32_val(value);
value copy_pos2d_s32(position2d<s32>);

position2d<f32> Pos2d_f32_val(value);
value copy_pos2d_f32(position2d<f32>);

vector3df Vector3df_val(value);
value copy_vector3df(vector3df);

vector2d<f32> Vector2df_val(value);
value copy_vector2df(vector2d<f32>);

line3df Line3df_val(value);
value copy_line3df(line3df);

triangle3df Triangle3df_val(value);
value copy_triangle3df(triangle3df);

rect<s32> Rect_s32_val(value);

SColor SColor_val(value);
value copy_SColor(SColor);

SColorf SColorf_val(value);
value copy_SColorf(SColorf);

matrix4 Matrix4_val(value);
value copy_matrix4(matrix4);

aabbox3d<f32> Aabbox3df_val(value);
value copy_aabbox3df(aabbox3d<f32>);

array<ITexture*> Array_texture_val(value);
#endif
