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

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *ScoreLabel;
@property NSInteger yourScore;
@property NSInteger opponentScore;
@property BOOL yourServe;
@property BOOL yourServeLeft;

@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        self.yourScore = 0;
        self.opponentScore = 0;
    }
    
    return self;
}
- (IBAction)youScoreButtonPressed {
    
    
    
    self.yourScore = self.yourScore+1;
    [self updateScore];
}
- (IBAction)opponentScoreButtonPressed {
    
    self.opponentScore=self.opponentScore+1;
    [self updateScore];
}

- (void) updateScore
{
    self.ScoreLabel.text = [NSString stringWithFormat:@"%ld - %ld",(long)self.yourScore,(long)self.opponentScore];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end






