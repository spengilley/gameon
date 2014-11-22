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
NSString *const matchStartKey = @"match start key";
NSString *const matchEndKey = @"match end key";
NSString *const gamesKey = @"games key";


@implementation Match



- (instancetype)initWithID:(NSString *) ID
{
    self = [super init];
    if (self) {
        self.matchId = ID;
        [self buildFromFile];
    }
    return self;
}


-(void) addGame:(Game *)newGame withID:(NSNumber *)gameID {
    [self.games setObject:newGame forKey:gameID];
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.matchId forKey:matchIDKey];
    [aCoder encodeObject:self.myUser forKey:myUserKey];
    [aCoder encodeObject:self.theirUser forKey:theirUserKey];
    [aCoder encodeObject:self.matchStart forKey:matchStartKey];
    [aCoder encodeObject:self.matchEnd forKey:matchEndKey];
    [aCoder encodeObject:self.games forKey:gamesKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil){
        _matchId = [aDecoder decodeObjectForKey:matchIDKey];
        _myUser = [aDecoder decodeObjectForKey:myUserKey];
        _theirUser = [aDecoder decodeObjectForKey:theirUserKey];
        _matchStart = [aDecoder decodeObjectForKey:matchStartKey];
        _matchEnd = [aDecoder decodeObjectForKey:matchEndKey];
        _games = [aDecoder decodeObjectForKey:gamesKey];
    }
    return self;
}


-(void)buildFromFile
{
    NSURL *baseUrl = [[[NSFileManager alloc] init] containerURLForSecurityApplicationGroupIdentifier:@"group.adam"];
    NSURL *url = [NSURL URLWithString:self.matchId relativeToURL:baseUrl];
    NSString *filePath = [url absoluteString];
    
    Match *matchOnDisk = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if(!matchOnDisk) {
        self.matchId = [[NSUUID UUID] UUIDString];
        self.myUser = [[User alloc] init];
        [self.myUser buildFromFile];
        self.theirUser = [[User alloc]init];
        [self.theirUser buildFromFile];
        self.matchStart = [[NSDate alloc] init];
        self.matchEnd = [[NSDate alloc] init];
        
    } else {
        self.matchId = matchOnDisk.matchId;
        self.myUser = matchOnDisk.myUser;
        self.theirUser = matchOnDisk.theirUser;
        self.matchStart = [[NSDate alloc] init];
        self.matchEnd = [[NSDate alloc] init];
    }
}

-(void)save
{
    NSURL *baseUrl = [[[NSFileManager alloc] init] containerURLForSecurityApplicationGroupIdentifier:@"group.adam"];
    NSURL *url = [NSURL URLWithString:self.matchId relativeToURL:baseUrl];
    NSString *filePath = [url absoluteString];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}


@end
