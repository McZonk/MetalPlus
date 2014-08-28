#import "MTLPTexture+UIImage.h"

#import "MTLPTexture+CGImage.h"


@implementation NSObject (MTLPTextureUIImage)

- (BOOL)replaceMetalTextureWithUIImage:(UIImage *)image mipmapLevel:(NSUInteger)mipmapLevel slice:(NSUInteger)slice
{
	return [(id<MTLPTextureCGImage>)self replaceMetalTextureWithCGImage:image.CGImage mipmapLevel:mipmapLevel slice:slice];
}

@end
