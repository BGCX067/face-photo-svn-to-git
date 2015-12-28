//
//  MyAlbums.m
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAlbums.h"
#import "AppDelegate.h"
#import "ResultViewAlbums.h"


@implementation MyAlbums
@synthesize imgAccount;
@synthesize btn2Albums;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Home", @"Home");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        
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
    // Initialize permissions
    currentAPICall = kAPIAccoutInformation;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [lbUserName release];
    lbUserName = nil;
    [self setBtn2Albums:nil];
    [self setImgAccount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)touchUpAlbums:(id)sender {
    // Do not set current API as this is commonly called by other methods
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/albums" andDelegate:self];
    currentAPICall = kAPIGraphUserFolderImage;
    
    lbUserName.hidden = TRUE;
    imgAccount.hidden = TRUE;
    btn2Albums.hidden = TRUE;
    
}

- (IBAction)btnNewFBAlbum:(id)sender {
    NSLog(@"btnNewFBAlbum");
}

- (void)dealloc {
    [lbUserName release];
    [btn2Albums release];
    [imgAccount release];
    [super dealloc];
}

#pragma mark - FBSessionDelegate
///**
// * Called when the user successfully logged in.
// */
//- (void)fbDidLogin{
//    
//}
//
///**
// * Called when the user dismissed the dialog without logging in.
// */
//- (void)fbDidNotLogin:(BOOL)cancelled{
//    
//}
//
///**
// * Called after the access token was extended. If your application has any
// * references to the previous access token (for example, if your application
// * stores the previous access token in persistent storage), your application
// * should overwrite the old access token with the new one in this method.
// * See extendAccessToken for more details.
// */
//- (void)fbDidExtendToken:(NSString*)accessToken
//               expiresAt:(NSDate*)expiresAt{
//    
//}
//
///**
// * Called when the user logged out.
// */
//- (void)fbDidLogout{
//    
//}
//
///**
// * Called when the current session has expired. This might happen when:
// *  - the access token expired
// *  - the app has been disabled
// *  - the user revoked the app's permissions
// *  - the user changed his or her password
// */
//- (void)fbSessionInvalidated{
//    
//}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

#pragma mark - FBRequestDelegate
/**
 * Called just before the request is sent to the server.
 */
- (void)requestLoading:(FBRequest *)request{
    
}

/**
 * Called when the server responds and begins to send back data.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array, a string, or a number,
 * depending on thee format of the API response.
 */
- (void)request:(FBRequest *)request didLoad:(id)result{
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    switch (currentAPICall) {
        case kAPIAccoutInformation:
        {
            lbUserName.text = [result objectForKey:@"name"];
            lbUserName.hidden = FALSE;
            NSLog(@"%@",[result objectForKey:@"name"]);
            // Get the profile image
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
            
            imgAccount.image = image;
            //[image release];
        }
            break;
            
        case kAPIGraphUserFolderImage:
        {
            NSLog(@"%@",result);
            NSMutableArray *albums = [[NSMutableArray alloc] initWithCapacity:1];
            NSArray *resultData = [result objectForKey:@"data"];
            if ([resultData count] > 0) {
                for (NSUInteger i=0; i<[resultData count]; i++) {
                    if ([[resultData objectAtIndex:i] objectForKey:@"count"] ) {
                        [albums addObject:[resultData objectAtIndex:i]];
                    }
                    
                }
                
                ResultViewAlbums *controller = [[ResultViewAlbums alloc]initWithStyle:UITableViewStylePlain title:@"Your Face Albums" data:albums];
                [self.navigationController pushViewController:controller animated:YES];
                s_ResultViewAlbums = controller;
                
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}

/**
 * Called when a request returns a response.
 *
 * The result object is the raw response from the server of type NSData
 */
- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data{
    
}

- (IBAction)touchUpLogout:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
}
@end
