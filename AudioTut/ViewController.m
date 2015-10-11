//
//  ViewController.m
//  AudioTut
//
//  Created by Quix Creations Singapore iOS 1 on 31/8/15.
//  Copyright © 2015 Terry Chia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    AVAudioPlayer *avPlayer;            //instance variable
    AVAudioRecorder *avRecordPlayer;
    int timeSec ;
    int timeMin ;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /***************Player******************/
    NSString *stringPath = [[NSBundle mainBundle]pathForResource:@"BLANK SPACE - Taylor Swift (The Sam Willows Cover)" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:stringPath];
    NSError *error;
    avPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [avPlayer setNumberOfLoops:0];
    [avPlayer setVolume:self.sliderVolumeOutlet.value];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updatemyProgress) userInfo:nil repeats:YES];
    
    /****************Recorder********************/
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *errorRecording = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    self.audioRecorder = [[AVAudioRecorder alloc]initWithURL:soundFileURL settings:recordSettings error:&errorRecording];
    
    if (errorRecording) {
        NSLog(@"errorRecording %@",[errorRecording localizedDescription]);
    }else{
        [self.audioRecorder prepareToRecord];
    }
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


/******************************Recorder************************************/
- (IBAction)recordButton:(id)sender {
    
    if (!self.audioRecorder.recording) {
        [self.audioRecorder record];
        
        [self startTimer];
    }
}

-(void) startTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)timerTick:(NSTimer *)timer{
    timeSec++;
    if (timeSec == 60) {
        timeSec =0;
        timeMin++;
    }
    
    NSString *timeNow = [NSString stringWithFormat:@"%02d:%02d",timeMin,timeSec];
    self.recordTimeLabel.text = timeNow;
    self.recordTimeLabel.textColor = [UIColor redColor];
}

-(void) stopTimer {
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    
    NSString *timeNow = [NSString stringWithFormat:@"%02d:%02d",timeMin,timeSec];
    self.recordTimeLabel.text =timeNow;
    self.recordTimeLabel.textColor = [UIColor blackColor];
}


-(IBAction)stopRecordingButton:(id)sender{
    
    if (self.audioRecorder.recording) {
        [self.audioRecorder stop];
        [self stopTimer];
    }else if (self.audioPlayer.playing){
        [self.audioPlayer stop];
    }
}

- (IBAction)pauseRecordingButton:(id)sender {
    
}

- (IBAction)RecordingPlayButton:(id)sender {
    
    if (!self.audioRecorder.recording) {
        
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.audioRecorder.url error:&error];
        
        self.audioPlayer.delegate = self; //what does this means?
        
        if (error) {
            NSLog(@"Error %@",[error localizedDescription]);
        }else{
            [self.audioPlayer play];
        }
    }
}

//DELEGATE METHODS
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"Decode Error Occured");
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"Encode Error Occured");
}

- (IBAction)recordVolumeAction:(id)sender {
    UISlider *recordVolSlider = sender;
    [self.audioPlayer setVolume:recordVolSlider.value];
}
@end
