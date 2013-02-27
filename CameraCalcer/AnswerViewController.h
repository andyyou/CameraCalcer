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
    NSNumber* systemFov;
    NSNumber* speed;
    NSNumber* cdRez;
    NSNumber* mdCdRation;
    NSNumber* limits;
    NSNumber* lens;
    
}

-(IBAction) backMainView:(id)sender;
@property (nonatomic, retain) NSString* camreaType;
@property (nonatomic, assign) NSNumber* systemFov;
@property (nonatomic, assign) NSNumber* speed;
@property (nonatomic, assign) NSNumber* cdRez;
@property (nonatomic, assign) NSNumber* mdCdRation;
@property (nonatomic, assign) NSNumber* limits;
@property (nonatomic, assign) NSNumber* lens;
@end
