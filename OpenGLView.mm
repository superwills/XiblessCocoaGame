#import "OpenGLView.h"
#include <OpenGL/gl.h>
#import <QuartzCore/CADisplayLink.h>

#include "StopWatch.h"

StopWatch sw;

@implementation OpenGLView

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if( !self )  return self;
  ///[self createDisplayLink];
  return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if( !self )  return self;
  ////[self createDisplayLink];
  return self;
}

- (void) update:(CADisplayLink*) sender {
  
  [self display];
}

- (void) createDisplayLink {
  CADisplayLink *displayLink = [self displayLinkWithTarget:self selector:@selector(update:)];
  [displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
  displayLink.preferredFrameRateRange = CAFrameRateRangeMake( 60, 60, 60 );
}

- (void) drawRect:(NSRect)bounds {

  static double last = sw.sec();
  
  double now = sw.sec();
  double diff = now - last;
  //printf( "FPS: %f\n", 1/diff );
  
  last = sw.sec();
  glClearColor( 0, 0, 0, 0 );
  glClear( GL_COLOR_BUFFER_BIT );
  glColor3f( 1, .85, .35 );
  
  static float d = 0;
  //d = fabsf( sinf( sw.sec() ) );
  d += .001;
  glBegin(GL_TRIANGLES);
  glVertex3f(  0.0,  0.6, 0.0);
  glVertex3f( -0.2 - d, -0.3, 0.0);
  glVertex3f(  0.2 + d, -0.3 ,0.0);
  glEnd();
  
  glFlush();
}


@end
