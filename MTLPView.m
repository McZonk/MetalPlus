#import "MTLPView.h"

@implementation MTLPView

@dynamic layer;

+ (Class)layerClass
{
	return CAMetalLayer.class;
}

- (MTLPixelFormat)pixelFormat
{
	return self.layer.pixelFormat;
}

- (void)setPixelFormat:(MTLPixelFormat)pixelFormat
{
	self.layer.pixelFormat = pixelFormat;
}

- (BOOL)framebufferOnly
{
	return self.layer.framebufferOnly;
}

- (void)setFramebufferOnly:(BOOL)framebufferOnly
{
	self.layer.framebufferOnly = framebufferOnly;
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

- (BOOL)presentsWithTransaction
{
	return self.layer.presentsWithTransaction;
}

- (void)setPresentsWithTransaction:(BOOL)presentsWithTransaction
{
	self.layer.presentsWithTransaction = presentsWithTransaction;
}

@end
