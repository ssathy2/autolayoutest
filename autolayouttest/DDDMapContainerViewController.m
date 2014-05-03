//
//  DDDMapContainerViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 01/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDMapContainerViewController.h"
#import "DDDMapViewController.h"
#import "DDDMapListViewController.h"
#import "DDDMainStoryboardIdentifiers.h"
#import "DDDMapViewModel.h"


typedef NS_ENUM(NSInteger, DDDResultsView)
{
	DDDResultsViewMap,
	DDDResultsViewList
};


@interface DDDMapContainerViewController ()<DDDMapViewModelListener>
@property (weak, nonatomic) DDDMapListViewController *mapListViewController;
@property (weak, nonatomic) DDDMapViewController	 *mapViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapListSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *resultsMapViewContainerView;
@property (weak, nonatomic) IBOutlet UIView *resultsMapListContainerView;

@end

@implementation DDDMapContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.viewModel = [[DDDMapViewModel alloc] init];
	[self.viewModel registerListener:self];
	
	[self showView:DDDResultsViewMap];
}

- (NSDictionary *)segueIdentifierToContainerViewControllerMapping
{
	return @{
			 DDDMapListViewControllerEmbedSegueIdentifer : @key(self.mapListViewController),
			 DDDMapViewControllerEmbedSegueIdentifier : @key(self.mapViewController)
			 };
}

- (void)showView:(DDDResultsView)view
{
	switch (view)
	{
		case DDDResultsViewList:
		{
			self.resultsMapListContainerView.hidden = NO;
			self.resultsMapViewContainerView.hidden = YES;
			break;
		}
		case DDDResultsViewMap:
		{
			self.resultsMapListContainerView.hidden = YES;
			self.resultsMapViewContainerView.hidden = NO;
			break;
		}
		default:
			break;
	}
}

- (IBAction)mapListSegmentControlValueChanged:(UISegmentedControl *)sender
{
	[self showView:sender.selectedSegmentIndex];
}
@end
