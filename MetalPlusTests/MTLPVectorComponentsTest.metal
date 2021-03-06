//
//  Shaders.metal
//  MetalPlusTests
//
//  Created by Maximilian Christ on 03/10/14.
//  Copyright (c) 2014 McZonk. All rights reserved.
//

#include <metal_stdlib>
#include <simd/simd.h>

#include "metalplus_math"


using namespace metal;
using namespace metalplus;



kernel void testVector4MaxComponent(
	const device float4 *ins [[ buffer(0) ]],
	device float *outs [[ buffer(1) ]],
	uint index [[ thread_position_in_grid ]]
) {
	float4 in = ins[index];
	
	float out = max_component(in);
	
	outs[index] = out;
}


kernel void testVector4MinComponent(
	const device float4 *ins [[ buffer(0) ]],
	device float *outs [[ buffer(1) ]],
	uint index [[ thread_position_in_grid ]]
) {
	float4 in = ins[index];
	
	float out = min_component(in);
	
	outs[index] = out;
}



