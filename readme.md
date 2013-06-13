# ofxAVFVideoPlayer allows [openFrameworks](http://openframeworks.cc) apps to use the AV Foundation Framework for the best possible video playback on OSX 10.7+

## Installation
1. Clone this repository or copy its folder into the **addons** directory of openFrameworks
2. Drag and drop the files in the **src** directory into your Xcode project
3. Add the following **system frameworks** to your Xcode project (you can find them by right-clicking an existing system framework and selecting "show in finder"):
    - CoreMedia.framework
    - QuartzCore.framework
    - AVFoundation.framework

## Usage
**ofxAVFVideoPlayer** has an interface based on ofVideoPlayer. If you are using OSX 10.7 (Lion) or newer, it should be more or less a drop-in replacement. One major difference is that all media is loaded asynchronously, so there is an additional isLoaded() method on ofxAVFVideoPlayer to check if the file has completed loading. Any playback controls invoked before isLoaded() == true are not guaranteed to have an effect. Loading should happen very fast under most circumstances.

**ofxAVFVideoRenderer** is the native Objective-C code which creates and renders the video player object. You shouldn't interface with it directly.

## Performance
Loading and rendering should be very fast. Tests on a recent iMac show 10 HD ProRes 422 videos playing back simultaneously at about 30fps. Unlike the approach taken in ofxiPhone's AVFoundation implementation, the video is never processed by the CPU and the pixel data is never copied from video memory (unless you call *getPixels()*, which will copy the pixels from video memory no more than once for every time you call update [which should be once per frame])).

As far as I can tell, AV Foundation is the same framework that Quicktime X and Finder use for video playback, so you should get performance similar to what you can achieve by opening up a bunch of video files directly from Finder. This is much faster than the original ofVideoPlayer and has better multi-threaded and multi-video support than the QTKit framework.

## License
This addon is Copyright (C) 2013 Sosolimited and released under an MIT license. Use it as you wish, but keep the license file with it! See LICENSE.txt for more info.
