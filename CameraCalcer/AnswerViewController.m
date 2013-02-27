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
    
    // Camera Type Serial Number
    NSMutableDictionary *dicCamNo = [[NSMutableDictionary alloc]init];
    [dicCamNo setObject:[NSNumber numberWithInt:1] forKey:@"5150"];
    [dicCamNo setObject:[NSNumber numberWithInt:2] forKey:@"7500LS"];
    [dicCamNo setObject:[NSNumber numberWithInt:3] forKey:@"7500HS"];
    [dicCamNo setObject:[NSNumber numberWithInt:4] forKey:@"8K-320"];
    [dicCamNo setObject:[NSNumber numberWithInt:5] forKey:@"8K-640"];
 
    // Camera Avger 
    NSMutableDictionary *dicCamAvg = [[NSMutableDictionary alloc]init];
    [dicCamAvg setObject:[NSNumber numberWithDouble:8250] forKey:@"8K-320"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:8250] forKey:@"8K-640"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:7620] forKey:@"7500HS"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:7620] forKey:@"7500LS"];
    [dicCamAvg setObject:[NSNumber numberWithDouble:5244] forKey:@"5150"];
    
    // Mask default value
    NSMutableDictionary *dicMaskValue = [[NSMutableDictionary alloc]init];
    [dicMaskValue setObject:[NSNumber numberWithDouble:8192] forKey:@"8K-320"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:8192] forKey:@"8K-640"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:7448] forKey:@"7500HS"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:7448] forKey:@"7500LS"];
    [dicMaskValue setObject:[NSNumber numberWithDouble:5148] forKey:@"5150"];
    
    // Mask discount value
    NSMutableDictionary *dicMaskDiscount = [[NSMutableDictionary alloc]init];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:0] forKey:@"8K-320"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:0] forKey:@"8K-640"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:417] forKey:@"7500HS"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:417] forKey:@"7500LS"];
    [dicMaskDiscount  setObject:[NSNumber numberWithDouble:357] forKey:@"5150"];
    
    // WD divisors
    NSMutableDictionary *dicWdDivisor = [[NSMutableDictionary alloc]init];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"8K-320"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"8K-640"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.0047] forKey:@"7500HS"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.0047] forKey:@"7500LS"];
    [dicWdDivisor setObject:[NSNumber numberWithDouble:0.07] forKey:@"5150"];
    
#pragma set answer
    //
    lbAnswer.text = camreaType;
    double mdRez = mdCdRation * cdRez;
    lbMDRez.text = [NSString stringWithFormat:@"%.0f", mdRez];
    //
    double linesPerSecond = speed * 1000 / 60;
    lbLinePerSecond.text = [NSString stringWithFormat:@"%.0f",linesPerSecond];
    //
    double tmpShiftCycles = [[dicCamMhzs objectForKey:camreaType] doubleValue] * 1000000 / linesPerSecond;
    double shiftCycles = (tmpShiftCycles > [[dicCamAvg objectForKey:camreaType] doubleValue]) ? [[dicCamAvg objectForKey:camreaType] doubleValue]: tmpShiftCycles;
    lbShiftCycles.text = [NSString stringWithFormat:@"%.0f", shiftCycles];
    //
    int other = (shiftCycles < [[dicCamAvg objectForKey:camreaType] doubleValue]) ? 1 : 0;
    int mask = ([[dicCamNo objectForKey:camreaType] doubleValue] > 3 ) ? 0 : other;
    lbMask.text = [NSString stringWithFormat:@"%d", mask];
    double numberPixelsPerCcd;
    if(mask == 0)
    {
        numberPixelsPerCcd = [[dicMaskValue objectForKey:camreaType] doubleValue];
    }else
    {
        numberPixelsPerCcd =  shiftCycles - [[dicMaskDiscount objectForKey:camreaType] floatValue];
    }
    lbPxPerCCD.text = [NSString stringWithFormat:@"%.0f", numberPixelsPerCcd];
    //
    double bestPossibleCdRez = systemFov * limits  / numberPixelsPerCcd;
    lbBestPossibleCDRez.text = [NSString stringWithFormat:@"%.6f", bestPossibleCdRez];
    //
    double wd = bestPossibleCdRez * lens / [[dicWdDivisor objectForKey:camreaType] doubleValue];
    lbWd.text =  [NSString stringWithFormat:@"%.2f", wd];
    //
    double camFov = systemFov / limits;
    CamFovIn.text = [NSString stringWithFormat:@"%.2f", camFov];
    
    [dicWdDivisor release];
    [dicCamAvg release];
    [dicMaskDiscount release];
    [dicMaskValue release];
    [dicCamMhzs release];
    [dicCamNo release];
    
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
