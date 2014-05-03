//
//  DDDBaseViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 02/05/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDViewController.h"

@interface DDDViewController ()<DDDViewModelListener>

@end

@implementation DDDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.viewModel registerListener:self];
}

- (NSDictionary *)segueIdentifierToContainerViewControllerMapping
{
	return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[super prepareForSegue:segue sender:sender];
    NSString *path = [[self segueIdentifierToContainerViewControllerMapping] objectForKey:segue.identifier];
    NSAssert(path, @"This segue identifier doesn't contain a mapping! Make sure segue identifier exists in the storyboard");
    [self setValue:segue.destinationViewController forKeyPath:path];
	if ([segue.destinationViewController isKindOfClass:[DDDViewController class]])
	{
		[self setValue:self.viewModel forKeyPath:@key(((DDDViewController *)segue.destinationViewController).viewModel)];
	}
}
@end
