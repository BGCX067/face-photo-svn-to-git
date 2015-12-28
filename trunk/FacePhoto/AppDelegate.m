//
//  AppDelegate.m
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MyAlbums.h"
#import "MyUploads.h"
#import "Settings.h"
#import "Login.h"

//static NSString* kAppId = @"210849718975311";
static NSString* kAppId = @"232510350105983";


@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navigationController;
@synthesize facebook;

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2,*viewController3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[[MyAlbums alloc] initWithNibName:@"MyAlbums_iPhone" bundle:nil] autorelease];
        viewController2 = [[[MyUploads alloc] initWithNibName:@"MyUploads_iPhone" bundle:nil] autorelease];
        viewController3 = [[[Settings alloc] initWithNibName:@"Settings_iPhone" bundle:nil] autorelease];
    } else {
        viewController1 = [[[MyAlbums alloc] initWithNibName:@"MyAlbums_iPad" bundle:nil] autorelease];
        viewController2 = [[[MyUploads alloc] initWithNibName:@"MyUploads_iPad" bundle:nil] autorelease];
        viewController3 = [[[Settings alloc] initWithNibName:@"Settings_iPad" bundle:nil] autorelease];

    }
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController, viewController2,viewController3, nil];
    
    UIViewController *viewLogin;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:s_DataSaveString]){
        NSMutableArray *data= [defaults objectForKey:s_DataSaveString];
        viewLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil data:data];
    }
    else {
        viewLogin = [[Login alloc] initWithNibName:@"Login" bundle:nil data:nil];
    }
    
    self.window.rootViewController = viewLogin;
    [self.window makeKeyAndVisible];
    
//    self.window.rootViewController = self.tabBarController;
//    [self.window makeKeyAndVisible];
    
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
//    facebook.accessToken = nil;
//    facebook.expirationDate = nil;
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"FBAccessTokenKey"] 
//        && [defaults objectForKey:@"FBExpirationDateKey"]) {
//        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
//        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
//    }
//    
//    if (![facebook isSessionValid]) {
//        NSArray *permissions = [[NSArray alloc] initWithObjects:@"offline_access", nil];
//        [facebook authorize:permissions];
//    }
    return YES;
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}


- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:s_DataSaveString]){
        NSMutableArray *data= [defaults objectForKey:s_DataSaveString];
        NSArray *newdata = [[NSArray alloc] initWithObjects:[facebook accessToken],[facebook expirationDate], nil];
        [data addObject:newdata];
        [defaults removeObjectForKey:s_DataSaveString];
        [defaults synchronize];
        [defaults setObject:data forKey:s_DataSaveString];
        [defaults synchronize];
    }
    else {
        NSMutableArray *data= [[NSMutableArray alloc] initWithCapacity:1];
        NSArray *newdata = [[NSArray alloc] initWithObjects:[facebook accessToken],[facebook expirationDate], nil];
        [data addObject:newdata];
        [defaults setObject:data forKey:s_DataSaveString];
        [defaults synchronize];
    }
    
//    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
//    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
//    [defaults synchronize];
    
    
//    MyAlbums *myAlbums = (MyAlbums*)navigationController.topViewController;
//    UIButton *btnAlbums = (UIButton*)[myAlbums btn2Albums];
//    btnAlbums.hidden = FALSE;
//    
    [self showLoggedIn];
}

- (void) showLoggedIn{
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [self apiFQLIMe];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    MyAlbums *myAlbums = (MyAlbums*)navigationController.topViewController;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:myAlbums];
}

@end
