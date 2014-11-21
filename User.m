//
//  User.m
//  UserInfo
//
//  Created by Adam Groom on 13/01/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import "User.h"

NSString *const userIDKey = @"userIDKey";
NSString *const usernameKey = @"usernameKey";
NSString *const locationNameKey = @"locationNameKey";
NSString *const pushTokenKey = @"pushTokenKey";
NSString *const imageKey = @"imageKey";
NSString *const largeImageKey = @"largeImageKey";

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userID forKey:userIDKey];
    [aCoder encodeObject:self.username forKey:usernameKey];
    [aCoder encodeObject:self.locationName forKey:locationNameKey];
    [aCoder encodeObject:self.pushToken forKey:pushTokenKey];
    [aCoder encodeObject:self.image forKey:imageKey];
    [aCoder encodeObject:self.largeImage forKey:largeImageKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self != nil){
        _userID = [aDecoder decodeObjectForKey:userIDKey];
        _username = [aDecoder decodeObjectForKey:usernameKey];
        _locationName = [aDecoder decodeObjectForKey:locationNameKey];
        _pushToken = [aDecoder decodeObjectForKey:pushTokenKey];
        _image = [aDecoder decodeObjectForKey:imageKey];
        _largeImage = [aDecoder decodeObjectForKey:largeImageKey];
    }
    return self;
}

-(void)buildFromFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"me.txt"];
    
    User *userOnDisk =
    [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
 
    if (!userOnDisk) {
        self.userID = [[NSNumber alloc] initWithInt:0];
        self.username = @"";
        self.image = [UIImage imageNamed:@"large_avatar"];
        self.largeImage = [UIImage imageNamed:@"large_avatar"];
        self.pushToken = @"";
        self.locationName = @"";
    } else {
        self.userID = userOnDisk.userID;
        self.image = userOnDisk.image;
        self.largeImage = userOnDisk.largeImage;
        self.username = userOnDisk.username;
        self.pushToken = userOnDisk.pushToken;
        self.locationName = userOnDisk.locationName;
        
    }
}

-(void)save
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"me.txt"];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

@end
