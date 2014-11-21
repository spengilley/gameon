//
//  User.h
//  UserInfo
//
//  Created by Adam Groom on 13/01/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>

@property (strong,nonatomic) NSNumber *userID;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *pushToken;
@property (strong,nonatomic) NSString *locationName;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) UIImage *largeImage;

-(void)buildFromFile;
-(void)save;

@end
