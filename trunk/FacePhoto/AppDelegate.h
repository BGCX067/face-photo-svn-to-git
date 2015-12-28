//
//  AppDelegate.h
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#include "ResultViewAlbums.h"

// TODO: place some where
static NSString* s_DataSaveString = @"FBFacePhoto";
static ResultViewAlbums *s_ResultViewAlbums = nil;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,FBSessionDelegate>{
    Facebook *facebook;
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) Facebook *facebook;

- (void) showLoggedIn;

@end
