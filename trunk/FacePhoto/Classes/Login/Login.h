//
//  Login.h
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/19/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController{
    NSMutableArray *myData;
    NSArray *permissions;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data:(NSMutableArray *)data;
@end
