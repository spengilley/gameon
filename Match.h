//
//  Match.h
//  Raketto
//
//  Created by Stephen Pengilley on 22/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Game.h"

@interface Match : NSObject
@property(strong,nonatomic) NSString *matchId;
@property(strong, nonatomic) User *myUser;
@property(strong, nonatomic) User *theirUser;
@property(strong, nonatomic) NSDate *matchStart;
@property(strong, nonatomic) NSDate *matchEnd;
@property(strong, nonatomic) NSMutableDictionary *games;

-(void)addGame:(Game *)newGame withID:(NSNumber *) gameID;

@end
