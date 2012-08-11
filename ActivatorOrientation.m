#import <libactivator/libactivator.h>

@interface SBOrientationLockManager : NSObject
+(SBOrientationLockManager *)sharedInstance;
-(void)lock;
-(void)unlock;
-(BOOL)isLocked;
@end


@interface ActivatorOrientation : NSObject<LAListener>
@end


@implementation ActivatorOrientation

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
	// Called when we recieve event
	Class SBOrientationLockManagerC = objc_getClass("SBOrientationLockManager");
	id manager = [SBOrientationLockManagerC sharedInstance];

	if ([manager isLocked]) {
		[manager unlock];
	}
	else {
		[manager lock];
	}
	[event setHandled:YES];
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
	// Called when event is escalated to a higher event
	// (short-hold sleep button becomes long-hold shutdown menu, etc)
}

- (void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event
{
	// Called when some other listener received an event; we should cleanup
}

- (void)activator:(LAActivator *)activator receiveDeactivateEvent:(LAEvent *)event
{
	// Called when the home button is pressed.
	// If (and only if) we are showing UI, we should dismiss it and call setHandled:
	
}

- (void)dealloc
{
	// Since this object lives for the lifetime of SpringBoard, this will never be called
	// It's here for the sake of completeness
	[super dealloc];
}

+ (void)load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	// Register our listener
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.rickye.activatororientation"];
	[pool release];
}

@end 