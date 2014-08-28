#import "MTLPTexture+CGImage.h"


@implementation NSObject (MTLPTextureCGImage)

- (BOOL)replaceMetalTextureWithCGImage:(CGImageRef)image mipmapLevel:(NSUInteger)mipmapLevel slice:(NSUInteger)slice
{
	id<MTLTexture> texture = (id<MTLTexture>)self;
	if(![texture conformsToProtocol:@protocol(MTLTexture)])
	{
		return NO;
	}

	if(image == NULL)
	{
		return NO;
	}
	
	const size_t width = CGImageGetWidth(image);
	const size_t height = CGImageGetHeight(image);
	
	const size_t components = CGImageGetBitsPerPixel(image) / CGImageGetBitsPerComponent(image);
	
	size_t bytesPerRow = 0;
	size_t bytesPerImage = 0;
	
	MTLPixelFormat pixelFormat = MTLPixelFormatInvalid;
	
	CGContextRef context = NULL;
	
	switch(components) {
		case 1 :
		{
			pixelFormat = MTLPixelFormatR8Unorm;
			bytesPerRow = width;
			bytesPerImage = width * height;
			
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
			context = CGBitmapContextCreate(NULL, width, height, 8, width, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
			CGColorSpaceRelease(colorSpace);
			
			break;
		}
			
		case 4 :
		{
			pixelFormat = MTLPixelFormatRGBA8Unorm;
			bytesPerRow = width * 4;
			bytesPerImage = width * height * 4;
			
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
			context = CGBitmapContextCreate(NULL, width, height, 8, width * 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
			CGColorSpaceRelease(colorSpace);
			
			break;
		}
			
		default :
			NSLog(@"Unable to assign texture");
			return NO;
	}
	
	CGRect rect = CGRectMake(0, 0, width, height);
	
	CGContextClearRect(context, rect);
	
	CGContextConcatCTM(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, height));
	
	CGContextDrawImage(context, rect, image);
	
	void * const data = CGBitmapContextGetData(context);
	
	MTLRegion region = MTLRegionMake2D(0, 0, (NSUInteger)width, (NSUInteger)height);
	[texture replaceRegion:region mipmapLevel:mipmapLevel slice:slice withBytes:data bytesPerRow:bytesPerRow bytesPerImage:bytesPerImage];
	
	CGContextRelease(context), context = NULL;
	
	return YES;
}

@end
