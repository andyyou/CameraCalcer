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
    NSString* parameterString;
}

-(IBAction) backMainView:(id)sender;
@property (nonatomic, retain) NSString* parameterString;
@end
