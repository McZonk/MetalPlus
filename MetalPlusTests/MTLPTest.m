#import "MTLPTest.h"

#import <objc/runtime.h>


@implementation MTLPTest

+ (dispatch_queue_t)testQueue
{
	static dispatch_queue_t testQueue;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		testQueue = dispatch_queue_create("MetalPlusTests", DISPATCH_QUEUE_SERIAL);
	});
	
	return testQueue;
}

+ (void)runTests
{
	dispatch_async(self.testQueue, ^{
		if(self == MTLPTest.class)
		{
			unsigned int count = 0;
			Class *classes = objc_copyClassList(&count);
			
			for(unsigned int index = 0; index < count; ++index)
			{
				Class cls = classes[index];
				
				Class superCls = class_getSuperclass(cls);
				
				if(superCls == MTLPTest.class)
				{
					[cls runTests];
				}
			}

			free(classes), classes = NULL;
		}
		else
		{
			unsigned int count = 0;
			Method *methods = class_copyMethodList(self, &count);
		
			for(unsigned int index = 0; index < count; ++index)
			{
				Method method = methods[index];
				SEL selector = method_getName(method);
			
				NSString *name = NSStringFromSelector(selector);
			
				if([name hasPrefix:@"test"])
				{
					NSLog(@"RUN:  [%@ %@]", self, name);
				
					MTLPTest *test = [[self alloc] init];
				
					[test setUp];
				
					@try
					{
						[test performSelector:selector];
					}
					@catch (NSException *exception)
					{
					}
				
					[test tearDown];
				
					NSLog(@"DONE: [%@ %@]", self, name);
				}
			}
		
			free(methods), methods = NULL;
		}
	});
}

- (void)setUp
{
	
}

- (void)tearDown
{
	
}

@end
