//
//  DDDMapViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 24/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapViewController.h"

@interface DDDMapViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *mapSearchTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerVIew;

@property (nonatomic, assign) CGPoint defaultTextfieldOffset;
@end

@implementation DDDMapViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.mapSearchTextField addTarget:self action:@selector(textFieldContentsChanged:) forControlEvents:UIControlEventEditingChanged];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	self.defaultTextfieldOffset = self.mapSearchTextField.frame.origin;
}

- (void)textFieldContentsChanged:(UITextField *)textField
{
	
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	[self.scrollView setContentOffset:self.mapSearchTextField.frame.origin animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	[self.scrollView setContentOffset:self.defaultTextfieldOffset animated:YES];
}

@end
