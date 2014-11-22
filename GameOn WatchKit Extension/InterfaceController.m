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

@property (weak, nonatomic) IBOutlet WKInterfaceButton *mePlus;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *youPlus;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *youMinus;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *meMinus;

@property NSInteger yourScore;
@property NSInteger opponentScore;


@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;

@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        [self.mePlus setBackgroundImage:[UIImage imageNamed:@"plus"]];
        [self.youPlus setBackgroundImage:[UIImage imageNamed:@"plus"]];
        [self.meMinus setBackgroundImage:[UIImage imageNamed:@"minus"]];
        [self.youMinus setBackgroundImage:[UIImage imageNamed:@"minus"]];

    }
    
    return self;
}

- (IBAction)mePlusPressed {
    
    self.yourScore = self.yourScore+1;
    [self updateScore];
}

- (IBAction)youPlusPressed {
    
    self.opponentScore = self.opponentScore + 1;
    [self updateScore];
}

- (IBAction)youMinusPressed {

    self.opponentScore = self.opponentScore - 1;
    [self updateScore];
}

- (IBAction)meMinusPressed {
    
    self.yourScore = self.yourScore - 1;
    [self updateScore];
}

- (void) updateScore
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld - %ld",(long)self.yourScore,(long)self.opponentScore];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
}

@end






