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

- (void)testVectorMaxComponent
{
	id<MTLDevice> device = MTLCreateSystemDefaultDevice();
	
	id<MTLLibrary> library = [device newDefaultLibrary];
	
	id<MTLFunction> function = [library newFunctionWithName:@"testVectorMaxComponent"];
	assert(function != nil);

	NSError *error = nil;
	id<MTLComputePipelineState> pipelineState = [device newComputePipelineStateWithFunction:function error:&error];
	assert(pipelineState != nil);
	assert(error == nil);

	const vector_float4 input[1] = {
		{ 1.0, 2.0, 3.0, 4.0 },
	};
	
	id<MTLBuffer> inputBuffer = [device newBufferWithBytes:input length:sizeof(input) options:MTLResourceOptionCPUCacheModeDefault];
	id<MTLBuffer> outputBuffer = [device newBufferWithLength:sizeof(float) options:MTLResourceOptionCPUCacheModeDefault];

	id<MTLCommandQueue> commandQueue = [device newCommandQueue];
	
	id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
	
	id<MTLComputeCommandEncoder> commandEncoder = [commandBuffer computeCommandEncoder];
	[commandEncoder setComputePipelineState:pipelineState];
	
	[commandEncoder setBuffer:inputBuffer offset:0 atIndex:0];
	[commandEncoder setBuffer:outputBuffer offset:0 atIndex:1];
	
	[commandEncoder dispatchThreadgroups:MTLSizeMake(1, 1, 1) threadsPerThreadgroup:MTLSizeMake(1, 1, 1)];
	
	[commandEncoder endEncoding];
	
	[commandBuffer commit];
	
	[commandBuffer waitUntilCompleted];
	
	float *output = [outputBuffer contents];
	
	assert(output[0] == 4.0);
}

@end
