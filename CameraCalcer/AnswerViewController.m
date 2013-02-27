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
@synthesize limits;
@synthesize lens;


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
    [dicCamMhzs setObject:[NSNumber numberWithDouble:640] forKey:@"8K-640"];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:320] forKey:@"8K-320"];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:78.3] forKey:@"7500HS"];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:38.3] forKey:@"7500LS"];
    [dicCamMhzs setObject:[NSNumber numberWithDouble:32] forKey:@"5150"];
    
    // Camera Type
    NSMutableDictionary *dicCamNo = [[NSMutableDictionary alloc]init];
    [dicCamNo setObject:[NSNumber numberWithInt:1] forKey:@"5150"];
    [dicCamNo setObject:[NSNumber numberWithInt:2] forKey:@"7500LS"];
    [dicCamNo setObject:[NSNumber numberWithInt:3] forKey:@"7500HS"];
    [dicCamNo setObject:[NSNumber numberWithInt:4] forKey:@"8K-320"];
    [dicCamNo setObject:[NSNumber numberWithInt:5] forKey:@"8K-640"];
 
    // Camera
    NSMutableDictionary *dicCamAvg = [[NSMutableDictionary alloc]init];
    [dicCamAvg setObject:[NSNumber numberWithDouble:8250] forKey:@"8K-320"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:8250] forKey:@"8K-640"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:7620] forKey:@"7500HS"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:7620] forKey:@"7500LS"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:5244] forKey:@"5150"];
    
    // Mask default value
    // Camera
    NSMutableDictionary *dicMaskValue = [[NSMutableDictionary alloc]init];
    [dicMaskValue setObject:[NSNumber numberWithDouble:8192] forKey:@"8K-320"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:8192] forKey:@"8K-640"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:7448] forKey:@"7500HS"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:7448] forKey:@"7500LS"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:5148] forKey:@"5150"];
    
    // Mask default value
    // Camera
    NSMutableDictionary *dicMaskDiscount = [[NSMutableDictionary alloc]init];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:0] forKey:@"8K-320"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:0] forKey:@"8K-640"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:417] forKey:@"7500HS"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:417] forKey:@"7500LS"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:357] forKey:@"5150"];
    
    // Mask default value
    // Camera
    NSMutableDictionary *dicWdDivisor = [[NSMutableDictionary alloc]init];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"8K-320"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"8K-640"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.0047] forKey:@"7500HS"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.0047] forKey:@"7500LS"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"5150"];
    
    
    lbAnswer.text = camreaType;
    NSNumber *mdRez = [NSNumber numberWithFloat:[mdCdRation floatValue]*[cdRez floatValue]];
    lbMDRez.text = [mdRez stringValue];
    
    NSNumber *linesPerSecond = [NSNumber numberWithDouble:[speed doubleValue] * 1000 / 60];
    lbLinePerSecond.text = [NSString stringWithFormat:@"%.0f",[linesPerSecond floatValue]];
    
    
    NSNumber *tmpShiftCycles = [NSNumber numberWithDouble: [[dicCamMhzs objectForKey:camreaType] doubleValue] * 1000000 / [linesPerSecond floatValue]];
    NSNumber *shiftCycles = (tmpShiftCycles > [dicCamAvg objectForKey:camreaType])? [dicCamAvg objectForKey:camreaType]: tmpShiftCycles;
    lbShiftCycles.text = [NSString stringWithFormat:@"%.f", [shiftCycles floatValue]];
    
    NSNumber *I = (shiftCycles < [dicCamAvg objectForKey:camreaType])? [NSNumber numberWithInt: 1]:[NSNumber numberWithInt:0];
    NSNumber *mask = ([dicCamNo objectForKey:camreaType] > [NSNumber numberWithInt: 3]) ? [NSNumber numberWithInt:0] :I;
    lbMask.text = [mask stringValue];
    
    NSNumber *numberPixelsPerCcd;
    if(mask == 0)
    {
        numberPixelsPerCcd = [dicMaskValue objectForKey:camreaType];
    }else
    {
        numberPixelsPerCcd =  [NSNumber numberWithDouble:[shiftCycles floatValue] - [[dicMaskDiscount objectForKey:camreaType] floatValue]];
    }
    lbPxPerCCD.text = [NSString stringWithFormat:@"%.f", [numberPixelsPerCcd floatValue]];
    
    NSNumber *bestPossibleCdRez = [NSNumber numberWithDouble: [systemFov doubleValue] * ([limits doubleValue] / [numberPixelsPerCcd doubleValue])];
    lbBestPossibleCDRez.text = [NSString stringWithFormat:@"%.6f", [bestPossibleCdRez floatValue]];
    
    NSNumber *wd = [NSNumber numberWithDouble: [bestPossibleCdRez doubleValue] * [lens doubleValue] / [[dicWdDivisor objectForKey:camreaType] doubleValue] ];
    lbWd.text =  [NSString stringWithFormat:@"%.2f", [wd floatValue]];

    NSNumber *camFov = [NSNumber numberWithDouble:[systemFov doubleValue] / [limits doubleValue]];
    CamFovIn.text = [NSString stringWithFormat:@"%.2f", [camFov floatValue]];
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
