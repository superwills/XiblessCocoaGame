#include "MacOSWindow.h"

#include "Superglobals.h"


@interface WindowDelegate : NSObject <NSWindowDelegate> {
}
@end

@implementation WindowDelegate

@end

NSWindow* createWindow() {
  // Init our global viewRect.
  NSRect screenRect = [[NSScreen mainScreen] frame];
  
  int w = screenRect.size.width*PercentWindowWidth;
  int h = screenRect.size.height*PercentWindowHeight;
  printf( "Your window will be %d x %d", w, h );
  
  // Center the window.
  int x = screenRect.size.width / 2 - w / 2;
  int y = screenRect.size.height / 2 - h / 2;
  viewRect = NSMakeRect( x, y, w, h );
  
  NSUInteger windowStyle = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskMiniaturizable;
  
  // The window will actually be sized up slightly bigger than viewRect.
  NSWindow *window = [[NSWindow alloc] initWithContentRect:viewRect
    styleMask:windowStyle
    backing:NSBackingStoreBuffered
    defer:NO];

  // This is one of the little catches and tricks that NSApplicationMain would cover for you.
  // This is based on code written in 2009. So I personally think it'd just be a dev nightmare of hidden bugs as there are probably
  // a few other little things to take care of to make sure your window is well behaved
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
 
  // Manually construct a menu
  NSMenu *menubar = [NSMenu new];
  NSMenuItem *appMenuItem = [NSMenuItem new];
  [menubar addItem:appMenuItem];
  [NSApp setMainMenu:menubar];

  NSMenu *appMenu = [NSMenu new];
  
  NSString *appName = [[NSProcessInfo processInfo] processName];
  NSString *quitTitle = [@"Quit " stringByAppendingString:appName];
  NSMenuItem *quitMenuItem = [[NSMenuItem alloc] initWithTitle:quitTitle
                      action:@selector(terminate:) keyEquivalent:@"q"];
  [appMenu addItem:quitMenuItem];
  [appMenuItem setSubmenu:appMenu];

  NSWindowController *windowController = [[NSWindowController alloc] initWithWindow:window];
  
  WindowDelegate *windowDelegate = [[WindowDelegate alloc] init];
  window.delegate = windowDelegate;
  window.acceptsMouseMovedEvents = YES;
  
  window.title = appName;

  window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
  [window makeKeyAndOrderFront:nil];
  
  return window;
}
