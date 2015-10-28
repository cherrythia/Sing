//
//  Recording.m
//  AudioTut
//
//  Created by Quix Creations Singapore iOS 1 on 31/8/15.
//  Copyright © 2015 Terry Chia. All rights reserved.
//

#import "Recording.h"

@interface Recording ()

@end

@implementation Recording

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //load the interface files from .xib
        [[NSBundle mainBundle] loadNibNamed:@"Recording" owner:self options:nil];
    
        //2. add a subview
        [self addSubview:self.recordingView];
    }
    return  self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
