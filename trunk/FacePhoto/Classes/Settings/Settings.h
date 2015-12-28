//
//  Settings.h
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController <UITableViewDataSource,UITabBarDelegate> {
    IBOutlet UITableView *mainTableView;
}

@property (nonatomic,retain) IBOutlet UITableView *mainTableView;

@end
