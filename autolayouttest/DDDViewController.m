//
//  DDDViewController.m
//  autolayouttest
//
//  Created by Sidd Sathyam on 21/04/14.
//  Copyright (c) 2014 dotdotdot. All rights reserved.
//

#import "DDDViewController.h"

#define DDDSegueEmbedMapViewControllerIdentifer @"DDDSegueEmbedMapViewController"

@interface DDDViewController ()

@end

@implementation DDDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.label1.text = @"SOME VERY LONG TEXT.SOME VERY LONG TEXT.SOME VERY LONG TEXT.SOME VERY LONG TEXT.SOME VERY LONG TEXT.SOME VERY LONG TEXT";
	self.label2.text = @"MOO COW.MOO COW MOO COW MOO COW MOO COW MOO COW MOO COW MOO COW MOO COW";
	
	self.label3.text = @"BLAH BLAH BLAH BLAH BLAH BLAH BLAH BLAH BLAH BLAH BLAH BLAH";
	
	[self addBigImage];
}

- (void)addBigImage
{
	UIImage *image = [UIImage imageNamed:@"bigimage"];
	UIImageView *bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x,
																			  self.scrollView.frame.origin.y,
																			  image.size.width,
																			  image.size.height)];
	
	[bigImageView setImage:image];
	
	[self.scrollView addSubview:bigImageView];
	
	self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	bigImageView.translatesAutoresizingMaskIntoConstraints = NO;
	

	// Set the constraints for the scroll view and the image view.
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self.scrollView, bigImageView);
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bigImageView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bigImageView]|" options:0 metrics: 0 views:viewsDictionary]];
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMapViewButtonTapped:(id)sender
{
	[self performSegueWithIdentifier:DDDSegueEmbedMapViewControllerIdentifer sender:self];
}

@end
