//
//  ResultViewAlbums.h
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/10/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

typedef enum apiAlbumsCall {
    kAPIRequestPhotos,
    kAPIRequestNewAlbums,
} apiAlbumsCall;

@interface ResultViewAlbums : UITableViewController<FBRequestDelegate>{
    NSMutableArray *myData;
    int rowIndex;
    int apiIndex;
}

@property (nonatomic, retain) NSMutableArray *myData;
- (id)initWithStyle:(UITableViewStyle)style title:(NSString *)title data:(NSArray *)data;
@end
