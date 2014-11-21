//
//  FeedViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myScore;
@property (strong, nonatomic) IBOutlet UILabel *theirScore;
@property (strong, nonatomic) IBOutlet UIImageView *myAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *theirAvatar;
@property (strong, nonatomic) IBOutlet UITextView *gameScores;

@property (strong, nonatomic) NSMutableDictionary *rowValues;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView].separatorColor = [UIColor clearColor];
    
    
}


- (void) createRowValuesArray {
    
    //self.rowValues = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"myScore", @"3", "theirScore", @"2", @"myAvatar", , nil]
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedItem"];
    
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
