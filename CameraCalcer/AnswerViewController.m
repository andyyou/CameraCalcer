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
@synthesize camreaType;
@synthesize systemFov;
@synthesize speed;
@synthesize cdRez;
@synthesize mdCdRation;


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
    // Camera Type MHz for value
    NSMutableDictionary *dicCamMhzs = [[NSMutableDictionary alloc]init];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:320] forKey:@"8K-320"];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:78.3] forKey:@"7500HS"];
    
    // Camera Type
    NSMutableDictionary *dicCamNo = [[NSMutableDictionary alloc]init];
    [dicCamNo setObject:[NSNumber numberWithInt:4] forKey:@"8K-320"];
    [dicCamNo setObject:[NSNumber numberWithInt:3] forKey:@"7500HS"];
 
    // Camera
    NSMutableDictionary *dicCamAvg = [[NSMutableDictionary alloc]init];
    [dicCamAvg setObject:[NSNumber numberWithDouble:8250] forKey:@"8K-320"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:7620] forKey:@"7500HS"];
    
    lbAnswer.text = camreaType;
    NSNumber *mdRez = [NSNumber numberWithFloat:[mdCdRation floatValue]*[cdRez floatValue]];
    lbMDRez.text = [mdRez stringValue];
    
    NSNumber *linesPerSecond = [NSNumber numberWithDouble:[speed doubleValue] * 1000 / 60];
    lbLinePerSecond.text = [NSString stringWithFormat:@"%.0f",[linesPerSecond floatValue]];
    
    
    NSNumber *tmpShiftCycles = [NSNumber numberWithDouble: [[dicCamMhzs objectForKey:camreaType] doubleValue] * 1000000 / [linesPerSecond floatValue]];
    NSNumber *shiftCycles = (tmpShiftCycles > [dicCamAvg objectForKey:camreaType])? [dicCamAvg objectForKey:camreaType]: tmpShiftCycles;
    lbShiftCycles.text = [shiftCycles stringValue];
    
    NSNumber *I = (shiftCycles < [dicCamAvg objectForKey:camreaType])? [NSNumber numberWithInt: 1]:[NSNumber numberWithInt:0];
    NSNumber *mask = ([dicCamNo objectForKey:camreaType] > [NSNumber numberWithInt: 3]) ? [NSNumber numberWithInt:0] :I;
    lbMask.text = [mask stringValue];
    
    
    
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
