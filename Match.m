//
//  Match.m
//  Raketto
//
//  Created by Stephen Pengilley on 22/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//
#import "Match.h"


NSString *const matchIDKey = @"match id key";
NSString *const myUserKey = @"me user key";
NSString *const theirUserKey = @"their user key";
NSString *const startKey = @"start key";
NSString *const endKey = @"end key";
NSString *const gamesKey = @"games key";


@implementation Match


-(void) addGame:(Game *)newGame withID:(NSNumber *)gameID {
    [self.games setObject:newGame forKey:gameID];
}



- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.matchId forKey:matchIDKey];
    [aCoder encodeObject:self.myUser forKey:myUserKey];
    [aCoder encodeObject:self.theirUser forKey:theirUserKey];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil){
       // _gameID = [aDecoder decodeObjectForKey:gameIDKey];
    }
    return self;
}


-(void)buildFromFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"game.txt"];
    
    Game *gameOnDisk =
    [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if (!gameOnDisk) {
        self.gameID = [[NSNumber alloc] initWithInt:0];
        self.myScore = [[NSNumber alloc] initWithInt:arc4random_uniform(3)];
        self.theirScore = [[NSNumber alloc] initWithInt:arc4random_uniform(3)];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        self.start = [dateFormatter dateFromString:@"21/11/2014 13:00"];
        self.end = [dateFormatter dateFromString:@"21/11/2014 13:25"];
    } else {
        self.gameID = gameOnDisk.gameID;
        self.myScore = gameOnDisk.myScore;
        self.theirScore = gameOnDisk.theirScore;
        self.start = gameOnDisk.start;
        self.end = gameOnDisk.end;
    }
}

-(void)save
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"game.txt"];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}


@end
