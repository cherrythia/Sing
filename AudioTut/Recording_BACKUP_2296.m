//
//  Recording.m
//  AudioTut
//
//  Created by Quix Creations Singapore iOS 1 on 31/8/15.
//  Copyright © 2015 Terry Chia. All rights reserved.
//

#import "Recording.h"

<<<<<<< HEAD
@interface Recording ()
=======
@interface Recording (){
    AVAudioRecorder *avRecordPlayer;
    AVAudioPlayer *avPlayer;
    int timeSec;
    int timeMin;
    NSTimer *timer;
    
    CGSize intrinsicContentSize;
}
>>>>>>> d63989889ef14aa295ed8260788ba5ff811c5313

@end

@implementation Recording

<<<<<<< HEAD
=======
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //initialization code
        
        //1.load xib
        [[NSBundle mainBundle] loadNibNamed:@"Recording" owner:self options:nil];
        
        //2.adjust bounds
        NSLog(@"Frame %@",NSStringFromCGRect(self.recordingView.bounds));
        self.bounds = self.recordingView.bounds;
        intrinsicContentSize = self.recordingView.bounds.size;
        
        //3. add as a subview
        [self addSubview:self.recordingView];
    }
    
    return  self;
}

>>>>>>> d63989889ef14aa295ed8260788ba5ff811c5313
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //load the interface files from .xib
        [[NSBundle mainBundle] loadNibNamed:@"Recording" owner:self options:nil];
<<<<<<< HEAD
    
=======
        
        self.bounds = self.recordingView.bounds;            //This is important
>>>>>>> d63989889ef14aa295ed8260788ba5ff811c5313
        //2. add a subview
        [self addSubview:self.recordingView];
    }
    return  self;
}

<<<<<<< HEAD

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
=======
-(CGSize)intrinsicContentSize{
    return intrinsicContentSize;
}

-(void)didAddSubview:(UIView *)subview{
    
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
>>>>>>> d63989889ef14aa295ed8260788ba5ff811c5313

@end
