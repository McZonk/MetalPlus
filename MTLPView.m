#import "MTLPView.h"

@implementation MTLPView

@dynamic layer;

+ (Class)layerClass
{
	return CAMetalLayer.class;
}

+ (NSSet *)keyPathsForValuesAffectingDevice
{
	return [NSSet setWithObject:@"layer.device"];
}

- (id<MTLDevice>)device
{
	return self.layer.device;
}

- (void)setDevice:(id<MTLDevice>)device
{
	self.layer.device = device;
}

+ (NSSet *)keyPathsForValuesAffectingPixelFormat
{
	return [NSSet setWithObject:@"layer.pixelFormat"];
}

- (MTLPixelFormat)pixelFormat
{
	return self.layer.pixelFormat;
}

- (void)setPixelFormat:(MTLPixelFormat)pixelFormat
{
	self.layer.pixelFormat = pixelFormat;
}

+ (NSSet *)keyPathsForValuesAffectingFramebufferOnly
{
	return [NSSet setWithObject:@"layer.framebufferOnly"];
}

- (BOOL)framebufferOnly
{
	return self.layer.framebufferOnly;
}

- (void)setFramebufferOnly:(BOOL)framebufferOnly
{
	self.layer.framebufferOnly = framebufferOnly;
}

+ (NSSet *)keyPathsForValuesAffectingDrawableSize
{
	return [NSSet setWithObject:@"layer.drawableSize"];
}

- (CGSize)drawableSize
{
	return self.layer.drawableSize;
}

- (void)setDrawableSize:(CGSize)drawableSize
{
	self.layer.drawableSize = drawableSize;
}

- (id<CAMetalDrawable>)nextDrawable
{
	return self.layer.nextDrawable;
}

+ (NSSet *)keyPathsForValuesAffectingPresentsWithTransaction
{
	return [NSSet setWithObject:@"layer.presentsWithTransaction"];
}

- (BOOL)presentsWithTransaction
{
	return self.layer.presentsWithTransaction;
}

- (void)setPresentsWithTransaction:(BOOL)presentsWithTransaction
{
	self.layer.presentsWithTransaction = presentsWithTransaction;
}

@end
