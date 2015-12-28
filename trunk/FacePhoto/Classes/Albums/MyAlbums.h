//
//  MyAlbums.h
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

typedef enum apiCall {
    kAPIAccoutInformation,
    kAPIGraphUserFolderImage,
} apiCall;

@interface MyAlbums : UIViewController<FBRequestDelegate, FBSessionDelegate>{
    int currentAPICall;
    IBOutlet UILabel *lbUserName;
    UIButton *btn2Albums;
    UIImageView *imgAccount;
}

@property (retain, nonatomic) IBOutlet UIImageView *imgAccount;
@property (retain, nonatomic) IBOutlet UIButton *btn2Albums;

- (IBAction)touchUpAlbums:(id)sender;
- (IBAction)btnNewFBAlbum:(id)sender;

@end
