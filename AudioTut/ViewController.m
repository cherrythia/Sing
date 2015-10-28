//
//  ViewController.m
//  AudioTut
//
//  Created by Quix Creations Singapore iOS 1 on 31/8/15.
//  Copyright © 2015 Terry Chia. All rights reserved.
//

#import "ViewController.h"
#import "Recording.h"

@interface ViewController (){
    AVAudioPlayer *avPlayer;            //instance variable

    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#pragma mark - Player
    
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"BLANK SPACE - Taylor Swift (The Sam Willows Cover)" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    NSError *error;
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [avPlayer setNumberOfLoops:0];
    [avPlayer setVolume:self.sliderVolumeOutlet.value];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updatemyProgress) userInfo:nil repeats:YES];
    
#pragma mark - Recording View
    
    Recording *recordingView = [[Recording alloc]init];
    [self.view addSubview:recordingView];
    recordingView.center = CGPointMake(250, 250);
    
    //Turn off autoresizing masks
    recordingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    //Pin to bottom
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:recordingView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                          toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //Pin to center X
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:recordingView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
}

-(void)updatemyProgress{
    
    float progress = [avPlayer currentTime] / [avPlayer duration];
    
    self.myProgressView.progress = progress;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderVolumeAction:(id)sender {
    
    UISlider *myslider = sender;
    [avPlayer setVolume:myslider.value];
}

- (IBAction)stopButton:(id)sender {
    [avPlayer stop];
    [avPlayer setCurrentTime:0];
}

- (IBAction)playButton:(id)sender {
    [avPlayer play];
}

- (IBAction)pauseButton:(id)sender {
    [avPlayer pause];
}

@end
