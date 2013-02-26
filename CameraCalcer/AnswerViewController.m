//
//  AnswerViewController.m
//  CameraCalcer
//
//  Created by AndyYou on 13/2/27.
//  Copyright (c) 2013年 AndyYou. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController
@synthesize parameterString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluepoint.png"]];
    lbAnswer.text = parameterString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) backMainView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
}


@end
