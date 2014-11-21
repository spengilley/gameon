//
//  TabBarViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "TabBarViewController.h"
#import "WhoAreYouViewController.h"
#import "User.h"

@interface TabBarViewController ()

@property (strong,nonatomic) User *userUsingThisApp;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.userUsingThisApp = [[User alloc] init];
    [self.userUsingThisApp buildFromFile];

    if ([self.userUsingThisApp.username isEqual:@0]) {
        
        WhoAreYouViewController *whoAreYouViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"whoAreYou"];
        
        [self presentViewController:whoAreYouViewController animated:YES completion:nil];
    }
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
