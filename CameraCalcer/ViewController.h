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
    NSMutableArray *searchWhereOptions;
    UIActionSheet *actionSheet;
    NSInteger selectedOption;
}
- (IBAction) showSearchWhereOptions;

@end
