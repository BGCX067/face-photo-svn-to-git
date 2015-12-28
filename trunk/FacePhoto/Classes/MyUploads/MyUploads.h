//
//  MyUploads.h
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface MyUploads : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBRequestDelegate>{
    UIImagePickerController *picker;
}

@property (nonatomic, retain) UIImagePickerController* picker;
- (IBAction)touchUpUpload:(id)sender;

@end
