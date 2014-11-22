//
//  InterfaceController.m
//  Raketto WatchKit Extension
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

//
//  InterfaceController.m
//  Scoere WatchKit Extension
//
//  Created by Adam Groom on 20/11/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import "InterfaceController.h"
#import "Match.h"
#import "Game.h"
#import "User.h"

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *me;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *you;

@property NSInteger myScore;
@property NSInteger yourScore;
@property NSInteger yourServe;
@property NSInteger yourSide;

@property NSInteger lastServe;
@property NSInteger lastSide;

@property NSInteger opponentScore;
@property NSString *matchID;

@property NSDate *gameStartDate;


@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;

@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        self.yourServe=1;
        
        self.matchID = [[NSUUID UUID] UUIDString];
        self.gameStartDate = [[NSDate alloc] init];
        
        NSLog(@"new match with id %@", self.matchID);
    }
    
    return self;
}

- (IBAction)endGameYes {
    self.yourScore = 0;
    self.opponentScore = 0;
    [self updateScore];
}

- (IBAction)endGameNo {
    NSLog( @"No pressed" );
}

- (IBAction)mePlusPressed {
    
    self.lastServe = self.yourServe;
    self.lastSide = self.yourSide;
    
    if (self.yourServe==1) {
        self.yourScore = self.yourScore+1;
        [self swapSides];
    } else {
        [self.me setImage:[UIImage imageNamed:@"kass_serving"]];
        [self.you setImage:[UIImage imageNamed:@"adam"]];
        self.yourServe = 1;
    }

    [self updateScore];
}

- (IBAction)youPlusPressed {
    
    if (self.yourServe==0) {
        self.opponentScore = self.opponentScore + 1;
        [self swapSides];
    } else {
        [self.me setImage:[UIImage imageNamed:@"kass"]];
        [self.you setImage:[UIImage imageNamed:@"adam_serving"]];
        self.yourServe = 0;
    }
    [self updateScore];
}

-(void)swapSides {
    
    if (self.yourSide==1) {
        self.yourSide=0;
    } else {
        self.yourSide=1;
    }
}

- (IBAction)youMinusPressed {
    
    [self resetSides];
    
    if (self.yourServe==0) {
        self.opponentScore = self.opponentScore - 1;
    }
    [self updateScore];
}

- (IBAction)meMinusPressed {
    
    [self resetSides];
    
    if (self.yourServe==1) {
        self.yourScore = self.yourScore - 1;
    }
    [self updateScore];
}

-(void)resetSides
{
    self.yourServe = self.lastServe;
    self.yourSide = self.lastSide;
}

- (void) updateScore
{
    NSLog( @"Your server %ld Your Side %ld",(long)self.yourServe,(long)self.yourSide );
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld - %ld",(long)self.yourScore,(long)self.opponentScore];
    
    [self updateFeed];
}

-(void) updateFeed
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Match *match = [[Match alloc] initWithID:self.matchID];
        [match buildFromFile];
        
        Game *game = [[Game alloc] init];
        game.myScore = [NSNumber numberWithInteger:self.myScore];
        game.theirScore = [NSNumber numberWithInteger:self.yourScore];
        game.start = self.gameStartDate;
        [match addGame:game withID:game.gameID];
        
        User* me = [[User alloc] init];
        me.username = @"Adam";
        //me.image = [UIImage alloc] initWithContentsOfFile:<#(NSString *)#>
        
        User *them = [[User alloc] init];
        them.username = @"Kass";
        
        match.myUser = me;
        match.theirUser = them;
        
        [match save];
        
    });
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

@end






