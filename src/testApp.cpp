#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    for(int i=0; i<N_VIDEO_PLAYERS; i++) {
        videoPlayers.push_back(new ofxAVFVideoPlayer());
        videoPlayers[i]->loadMovie("EmeliSande_NextToMe.mov");
    }
    
    
    ofSetVerticalSync(true);
    
}

//--------------------------------------------------------------
void testApp::update(){
    int i=0;
    for(auto p : videoPlayers) {
        p->update();
        if(true || p->isLoaded()) {
            if(ofGetElapsedTimef() > i++ * 0.5)
                p->play();
        }
    }
    
    //cout << ofGetFrameRate() << endl;
}

//--------------------------------------------------------------
void testApp::draw(){
    int i=0;
    for(auto p : videoPlayers) {
        p->draw(ofMap(i++, 0, videoPlayers.size(), 0, ofGetWidth()), ofGetHeight()/2 - 108*2, 192*4, 108*4);
    }

}

//--------------------------------------------------------------
void testApp::keyPressed(int key){
    switch(key) {
        case '1':
            videoPlayers[0]->loadMovie("IntroVideo7.mov");
            break;
        case '2':
            videoPlayers[1]->loadMovie("TheLumineers_1.mov");
            break;
        case '3':
            videoPlayers[2]->loadMovie("EmeliSande_NextToMe.mov");
            break;
        case '4':
            videoPlayers[3]->loadMovie("iHRMF2012_SwedishHouseMafia_DontWorryChild.mov");
            break;
    }
//    videoPlayer2.loadMovie("IntroVideo7.mov");
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void testApp::dragEvent(ofDragInfo dragInfo){ 

}