//
//  FeedViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "FeedViewController.h"
#import "User.h"
#import "FeedItemTableViewCell.h"

@interface FeedViewController ()

@property (strong, nonatomic) NSMutableDictionary *rowValues;
@property (strong, nonatomic) User *user;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView].separatorColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
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
    
    cell.myAvatar.image = self.user.image;
    cell.myAvatar.layer.cornerRadius = cell.myAvatar.frame.size.width / 2;
    cell.myAvatar.layer.masksToBounds = YES;
    cell.myAvatar.layer.borderWidth = 1.0;
    cell.myAvatar.layer.borderColor = [[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0] CGColor];
    
    cell.myScore.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    cell.theirScore.text = [NSString stringWithFormat:@"%ld", indexPath.row+2];
    cell.myGameDetails.text = @"11\n3\n15";
    cell.theirGameDetails.text = @"5\n11\n13";
    cell.gameDuration.text = @"15 mins\n13 mins\n25 mins";
     
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
