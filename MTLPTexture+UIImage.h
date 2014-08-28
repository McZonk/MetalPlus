#import <Metal/Metal.h>
#import <UIKit/UIKit.h>


@protocol MTLPTextureUIImage <MTLTexture>
@required

- (BOOL)replaceMetalTextureWithUIImage:(UIImage *)image mipmapLevel:(NSUInteger)mipmapLevel slice:(NSUInteger)slice;

@end
