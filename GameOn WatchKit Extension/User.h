//
//  User.h
//  Raketto
//
//  Created by Stephen Pengilley on 22/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface User : NSObject
@property (strong,nonatomic) NSString *userID;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *pushToken;
@property (strong,nonatomic) NSString *locationName;
@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) UIImage *largeImage;

-(void)buildFromFile;
-(void)save;
@end
