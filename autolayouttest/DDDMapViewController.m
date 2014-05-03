//
//  DDDMapViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 24/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapViewController.h"
#import "DDDMapViewModel.h"

@interface DDDMapViewController ()<UITextFieldDelegate, DDDMapViewModelListener>
@property (weak, nonatomic) IBOutlet MKMapView		*mapView;
@property (weak, nonatomic) IBOutlet UITextField	*mapSearchTextField;
@property (weak, nonatomic) IBOutlet UIScrollView	*scrollView;
@property (weak, nonatomic) IBOutlet UIView			*mainContainerView;
@property (weak, nonatomic) IBOutlet UIButton		*currentLocationButton;
@property (nonatomic, assign) CGPoint				defaultTextfieldOffset;
@property (weak, nonatomic) DDDMapViewModel			*viewModel;
@end

@implementation DDDMapViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.mapSearchTextField addTarget:self action:@selector(textFieldContentsChanged:) forControlEvents:UIControlEventEditingChanged];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	self.mapView.showsUserLocation = YES;
	
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
	self.defaultTextfieldOffset = CGPointZero;

}

- (void)viewTapped:(UIGestureRecognizer *)gestureRecognizer
{
	[self.view endEditing:YES];
}

#pragma mark - Textfield Actions
- (void)textFieldContentsChanged:(UITextField *)textField
{
	[self.viewModel localSearchWithQuery:textField.text region:self.mapView.region];
}

#pragma mark - Keyboard show/hide
- (void)keyboardWillShow:(NSNotification *)notification
{
	[self.scrollView setContentOffset:self.mapSearchTextField.frame.origin animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	[self.scrollView setContentOffset:self.defaultTextfieldOffset animated:YES];
}

#pragma mark - DDDMapViewModelListener methods
- (void)viewModel:(DDDMapViewModel *)viewModel didUpdateMapAnnotations:(NSArray *)mapAnnotations
{
	for (MKPointAnnotation *annotation in mapAnnotations)
	{	
		[self.mapView addAnnotation:annotation];
	}
}

- (void)viewModel:(DDDMapViewModel *)viewModel didUpdateSearchResults:(NSArray *)searchResults
{
	
}

#pragma mark - Button Events
- (IBAction)currentLocationButtonTapped:(id)sender
{
	if (self.viewModel.currentUserLocation)
	{
		[self.mapView setCenterCoordinate:self.viewModel.currentUserLocation.coordinate animated:YES];
	}
}

@end