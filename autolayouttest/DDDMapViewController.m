//
//  DDDMapViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 24/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapViewController.h"
#import "DDDLocalSearchManager.h"

@interface DDDMapViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *mapSearchTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (strong, nonatomic) DDDLocalSearchManager *searchManager;

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
	
	self.mapView.showsUserLocation = YES;
	
	[self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
	self.defaultTextfieldOffset = CGPointZero;
	
	self.searchManager = [[DDDLocalSearchManager alloc] init];
}

- (void)viewTapped:(UIGestureRecognizer *)gestureRecognizer
{
	[self.view endEditing:YES];
}

- (void)textFieldContentsChanged:(UITextField *)textField
{
	NSString *contents = textField.text;
	MKCoordinateRegion region = self.mapView.region;
	[self.searchManager localSearchWithQuery:contents withRegion:region withHandler:^(NSArray *results, NSError *error) {
		[self.mapView setSelectedAnnotations:[self mapAnnotationsForLocalSearchResults:results]];
	}];
}

- (NSArray *)mapAnnotationsForLocalSearchResults:(NSArray *)searchResults
{
	NSMutableArray *annotations = [NSMutableArray array];
	for (MKMapItem *item in searchResults)
	{
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
		annotation.coordinate = item.placemark.coordinate;
		annotation.title = item.name;
		[annotations addObject:annotation];
	}
	return annotations;
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
