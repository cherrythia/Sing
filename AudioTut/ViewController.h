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

@interface ViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UIProgressView *myProgressView;
@property (strong, nonatomic) IBOutlet UISlider *sliderVolumeOutlet;

- (IBAction)sliderVolumeAction:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;

@end



