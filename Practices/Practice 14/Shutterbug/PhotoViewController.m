//
//  PhotoViewController.m
//  Shutterbug
//
//  Created by 진 재연 on 12. 5. 16..
//  Copyright (c) 2012년 daramkun@daram.pe.kr. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController ()
@property (retain) UIScrollView * scrollView;
@property (retain) UIImageView * imageView;
@end

@implementation PhotoViewController

@synthesize scrollView, imageView;
@synthesize photo;

- (void) viewWillAppear:(BOOL)animated
{
    [spinner startAnimating];
    [self.photo processImageDataWithBlock:^(NSData * imageData){
        if(self.view.window)
        {
            UIImage * image = [UIImage imageWithData:imageData];
            imageView.image = image;
            imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            scrollView.contentSize = image.size;
            [spinner stopAnimating];
        }
    }];
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.scrollView = nil;
    self.imageView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) dealloc
{
    [scrollView release];
    [imageView release];
    [photo release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
