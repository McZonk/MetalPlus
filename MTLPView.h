#import <UIKit/UIKit.h>
#import <QuartzCore/CAMetalLayer.h>


@interface MTLPView : UIView

@property (nonatomic, strong, readonly) CAMetalLayer *layer;

@property (readwrite) MTLPixelFormat pixelFormat;

@property (readwrite) BOOL framebufferOnly;

@property (readwrite) CGSize drawableSize;

- (id<CAMetalDrawable>)newDrawable;

@property(getter=presentsWithTransaction) BOOL presentsWithTransaction;

@end
