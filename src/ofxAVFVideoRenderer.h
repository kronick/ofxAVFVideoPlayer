

//
//  ofxAVFVideoRenderer.h
//  AVFoundationTest
//
//  Created by Sam Kronick on 5/31/13.
//
//


#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenGL/OpenGL.h>

@interface AVFVideoRenderer : NSObject
{
    AVPlayer *player;
    AVPlayerItem *playerItem;
    AVPlayerLayer *playerLayer;
    AVAssetReader *videoReader;
    
    CARenderer *layerRenderer;
    
    CGSize videoSize;
    
    BOOL loading;
    BOOL ready;
}
    @property (nonatomic, retain) AVPlayer *player;
    @property (nonatomic, retain) AVPlayerItem *playerItem;
    @property (nonatomic, retain) AVPlayerLayer *playerLayer;
    @property (nonatomic, retain) AVAssetReader *videoReader;
    @property (nonatomic, retain) CARenderer *layerRenderer;

- (void) loadFile:(NSString *)filename;
- (void) play;
- (void) stop;
- (void) playerItemDidReachEnd:(NSNotification *) notification;
//- (void) update;
- (BOOL) isReady;
- (BOOL) isLoading;
- (void) render;

- (CGSize) getVideoSize;
@end
