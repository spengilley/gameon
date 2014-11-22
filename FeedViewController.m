//
//  FeedViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "FeedViewController.h"
#import "User.h"
#import "Match.h"
#import "Game.h"
#import "FeedItemTableViewCell.h"

@interface FeedViewController ()

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSArray *rowValues;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView].separatorColor = [UIColor clearColor];
    
    self.user = [[User alloc] init];
    [self.user buildFromFile];
    
    [self configureNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
               selector:@selector(setMatches:)
                   name:@"MATCHES"
                 object:nil];

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setMatches:(NSNotification *)notifications {

    NSDictionary *newMatches = [notifications.userInfo objectForKey:@"matches"];
    
    self.rowValues = [[NSArray alloc] init];
    
    for (Match *match in newMatches) {
        [self.rowValues arrayByAddingObject:match];
    }
    
    [self.tableView reloadData];
}

-(void) configureNavigationBar {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedItem"];
    
    cell.gamesContaingView.layer.cornerRadius = 6;
    cell.scoreContainingView.layer.cornerRadius = 6;
    
    Match *match = [self.rowValues objectAtIndex:indexPath.row];
    
    cell.myAvatar.image = match.myUser.image;
    cell.myAvatar.layer.cornerRadius = cell.myAvatar.frame.size.width / 2;
    cell.myAvatar.layer.masksToBounds = YES;
    cell.myAvatar.layer.borderWidth = 1.0;
    cell.myAvatar.layer.borderColor = [[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0] CGColor];
    
    NSInteger myScore = 0;
    NSInteger theirScore = 0;
    NSString *myGameScores;
    NSString *theirGameScores;
    NSString *gameDurations;
    
    for(Game *game in match.games) {
        myGameScores = [myGameScores stringByAppendingString:[NSString stringWithFormat:@"%@%@", game.myScore, @"\n"]];
        theirGameScores = [theirGameScores stringByAppendingString:[NSString stringWithFormat:@"%@%@", game.theirScore, @"\n"]];
        gameDurations = [gameDurations stringByAppendingString:[NSString stringWithFormat:@"%@%@", [game getDuration], @"\n"]];
        
        myScore = myScore + [game.myScore integerValue];
        theirScore = theirScore + [game.theirScore integerValue];
        
    }
    
    cell.myGameDetails.text = myGameScores;
    cell.theirGameDetails.text = theirGameScores;
    cell.gameDuration.text = gameDurations;
    
    cell.myScore.text = [NSString stringWithFormat:@"%ld", myScore];
    cell.theirScore.text = [NSString stringWithFormat:@"%ld", theirScore];
    
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
