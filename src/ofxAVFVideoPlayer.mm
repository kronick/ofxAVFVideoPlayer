//
//  ofxAVFoundationvVideoPlayer.mm
//  AVFoundationTest
//
//  Created by Sam Kronick on 5/31/13.
//
//

#include "ofxAVFVideoPlayer.h"
#include "Poco/String.h"

ofxAVFVideoPlayer::ofxAVFVideoPlayer() {
    moviePlayer = NULL;
	bNewFrame = false;
    bPaused = true;
	duration = 0.0f;
    speed = 1.0f;
    
    bInitialized = false;
    
    pixelFormat = OF_PIXELS_RGB;
    currentLoopState = OF_LOOP_NORMAL;
    
}

ofxAVFVideoPlayer::~ofxAVFVideoPlayer() {
    close();
}

bool ofxAVFVideoPlayer::loadMovie(string path) {
    bInitialized = false;
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    moviePlayer = [[AVFVideoRenderer alloc] init];
    bool isURL = false;
	
    if (Poco::icompare(path.substr(0,7), "http://")  == 0 ||
        Poco::icompare(path.substr(0,8), "https://") == 0 ||
        Poco::icompare(path.substr(0,7), "rtsp://")  == 0) {
        isURL = true;
    }
    else {
        path = ofToDataPath(path, false);
    }
    
    [moviePlayer loadFile:[NSString stringWithUTF8String:path.c_str()]];
    
    
    [pool release];
    
    return true;
}

void ofxAVFVideoPlayer::closeMovie() {
    close();
}

void ofxAVFVideoPlayer::close() {
    pixels.clear();
    if(moviePlayer){
        [moviePlayer release];
        moviePlayer = NULL;
    }
    bInitialized = false;
}

void ofxAVFVideoPlayer::idleMovie() {
    
}

void ofxAVFVideoPlayer::update() {
    if(!moviePlayer) return;
    if([moviePlayer isReady]) {
        if(!bInitialized) {
            // Create the FBO
            fbo.allocate([moviePlayer getVideoSize].width, [moviePlayer getVideoSize].height);
            bInitialized = true;
        }
        
        // Render movie into FBO so we can get a texture

        fbo.begin();
        [moviePlayer render];
        fbo.end();
        
        bHavePixelsChanged = true;
    }
    else {
        ofLogNotice("Movie player not ready.");
    }
}

void ofxAVFVideoPlayer::play() {
    [moviePlayer play];
}

void ofxAVFVideoPlayer::stop() {
    [moviePlayer stop];
}

bool ofxAVFVideoPlayer::isFrameNew() {
    return true;
}

unsigned char* ofxAVFVideoPlayer::getPixels() {
    if(!moviePlayer || ![moviePlayer isReady] || !bInitialized) return NULL;
        
    if(bHavePixelsChanged) {
        fbo.readToPixels(pixels);
        bHavePixelsChanged = false; // Don't read pixels until next update() is called
    }
    
    return pixels.getPixels();
}

ofPixelsRef ofxAVFVideoPlayer::getPixelsRef() {
    getPixels();
    return pixels;
}

ofTexture* ofxAVFVideoPlayer::getTexture() {
    if(!moviePlayer || ![moviePlayer isReady] || !bInitialized) return NULL;
    
    return &fbo.getTextureReference();
}

ofTexture& ofxAVFVideoPlayer::getTextureReference() {
    if(!moviePlayer || ![moviePlayer isReady] || !bInitialized) return;
    
    return fbo.getTextureReference();
}

float ofxAVFVideoPlayer::getPosition() {
    // Return a fraction between 0 and 1 representing the position of the playhead
    return CMTimeGetSeconds([[moviePlayer player] currentTime]) / CMTimeGetSeconds([moviePlayer getVideoDuration]);
}

float ofxAVFVideoPlayer::getPositionInSeconds() {
    return CMTimeGetSeconds([[moviePlayer player] currentTime]);
}

float ofxAVFVideoPlayer::getSpeed() {
    
}

ofLoopType ofxAVFVideoPlayer::getLoopState() {
    
}

float ofxAVFVideoPlayer::getDuration() {
    return CMTimeGetSeconds([moviePlayer getVideoDuration]);
}

bool ofxAVFVideoPlayer::getIsMovieDone() {
    
}

int ofxAVFVideoPlayer::getTotalNumFrames() {
    
}

int ofxAVFVideoPlayer::getCurrentFrame() {
    
}

void ofxAVFVideoPlayer::setPaused(bool bPaused) {
    
}

void ofxAVFVideoPlayer::setPosition(float pct) {
    [[moviePlayer player] seekToTime:CMTimeMakeWithSeconds(getDuration() * pct, [moviePlayer getVideoDuration].timescale)];
}

void ofxAVFVideoPlayer::setVolume(float volume) {
    
}

void ofxAVFVideoPlayer::setBalance(float balance) {
    
}

void ofxAVFVideoPlayer::setLoopState(ofLoopType state) {
    
}

void ofxAVFVideoPlayer::setSpeed(float speed) {
    
}

void ofxAVFVideoPlayer::setFrame(int frame) {
    
}

bool ofxAVFVideoPlayer::setPixelFormat(ofPixelFormat pixelFormat) {
    
}

ofPixelFormat ofxAVFVideoPlayer::getPixelFormat() {
    
}

void ofxAVFVideoPlayer::draw(float x, float y, float w, float h) {
    if(!bInitialized) return;
    fbo.draw(x, y, w, h);
}

void ofxAVFVideoPlayer::draw(float x, float y) {
    if(!bInitialized) return;
    fbo.draw(x, y);
}

float ofxAVFVideoPlayer::getWidth() {
    return [moviePlayer getVideoSize].width;
}

float ofxAVFVideoPlayer::getHeight() {
    return [moviePlayer getVideoSize].height;
}

bool ofxAVFVideoPlayer::isPaused() {
    return [moviePlayer player].rate == 0;
}

bool ofxAVFVideoPlayer::isLoading() {
    return [moviePlayer isLoading];
}

bool ofxAVFVideoPlayer::isLoaded() {
    return bInitialized;
}

bool ofxAVFVideoPlayer::errorLoading() {
    if(!moviePlayer) return false;
    
    // Error if movie player is not loading and is not ready
    return (![moviePlayer isLoading] && ![moviePlayer isReady]);
}

bool ofxAVFVideoPlayer::isPlaying() {
    
}

void ofxAVFVideoPlayer::firstFrame() {
    
}

void ofxAVFVideoPlayer::nextFrame() {
    
}

void ofxAVFVideoPlayer::previousFrame() {
    
}

void ofxAVFVideoPlayer::updateTexture() {
    
}

void ofxAVFVideoPlayer::reallocatePixels() {
    
}