//
//  ManageAvatarViewController.m
//  Blurtit App
//
//  Created by Adam Groom on 11/04/2014.
//  Copyright (c) 2014 Adam Groom. All rights reserved.
//

#import "ManageAvatarViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ManageAvatarViewController () <UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation ManageAvatarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSURL *)uniqueDocumentURL
{
    NSArray *documentDirectories = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *unique = [NSString stringWithFormat:@"%.0f", floor([NSDate timeIntervalSinceReferenceDate])];
    return [[documentDirectories firstObject] URLByAppendingPathComponent:unique];
}

-(NSURL *)imageURL
{
    if (!_imageURL && self.image) {
        NSURL *url = [self uniqueDocumentURL];
        if (url) {
            NSData *imageData = UIImageJPEGRepresentation(self.image, 1.0);
            if ([imageData writeToURL:url atomically:YES]) {
                _imageURL = url;
            }
        }
    }
    return _imageURL;
}

- (void)setImage:(UIImage *)image
{
    self.avatar.image = image;
    [[NSFileManager defaultManager] removeItemAtURL:_imageURL error:NULL];
    self.imageURL = nil;
}

- (UIImage *)image:(UIImage *)image
{
    return self.avatar.image = image;
}

- (IBAction)changePhoto:(id)sender {
    
    UIActionSheet *actionSheet;
    
    if ([UIImagePickerController
         isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Photo Library", @"Camera",nil];
        
    } else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Photo Library",nil];
    }
}

- (IBAction)changePhotoFromScrollView:(id)sender {
    
    UIActionSheet *actionSheet;
    
    if ([UIImagePickerController
         isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Photo Library", @"Camera",nil];
        
    } else {
        
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Photo Library",nil];
    }
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *avatarUIImagePickerController = [[UIImagePickerController alloc] init];
    avatarUIImagePickerController.delegate = self;
    avatarUIImagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    avatarUIImagePickerController.allowsEditing = YES;
    
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([choice isEqualToString:@"Photo Library"]){
        
        avatarUIImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:avatarUIImagePickerController animated:YES completion:NULL];
        
    } else if([choice isEqualToString:@"Camera"]){
        
        avatarUIImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        avatarUIImagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;

        [self presentViewController:avatarUIImagePickerController animated:YES completion:NULL];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    CGFloat ratio = 150.0/image.size.width;
    UIImage *resizedAvatar = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width*ratio, image.size.height*ratio)];
    self.image = resizedAvatar;
    
    [self dismissViewControllerAnimated:YES completion:^(void){[self dismissModel];}];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//used when subclass is a model
-(void) dismissModel{}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
