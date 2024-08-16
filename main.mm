// XIBLESS GAME

// * WARNING
// Although this code seems to work, it is based on posts spread across the internet.
// It's not the codepath supported by Apple. Apple suggests always using NSApplicationMain/XIB files  

#import <Cocoa/Cocoa.h>

#import "AppDelegate.h"
#include "Superglobals.h"
#import "MacOSWindow.h"
#import "OpenGLView.h"

// Declared in Superglobals.h, so can be used in MacOSWindow
float PercentWindowWidth = .8;
float PercentWindowHeight = .75;
NSRect viewRect;

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSApplication *application = [NSApplication sharedApplication];
    AppDelegate *appDelegate = NSApp.delegate = [[AppDelegate alloc] init];
    
    [NSApp finishLaunching];
    NSWindow *window = createWindow();
    
    OpenGLView *glView = [[OpenGLView alloc] initWithFrame:viewRect];
    window.contentView = glView;
    
    [glView createDisplayLink];
    [application run];
  }
}
