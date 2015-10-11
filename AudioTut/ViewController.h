//
//  ViewController.h
//  AudioTut
//
//  Created by Quix Creations Singapore iOS 1 on 31/8/15.
//  Copyright © 2015 Terry Chia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Recording.h"

@interface ViewController : UIViewController <AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIProgressView *myProgressView;
@property (strong, nonatomic) IBOutlet UISlider *sliderVolumeOutlet;

- (IBAction)sliderVolumeAction:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;

@property(strong,nonatomic) AVAudioRecorder *audioRecorder;
@property(strong,nonatomic) AVAudioPlayer *audioPlayer;


- (IBAction)recordButton:(id)sender;
- (IBAction)stopRecordingButton:(id)sender;
- (IBAction)pauseRecordingButton:(id)sender;
- (IBAction)RecordingPlayButton:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *sliderRecordVolumeOutlet;
@property (strong, nonatomic) IBOutlet UILabel *recordTimeLabel;

- (IBAction)recordVolumeAction:(id)sender;


@end



