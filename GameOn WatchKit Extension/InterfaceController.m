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


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *me;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *you;

@property NSInteger yourScore;
@property NSInteger yourServe;
@property NSInteger yourSide;

@property NSInteger lastServe;
@property NSInteger lastSide;

@property NSInteger opponentScore;
@property NSString *matchID;

@property (weak, nonatomic) IBOutlet WKInterfaceButton *startButton;

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
        NSLog(@"new match with id %@", self.matchID);
    }
    
    return self;
}

- (IBAction)endGameYes {
    NSLog( @"Yes pressed" );
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
        NSURL *baseUrl = [[[NSFileManager alloc] init] containerURLForSecurityApplicationGroupIdentifier:@"group.adam"];
        NSURL *url = [NSURL URLWithString:@"matches/current_match" relativeToURL:baseUrl];
        NSString *fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        
        
    });
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

@end






