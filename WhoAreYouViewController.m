//
//  WhoAreYouViewController.m
//  Blurtit App
//
//  Created by Adam Groom on 09/04/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import "WhoAreYouViewController.h"
#import "User.h"

@interface WhoAreYouViewController () <UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (strong,nonatomic) User *userUsingThisApp;
@property (strong,nonatomic) UIView *overlayView;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) NSString *NSUUID;

@end

@implementation WhoAreYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUUID *oNSUUID = [[UIDevice currentDevice] identifierForVendor];
    self.NSUUID = [oNSUUID UUIDString];
    
    CGRect scrollViewRect = self.view.bounds;
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 2.0f,
                                               scrollViewRect.size.height);
    self.myScrollView.delegate = self;
    [self.view addSubview:self.myScrollView];
    
    //NAME LABEL
    UILabel *whatsYourNameLabel = [[UILabel alloc] init];
    whatsYourNameLabel.text = @"What is your name?";
    [whatsYourNameLabel setTextColor:[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0]];
    [whatsYourNameLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:18.0]];
    [whatsYourNameLabel sizeToFit];
    whatsYourNameLabel.center = self.view.center;
    whatsYourNameLabel.frame = CGRectMake(whatsYourNameLabel.frame.origin.x, 100.0, whatsYourNameLabel.frame.size.width, whatsYourNameLabel.frame.size.height);
    [self.myScrollView addSubview:whatsYourNameLabel];
    
    //NAME
    CGRect nameTextFieldFrame = CGRectMake(self.view.center.x-(whatsYourNameLabel.frame.size.width/2)   ,
                                           whatsYourNameLabel.frame.origin.y + 45.0f,
                                           whatsYourNameLabel.frame.size.width, 31.0f);
    self.nameTextField = [[UITextField alloc] initWithFrame:nameTextFieldFrame];
    self.nameTextField.placeholder = @"Your name";
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    self.nameTextField.delegate = self;
    [self.nameTextField becomeFirstResponder];
    
    [self.myScrollView addSubview:self.nameTextField];
    
    UIColor *bottomBorderBackgroundColor = [UIColor colorWithRed:200.0/255.0f
                                                           green:200.0/255.0f
                                                            blue:200.0/255.0f
                                                           alpha:1.0f];
    
    UIView *usernameBottomBorder = [[UIView alloc]
                                    initWithFrame:CGRectMake(self.nameTextField.frame.origin.x,
                                                             self.nameTextField.frame.origin.y +
                                                             self.nameTextField.frame.size.height - 4.0f,
                                                             self.nameTextField.frame.size.width,
                                                             1.0f)];
    usernameBottomBorder.backgroundColor = bottomBorderBackgroundColor;
    
    [self.myScrollView addSubview:usernameBottomBorder];
    
    //NEXT BUTTON
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextButton.frame = CGRectMake(self.view.center.x-72.5,
                                  self.nameTextField.frame.origin.y +65.0,
                                  145.0,
                                  28.0);
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(goToAddPhoto) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:161.0/255.0 blue:242.0/255.0 alpha:1.0]];
    nextButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:14];
    nextButton.tintColor = [UIColor whiteColor];
    nextButton.layer.cornerRadius = 5;
    nextButton.clipsToBounds = YES;
    [self.myScrollView addSubview:nextButton];
    
    //WHAT DO YOU LOOK LIKE?
    UILabel *avatarLabel = [[UILabel alloc] init];
    avatarLabel.text = @"What do you look like?";
    [avatarLabel setTextColor:[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0]];
    [avatarLabel setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:18.0]];
    [avatarLabel sizeToFit];
    avatarLabel.center = self.view.center;
    avatarLabel.frame = CGRectMake(avatarLabel.frame.origin.x + self.view.frame.size.width,
                                   100.0,
                                   avatarLabel.frame.size.width,
                                   avatarLabel.frame.size.height);
    [self.myScrollView addSubview:avatarLabel];
    
    //AVATAR
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x + (self.view.frame.size.width-75.0),
                                                                avatarLabel.frame.origin.y + 45.0f,
                                                                150.0,
                                                                150.0)];
    self.avatar.image = [UIImage imageNamed:@"large_avatar"];
    self.avatar.layer.cornerRadius = 75;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderWidth = 2.0;
    self.avatar.layer.borderColor = [[UIColor colorWithRed:146.0/255.0 green:146.0/255.0 blue:146.0/255.0 alpha:1.0] CGColor];
    [self.myScrollView addSubview:self.avatar];
    
    //CHOOSE PHOTO BUTTON
    UIButton *choosePhotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    choosePhotoButton.frame = CGRectMake(self.view.center.x+(self.view.frame.size.width-72.5),
                                  self.avatar.frame.origin.y +175.0,
                                  145.0,
                                  28.0);
    [choosePhotoButton setTitle:@"Choose Photo" forState:UIControlStateNormal];
    [choosePhotoButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:161.0/255.0 blue:242.0/255.0 alpha:1.0]];
    choosePhotoButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:14];
    choosePhotoButton.tintColor = [UIColor whiteColor];
    choosePhotoButton.layer.cornerRadius = 5;
    choosePhotoButton.clipsToBounds = YES;
    [choosePhotoButton addTarget:self
                  action:@selector(changePhotoFromScrollView:)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.myScrollView addSubview:choosePhotoButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.myScrollView.contentOffset.x>0){
        
        [self dismissKeyboard];
        
    } else {
        
        [self.nameTextField becomeFirstResponder];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self goToAddPhoto];
    return YES;
}

-(void) dismissKeyboard
{
    [self.nameTextField resignFirstResponder];
}

- (void)goToAddPhoto
{
    [self.nameTextField resignFirstResponder];
    [self.myScrollView scrollRectToVisible:CGRectMake(320.0, 0.0, 320.0, self.view.bounds.size.height) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissModel{
    
    [self.myScrollView scrollRectToVisible:CGRectMake(320.0, 0.0, 320.0, self.view.bounds.size.height) animated:NO];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(gotUserID)
                   name:@"gotUserID"
                 object:nil];
    
    self.userUsingThisApp = [[User alloc] init];
    [self.userUsingThisApp buildFromFile];
    NSString *name = self.nameTextField.text;
    if ([name isEqualToString:@""]){
        name = @"Anonymous";
    }
    self.userUsingThisApp.username = name;
    self.userUsingThisApp.largeImage = self.avatar.image;
    self.userUsingThisApp.image = self.avatar.image;

    [self.userUsingThisApp save];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

-(void)gotUserID
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    });
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
