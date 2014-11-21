//
//  ProfileViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"

@interface ProfileViewController ()

@property (strong,nonatomic) User *userUsingThisApp;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userUsingThisApp = [[User alloc] init];
    [self.userUsingThisApp buildFromFile];
    self.name.text = self.userUsingThisApp.username;
    
    if (self.userUsingThisApp.largeImage) {
        self.avatar.image = self.userUsingThisApp.largeImage;
    } else {
        self.avatar.image = [UIImage imageNamed:@"large_avatar"];
    }

    self.avatar.layer.cornerRadius = 75;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderWidth = 2.0;
    self.avatar.layer.borderColor = [[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0] CGColor];
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.userUsingThisApp buildFromFile];
    self.avatar.image = self.userUsingThisApp.largeImage;
    self.name.text = self.userUsingThisApp.username;
    
    self.avatar.layer.cornerRadius = 75;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderWidth = 2.0;
    self.avatar.layer.borderColor = [[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0] CGColor];
    
}

- (IBAction)changePhoto:(id)sender {
    
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
