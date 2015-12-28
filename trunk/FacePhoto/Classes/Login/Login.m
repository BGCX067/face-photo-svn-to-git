//
//  Login.m
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/19/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"

@implementation Login

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myData = nil;
        if (data != nil) {
            myData = [[NSMutableArray alloc] initWithArray:data copyItems:YES];
        }
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    int posx = 10;
    int posy = 10;
    int gapx = 110;
    int gapy = 40;
    if (myData != nil) {
        for (int idx = 0; idx < [myData count]; idx++) {
            //NSArray *data = [myData objectAtIndex:idx];
            UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnUser.frame = CGRectMake(posx+(idx%2)*gapx, posy+(idx/2)*gapy, 100, 30);
            [btnUser setTitle:@"Login" forState:UIControlStateNormal];
            [btnUser addTarget:self action:@selector(btnLoginTouchUp:) forControlEvents:UIControlEventTouchUpInside];
            btnUser.tag = idx;
            [self.view addSubview:btnUser];
        }
    }
    
    UIButton *btnNewUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnNewUser.frame = CGRectMake(100, 100, 100, 30);
    [btnNewUser setTitle:@"New User" forState:UIControlStateNormal];
    [btnNewUser addTarget:self action:@selector(btnNewUserTouchUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnNewUser];

    // Initialize permissions
    permissions = [[NSArray alloc] initWithObjects:@"user_photos", @"offline_access", @"publish_stream",nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) btnNewUserTouchUp{
    NSLog(@"btnNewUserTouchUp");
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] authorize:permissions];
}

- (IBAction)btnLoginTouchUp:(UIButton*)sender
{
    int buttonIndex = sender.tag;
    NSLog(@"Hi, Button %d!", buttonIndex);
    NSArray *data = [myData objectAtIndex:buttonIndex];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.facebook.accessToken = [data objectAtIndex:0];
    delegate.facebook.expirationDate = [data objectAtIndex:1];
    if (![[delegate facebook] isSessionValid]) {
        [[delegate facebook] authorize:permissions];
    } else {
        [delegate showLoggedIn];
    }
    
}

@end
