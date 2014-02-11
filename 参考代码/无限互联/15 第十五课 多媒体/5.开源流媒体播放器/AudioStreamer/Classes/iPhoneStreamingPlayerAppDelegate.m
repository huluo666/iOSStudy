//
//  iPhoneStreamingPlayerAppDelegate.m
//  iPhoneStreamingPlayer
//
//  Created by Matt Gallagher on 28/10/08.
//  Copyright Matt Gallagher 2008. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import "iPhoneStreamingPlayerAppDelegate.h"
#import "iPhoneStreamingPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>


@implementation iPhoneStreamingPlayerAppDelegate

@synthesize window;
@synthesize viewController;

void interruptionListenerCallback(void *inClientData, UInt32 inInterruptionState)              
{
    
}

void myAudioFileStream_PropertyListenerProc(
                                            void *						inClientData,
                                            AudioFileStreamID			inAudioFileStream,
                                            AudioFileStreamPropertyID	inPropertyID,
                                            UInt32 *					ioFlags) 
{
    NSLog(@"myAudioFileStream_PropertyListenerProc");
}

void myAudioQueueOutputCallback(
                          void *                  inUserData,
                          AudioQueueRef           inAQ,
                          AudioQueueBufferRef     inBuffer)
{

}

void myAudioFileStream_PacketsProc(
                                   void *							inClientData,
                                   UInt32							inNumberBytes,
                                   UInt32							inNumberPackets,
                                   const void *					inInputData,
                                   AudioStreamPacketDescription	*inPacketDescriptions)
{
    NSLog(@"myAudioFileStream_PacketsProc");  
    iPhoneStreamingPlayerAppDelegate *appDelegate = (iPhoneStreamingPlayerAppDelegate *)inClientData;
    AudioStreamBasicDescription audionFormat = appDelegate->audionFormat;
    AudioFileStreamID audionFileStream = appDelegate->audionFileStream;
    AudioQueueRef audionQueue = appDelegate->audionQueue;
    
    UInt32 audio_format_size = sizeof(audionFormat);
    AudioFileStreamGetProperty(audionFileStream,  kAudioFileStreamProperty_DataFormat, &audio_format_size, &audionFormat);
    
    
    Float32 outValue ; 
    AudioQueueGetParameter(audionQueue,kAudioQueueDeviceProperty_NumberChannels,&outValue) ;    
    
    AudioQueueNewOutput(&audionFormat, &myAudioQueueOutputCallback, (void*)appDelegate, [[NSRunLoop currentRunLoop] getCFRunLoop], kCFRunLoopCommonModes, 0, &audionQueue);    
    
    AudioQueueStart(audionQueue, nil);
}


- (void)initAudionSession {
	AudioSessionInitialize (NULL, NULL, interruptionListenerCallback, self);
	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
	AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
	UInt32 doSetProperty = 0;
	AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers,sizeof (doSetProperty),&doSetProperty);
	AudioSessionSetActive (true);    
}

- (void)playAudion:(NSData *)data {
    OSStatus error;
    if (!audionFileStream) {
        error = AudioFileStreamOpen((void*)self, 
                                    &myAudioFileStream_PropertyListenerProc, 
                                    &myAudioFileStream_PacketsProc, 
                                    0, 
                                    &audionFileStream);        
    }

    if (error) {
        NSLog(@"error");
    }
    AudioSessionSetActive (true);
    
    error = AudioFileStreamParseBytes(audionFileStream, [data length], [data bytes], kAudioFileStreamProperty_FileFormat);    
    if (error) {
        NSLog(@"error2");
    }
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *musicPath = [[bundle resourcePath] stringByAppendingPathComponent:@"10033994.m4a"];
//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:musicPath];
//    
//    NSData *bufferData = [fileHandle readDataOfLength:2000];
//    unsigned long long offset = 2000;
//    int index = 1;
//    
//    [self initAudionSession];
//    [self playAudion:bufferData];
//    while (index < 50) {
////        [NSThread sleepForTimeInterval:1];
////        NSLog(@"%d",index);
////        seekToFileOffset
//        [fileHandle seekToFileOffset:offset*index];
//        bufferData = [fileHandle readDataOfLength:2000];
//        index++;
//        [self playAudion:bufferData];
//    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:@"notifyName" object:nil];
	
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"notify" forState:UIControlStateNormal];
    
    [window addSubview:viewController.view];
    //[window addSubview:btn];
    [window makeKeyAndVisible];	
	
//	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"urlList"];
//	NSString *urlListStr = [NSString stringWithContentsOfFile:path];
////	NSLog(@"%@",urlListStr);
//	NSArray *array = [urlListStr componentsSeparatedByString:@"\n"];
//	for (NSString *url in array) {
//		NSLog(@"%@\n",url);
//	}
	
}

- (void)notificationAction {
    [NSThread sleepForTimeInterval:2];
    NSLog(@"this is notify action");
}

- (void)btnAction {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyName" object:nil];
    [self performSelectorInBackground:@selector(newThread) withObject:nil];
    [self performSelectorInBackground:@selector(newThread) withObject:nil];
    //NSLog(@"notify final");
}

static int j = 0;

- (void)newThread {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyName" object:nil];   
    @synchronized(self){
        for (int i =0; i<5; i++) {
            j++;
            NSLog(@"%d",j);
        }
    }
    
    [pool release];
}

-(void)actionTime {
	NSLog(@"success!");
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}


@end
