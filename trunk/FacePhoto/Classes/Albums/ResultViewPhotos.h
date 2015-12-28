//
//  ResultViewPhotos.h
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/10/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@interface ResultViewPhotos : UITableViewController<FBRequestDelegate>{
    NSMutableArray *myData;
}

- (id)initWithStyle:(UITableViewStyle)style title:(NSString *)title data:(NSArray *)data;
@end
