//
//  FeedItemTableViewCell.h
//  Raketto
//
//  Created by Stephen Pengilley on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *myAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *theirAvatar;
@property (strong, nonatomic) IBOutlet UILabel *myScore;
@property (strong, nonatomic) IBOutlet UILabel *theirScore;
@property (strong, nonatomic) IBOutlet UITextView *myGameDetails;
@property (strong, nonatomic) IBOutlet UITextView *theirGameDetails;
@property (strong, nonatomic) IBOutlet UITextView *gameDuration;

@end
