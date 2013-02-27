//
//  AnswerViewController.h
//  CameraCalcer
//
//  Created by AndyYou on 13/2/27.
//  Copyright (c) 2013年 AndyYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController
{
    IBOutlet UILabel *lbAnswer;
    IBOutlet UILabel *lbMDRez;
    IBOutlet UILabel *lbLinePerSecond;
    IBOutlet UILabel *lbShiftCycles;
    IBOutlet UILabel *lbMask;
    IBOutlet UILabel *lbPxPerCCD;
    IBOutlet UILabel *lbBestPossibleCDRez;
    IBOutlet UILabel *lbWd;
    IBOutlet UILabel *CamFovIn;
    NSString* camreaType;
    double systemFov;
    double speed;
    double cdRez;
    double mdCdRation;
    double limits;
    double lens;
    
}

-(IBAction) backMainView:(id)sender;
@property (nonatomic, retain) NSString* camreaType;
@property (nonatomic, assign) double systemFov;
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) double cdRez;
@property (nonatomic, assign) double mdCdRation;
@property (nonatomic, assign) double limits;
@property (nonatomic, assign) double lens;
@end
