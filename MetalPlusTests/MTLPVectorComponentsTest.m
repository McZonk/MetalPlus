#import "MTLPTest.h"

#import <simd/simd.h>


@import Metal;


@interface MTLPVectorComponentsTest : MTLPTest

@end


@implementation MTLPVectorComponentsTest

- (void)setUp
{
	
}

- (void)tearDown
{
	
}

- (void)testVector4MaxComponent
{
	id<MTLDevice> device = MTLCreateSystemDefaultDevice();
	
	id<MTLLibrary> library = [device newDefaultLibrary];
	
	id<MTLFunction> function = [library newFunctionWithName:@"testVector4MaxComponent"];
	assert(function != nil);

	NSError *error = nil;
	id<MTLComputePipelineState> pipelineState = [device newComputePipelineStateWithFunction:function error:&error];
	assert(pipelineState != nil);
	assert(error == nil);
	
#define COUNT 5

	const vector_float4 input[COUNT] = {
		{  1.0,  2.0,  3.0,  4.0 },
		{  1.0,  1.0,  1.0,  1.0 },
		{ -1.0, -2.0, -3.0, -4.0 },
		{  0.0,  0.0,  0.0,  0.0 },
		{ -1.0,  0.0,  0.0,  1.0 },
	};
	
	const float expectedOutput[COUNT] = {
		 4.0,
		 1.0,
		-1.0,
		 0.0,
		 1.0,
	};
	
	id<MTLBuffer> inputBuffer = [device newBufferWithBytes:input length:sizeof(input) options:MTLResourceOptionCPUCacheModeDefault];
	id<MTLBuffer> outputBuffer = [device newBufferWithLength:sizeof(expectedOutput) options:MTLResourceOptionCPUCacheModeDefault];

	id<MTLCommandQueue> commandQueue = [device newCommandQueue];
	
	id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
	
	id<MTLComputeCommandEncoder> commandEncoder = [commandBuffer computeCommandEncoder];
	[commandEncoder setComputePipelineState:pipelineState];
	
	[commandEncoder setBuffer:inputBuffer offset:0 atIndex:0];
	[commandEncoder setBuffer:outputBuffer offset:0 atIndex:1];
	
	[commandEncoder dispatchThreadgroups:MTLSizeMake(COUNT, 1, 1) threadsPerThreadgroup:MTLSizeMake(1, 1, 1)];
	
	[commandEncoder endEncoding];
	
	[commandBuffer commit];
	
	[commandBuffer waitUntilCompleted];
	
	float *output = [outputBuffer contents];
	
	for(NSUInteger index = 0; index < COUNT; ++index)
	{
		float value = output[index];
		float expectedValue = expectedOutput[index];
		
		assert(fabs(value - expectedValue) < 0.00001);
	}
}

- (void)testVector4MinComponent
{
	id<MTLDevice> device = MTLCreateSystemDefaultDevice();
	
	id<MTLLibrary> library = [device newDefaultLibrary];
	
	id<MTLFunction> function = [library newFunctionWithName:@"testVector4MinComponent"];
	assert(function != nil);
	
	NSError *error = nil;
	id<MTLComputePipelineState> pipelineState = [device newComputePipelineStateWithFunction:function error:&error];
	assert(pipelineState != nil);
	assert(error == nil);
	
#define COUNT 5
	
	const vector_float4 input[COUNT] = {
		{  1.0,  2.0,  3.0,  4.0 },
		{  1.0,  1.0,  1.0,  1.0 },
		{ -1.0, -2.0, -3.0, -4.0 },
		{  0.0,  0.0,  0.0,  0.0 },
		{ -1.0,  0.0,  0.0,  1.0 },
	};
	
	const float expectedOutput[COUNT] = {
		 1.0,
		 1.0,
		-4.0,
		 0.0,
		-1.0,
	};
	
	id<MTLBuffer> inputBuffer = [device newBufferWithBytes:input length:sizeof(input) options:MTLResourceOptionCPUCacheModeDefault];
	id<MTLBuffer> outputBuffer = [device newBufferWithLength:sizeof(expectedOutput) options:MTLResourceOptionCPUCacheModeDefault];
	
	id<MTLCommandQueue> commandQueue = [device newCommandQueue];
	
	id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
	
	id<MTLComputeCommandEncoder> commandEncoder = [commandBuffer computeCommandEncoder];
	[commandEncoder setComputePipelineState:pipelineState];
	
	[commandEncoder setBuffer:inputBuffer offset:0 atIndex:0];
	[commandEncoder setBuffer:outputBuffer offset:0 atIndex:1];
	
	[commandEncoder dispatchThreadgroups:MTLSizeMake(COUNT, 1, 1) threadsPerThreadgroup:MTLSizeMake(1, 1, 1)];
	
	[commandEncoder endEncoding];
	
	[commandBuffer commit];
	
	[commandBuffer waitUntilCompleted];
	
	float *output = [outputBuffer contents];
	
	for(NSUInteger index = 0; index < COUNT; ++index)
	{
		float value = output[index];
		float expectedValue = expectedOutput[index];
		
		assert(fabs(value - expectedValue) < 0.00001);
	}
}

@end
