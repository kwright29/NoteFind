//
//  CameraImport.m
//  NoteFind
//
//  Created by Khloe Wright on 7/15/22.
//

#import "CameraImport.h"


@interface CameraImport () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) UIImage *image;
@property (nonatomic) NewNoteViewController *noteVC;


@end

@implementation CameraImport

- (void)showCamera:(NewNoteViewController *)vc {
    self.theVC = vc;
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [vc presentViewController:imagePickerVC animated:YES completion:nil];
    
    

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
   
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    // Do something with the images (based on your use case)
    self.image = originalImage;
    [self.delegate getImageFromCamera:self.image];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self.theVC dismissViewControllerAnimated:YES completion:nil];
}

@end
