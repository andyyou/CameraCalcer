//
//  ViewController.h
//  CameraCalcer
//
//  Created by AndyYou on 13/2/26.
//  Copyright (c) 2013年 AndyYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    //toturial: http://goo.gl/JYFkw
    
    IBOutlet UILabel *lbCameraType;
    IBOutlet UITextField *txtSystemFov;
    IBOutlet UITextField *txtSpeed;
    IBOutlet UITextField *txtMdCdRatio;
    IBOutlet UITextField *txtCdRez;
    IBOutlet UITextField *txtLens;
    IBOutlet UITextField *txtLimits;
    
    NSMutableArray *searchWhereOptions;
    UIActionSheet *actionSheet;
    NSInteger selectedOption;
}
- (IBAction) showSearchWhereOptions;

@end
