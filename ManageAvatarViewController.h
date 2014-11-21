//
//  ManageAvatarViewController.h
//  Blurtit App
//
//  Created by Adam Groom on 11/04/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageAvatarViewController : UIViewController

@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *avatar;

- (IBAction)changePhoto:(id)sender;
- (IBAction)changePhotoFromScrollView:(id)sender;
-(void) dismissModel;

@end
