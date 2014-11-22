//
//  TabBarViewController.m
//  Raketto
//
//  Created by Adam Groom on 21/11/2014.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "TabBarViewController.h"
#import "WhoAreYouViewController.h"
#import "ProfileViewController.h"
#import "User.h"

@interface TabBarViewController ()

@property (strong,nonatomic) User *userUsingThisApp;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    UITabBarItem *profileTab = [self.tabBar.items objectAtIndex:0];
    profileTab.image = [[UIImage imageNamed:@"profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileTab.selectedImage = [UIImage imageNamed:@"profile"];
    
    UITabBarItem *feedTab = [self.tabBar.items objectAtIndex:1];
    feedTab.image = [[UIImage imageNamed:@"feed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    feedTab.selectedImage = [UIImage imageNamed:@"feed"];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateFeeds) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.userUsingThisApp = [[User alloc] init];
    [self.userUsingThisApp buildFromFile];

    if ([self.userUsingThisApp.username isEqual:@""]) {
        
        WhoAreYouViewController *whoAreYouViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"whoAreYou"];
        
        [self presentViewController:whoAreYouViewController animated:YES completion:nil];
    } else {
        
        
        UINavigationController *profileViewNavController = [[self viewControllers] objectAtIndex:0];
        ProfileViewController *profileViewController = [[profileViewNavController viewControllers] objectAtIndex:0];
        profileViewController.avatar.image = self.userUsingThisApp.largeImage;
        profileViewController.name.text = self.userUsingThisApp.username;
        
    }
}

-(void) updateFeeds
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *baseUrl = [[[NSFileManager alloc] init] containerURLForSecurityApplicationGroupIdentifier:@"group.adam"];
        NSURL *url = [NSURL URLWithString:@"current_match" relativeToURL:baseUrl];
        NSString *fileContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [NSData dataWithContentsOfFile:fileContent];
        
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (NSString *item in dictionary) {
                NSLog(@"%@", item);
            }
        }
        
    });
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
