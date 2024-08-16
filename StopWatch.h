#pragma once

#include <chrono>
#include <string>
using std::string;

struct StopWatch {
  string name;
  bool autoprint;
  std::chrono::high_resolution_clock::time_point start;
  
  StopWatch( string iname = "unnamed timer", bool iAutoprint = 0 );
  ~StopWatch();
  void reset();
  unsigned long long milli() const;
  double sec() const;
  void spin( double fps );
};

struct Every {
  StopWatch watch;
  double interval = 0, last = 0;

  Every( double iInterval ) :
    interval( iInterval ) {
  }

  // Returns true ONCE every interval seconds (1st time you call it)
  bool isTime();
};

struct After {
  StopWatch watch;
  double when = 1.;
  bool done = 0;

  After( double iWhen ) :
    when( iWhen ) {
  }
  
  // Only returns true ONCE, false every time after that
  bool isTime();
};


