#import <Metal/Metal.h>
#import <CoreGraphics/CoreGraphics.h>


@protocol MTLPTextureCGImage <MTLTexture>
@required

- (BOOL)replaceMetalTextureWithCGImage:(CGImageRef)image mipmapLevel:(NSUInteger)mipmapLevel slice:(NSUInteger)slice;

@end
