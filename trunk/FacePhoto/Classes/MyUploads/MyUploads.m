//
//  MyUploads.m
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyUploads.h"
#include "AppDelegate.h"

@implementation MyUploads

@synthesize picker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"My Uploads", @"My Uploads");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        self.picker = [[[UIImagePickerController alloc] init] autorelease];
        self.picker.delegate = self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentModalViewController:self.picker animated:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)Picker {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)Picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   image, @"picture",
                                   nil];
    [[delegate facebook] requestWithGraphPath:@"380481605305103/photos" // TODO: id of albums
                                    andParams:params
                                andHttpMethod:@"POST"
                                  andDelegate:self];
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)touchUpUpload:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentModalViewController:self.picker animated:YES];
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    NSLog(@"%@",result);
}
@end
