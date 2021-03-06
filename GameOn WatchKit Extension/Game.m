//
//  Game.m
//  Raketto
//
//  Created by Stephen Pengilley on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "Game.h"

NSString *const gameIDKey = @"game id key";
NSString *const myScoreKey = @"my score key";
NSString *const theirScoreKey = @"their score key";
NSString *const startKey = @"game start key";
NSString *const endKey = @"game end key";

@implementation Game

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gameID = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.gameID forKey:gameIDKey];
    [aCoder encodeObject:self.myScore forKey:myScoreKey];
    [aCoder encodeObject:self.theirScore forKey:theirScoreKey];
    [aCoder encodeObject:self.start forKey:startKey];
    [aCoder encodeObject:self.end forKey:endKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil){
        _gameID = [aDecoder decodeObjectForKey:gameIDKey];
        _myScore = [aDecoder decodeObjectForKey:myScoreKey];
        _theirScore = [aDecoder decodeObjectForKey:theirScoreKey];
        _start = [aDecoder decodeObjectForKey:startKey];
        _end = [aDecoder decodeObjectForKey:endKey];
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
        self.gameID = [[NSUUID UUID] UUIDString];
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
