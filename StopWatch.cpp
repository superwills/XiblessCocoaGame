#include "StopWatch.h"

StopWatch::StopWatch( string iname, bool iAutoprint ) :
    name( iname ), autoprint( iAutoprint ) {

  reset();
}

StopWatch::~StopWatch() {
  if( autoprint ) {
    printf( "%s took %f seconds\n", name.c_str(), sec() );
  }
}


void StopWatch::reset() {
  start = std::chrono::high_resolution_clock::now();
}
  
unsigned long long StopWatch::milli() const {
  std::chrono::high_resolution_clock::time_point stop = std::chrono::high_resolution_clock::now();
  auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start);
  return ms.count();
}
  
double StopWatch::sec() const {
  std::chrono::high_resolution_clock::time_point stop = std::chrono::high_resolution_clock::now();
  return std::chrono::duration<double>(stop - start).count();
}

void StopWatch::spin( double fps ) {
  reset();
  while( sec() < 1/fps );
}



bool Every::isTime() {
  double now = watch.sec();
  double diff = now - last;
  bool istime = 0;
  if( diff > interval ) {
    istime = true;
    last = now;
  }
  return istime;
}


bool After::isTime() {
  if( done )  return 0;

  if( watch.sec() > when )
    done = 1;
    
  return done;
}
