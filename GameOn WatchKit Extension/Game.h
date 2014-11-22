//
//  Game.h
//  Raketto
//
//  Created by Stephen Pengilley on 22/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface Game : NSObject
@property (strong, nonatomic) NSString *gameID;
@property  (strong, nonatomic) NSNumber *myScore;
@property (strong, nonatomic) NSNumber *theirScore;
@property (strong, nonatomic) NSDate *start;
@property (strong, nonatomic) NSDate *end;
@property (nonatomic) int durationMinutes;
@end
