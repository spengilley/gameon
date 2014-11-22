//
//  Match.h
//  Raketto
//
//  Created by Stephen Pengilley on 22/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Match : NSObject
@property(strong,nonatomic) NSNumber *matchId;
@property(strong, nonatomic) User *me;
@property(strong, nonatomic) User *them;
@property(strong, nonatomic) NSDate *start;
@property(strong, nonatomic) NSDate *end;
@property(strong, nonatomic) NSMutableArray *games;

@end
