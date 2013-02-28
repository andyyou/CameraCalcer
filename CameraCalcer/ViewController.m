//
//  ViewController.m
//  CameraCalcer
//
//  Created by AndyYou on 13/2/26.
//  Copyright (c) 2013年 AndyYou. All rights reserved.
//

#import "ViewController.h"
#import "AnswerViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluepoint.png"]];
    searchWhereOptions = [[NSMutableArray alloc] init];
    [searchWhereOptions addObject:@"7500HS"];
    [searchWhereOptions addObject:@"7500LS"];
    [searchWhereOptions addObject:@"8K-320"];
    [searchWhereOptions addObject:@"8K-640"];
    [searchWhereOptions addObject:@"5150"];
    
    // default list option to select
    selectedOption = 0;
    
    // add gesture
    /*
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tapRecognizer setDelegate:self];
    [tapRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapRecognizer];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAlert:)]; 
   [txtInput addGestureRecognizer:tapGestureRecognizer];
     */
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [lbCameraType release];
    [txtMdCdRatio release];
    [txtCdRez release];
    [txtLens release];
    [txtSpeed release];
    [txtSystemFov release];
    [txtLimits release];
    [super dealloc];
}
#pragma mark-
#pragma mark Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [searchWhereOptions count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [searchWhereOptions objectAtIndex:row];
    
}

// this method runs whenever the user changes the selected list option

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // update label text to show selected option
    lbCameraType.text = [searchWhereOptions objectAtIndex:row];
    
    // keep track of selected option (for next time we open the picker)
    selectedOption = row;
    
}
- (IBAction) showSearchWhereOptions {
    
    // create action sheet
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    // create frame for picker view
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    // create picker view
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // set selected option to what was previously selected
    [pickerView selectRow:selectedOption inComponent:0 animated:NO];
    
    // add picker view to action sheet
    [actionSheet addSubview:pickerView];
    [pickerView release];
    // create close button to hide action sheet
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
    
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    
    // link close button to our dismissActionSheet method
    [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    // show action sheet
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
}
- (void) dismissActionSheet {
    
    // hide action sheet
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showAlert:textField];
}
-(void)showAlert:(UITextField *)textField {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"INPUT"
                                                        message:@"Enter the value"
                                                       delegate:self
                                              cancelButtonTitle:@"Clear"
                                              otherButtonTitles:@"Done", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    txtInput = [alertView textFieldAtIndex:0];
    txtInput.tag = textField.tag;
    txtInput.placeholder = textField.placeholder;
    [txtInput setKeyboardType:UIKeyboardTypeDecimalPad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [alertView show];
    });
    
    [alertView release];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        switch (txtInput.tag )
        {
            case 1:
                txtSystemFov.text = @"";
                break;
            case 2:
                txtSpeed.text = @"";
                break;
            case 3:
                txtMdCdRatio.text = @"";
                break;
            case 4:
                txtCdRez.text = @"";
                break;
            case 5:
                txtLens.text = @"";
                break;
            case 6:
                txtLimits.text = @"";
                break;
            default:
                break;
        }

        return;
    }
    txtInput = [alertView textFieldAtIndex:0];
    if(![txtInput.text isEqualToString:@""])
    {
        switch (txtInput.tag )
        {
            case 1:
                txtSystemFov.text = txtInput.text;
                break;
            case 2:
                txtSpeed.text = txtInput.text;
                break;
            case 3:
                txtMdCdRatio.text = txtInput.text;
                break;
            case 4:
                txtCdRez.text = txtInput.text;
                break;
            case 5:
                txtLens.text = txtInput.text;
                break;
            case 6:
                txtLimits.text = txtInput.text;
                break;
            default:
                break;
        }
    }
}
/*
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}
 */
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"forAnswer"]) {
        
        if([txtCdRez.text isEqualToString:@""] | [txtLens.text isEqualToString:@"" ] | [txtLimits.text isEqualToString:@""] | [txtMdCdRatio.text isEqualToString:@""] | [txtSpeed.text isEqualToString:@""] | [txtSystemFov.text isEqualToString:@""])
        {
            UIAlertView *notPermitted = [[UIAlertView alloc]
                                         initWithTitle:@"Alert"
                                         message:@"Some value is empty"
                                         delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
            
            // shows alert to user
            [notPermitted show];
            
            // prevent segue from occurring
            return NO;
        }
    }
    
    // by default perform the segue transition
    return YES;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    AnswerViewController* answerViewController = (AnswerViewController *) [segue destinationViewController];
    answerViewController.camreaType = lbCameraType.text;
    
    answerViewController.systemFov = [txtSystemFov.text doubleValue];
    answerViewController.speed = [txtSpeed.text doubleValue];
    answerViewController.cdRez = [txtCdRez.text doubleValue];
    answerViewController.mdCdRation = [txtMdCdRatio.text doubleValue];
    answerViewController.limits = [txtLimits.text doubleValue];
    answerViewController.lens = [txtLens.text doubleValue];
    
}



@end
