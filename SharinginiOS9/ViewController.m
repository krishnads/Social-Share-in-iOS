//
//  ViewController.m
//  SharinginiOS9
//
//  Created by Krishana on 11/24/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import "OAMutableURLRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)shareBtnAction:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    
    switch (btn.tag)
    {
        case 1:
            [self shareViaActivityIndicator];
            break;
            
        case 2:
            [self postToFacebookUsingSocialFramework];
            break;
            
        case 3:
            [self postToTwitterUsingSocialFramework];
            break;
            
        case 4:
            [self postToFacebookUsingFBSDK];
            break;
            
        case 5:
            [self postToFBMessengerUsingFBSDK];
            break;
            
        case 6:
            [self postToInstagram];
            break;
            
        case 7:
            [self postToWhatsapp];
            break;
            
        default:
            break;
    }
}


#pragma shareViaActivityIndicator
-(void) shareViaActivityIndicator
{
    NSString *textToShare = @"Konstant Info Solutions Pvt. Ltd.";
    NSURL *myWebsite = [NSURL URLWithString:@"http://www.konstantinfo.com"];
    
    //NSString *localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:"temp.foo"];
   // NSURL *localFile = [NSURL fileURLWithPath:localPath];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    activityVC.excludedActivityTypes = @[UIActivityTypeAddToReadingList,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeOpenInIBooks,
                                         UIActivityTypePrint];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma postToFacebookUsingSocialFramework
-(void)postToFacebookUsingSocialFramework
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"First post from my iPhone in iOS9"];
        [controller addURL:[NSURL URLWithString:@"http://www.konstantinfo.com"]];
        [controller addImage:[UIImage imageNamed:@"kipl"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        [self alert:@"Alert" msg:@"Facebook Account is not available on your device"];
    }
}

#pragma postToTwitterUsingSocialFramework
-(void)postToTwitterUsingSocialFramework
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [controller setInitialText:@"First post from my iPhone in iOS9"];
        [controller addURL:[NSURL URLWithString:@"http://www.konstantinfo.com"]];
        [controller addImage:[UIImage imageNamed:@"kipl"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        [self alert:@"Alert" msg:@"Twitter Account is not available on your device"];
    }
}

#pragma postToFacebookUsingFBSDK
-(void)postToFacebookUsingFBSDK
{
   // NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",26.912434, 75.787271,@"zoom=12&size=114x116"];
    
    //NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    //content.contentURL = [NSURL URLWithString:@"http://www.konstantinfo.com"];
    content.contentTitle = @"Konstant Info Solutions Pvt. Ltd., Jaipur, Rajasthan";
    content.contentDescription = @"Highly Specialized in iOS development";
    [[NSBundle mainBundle] pathForResource:@"kipl" ofType:@"jpg"];
    
    //content.imageURL = [NSURL URLWithString: [[NSBundle mainBundle] pathForResource:@"kipl" ofType:@"jpg"]];
    
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:self];
    
//    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
//    dialog.fromViewController = self;
//    dialog.shareContent = content;
//    dialog.mode = FBSDKShareDialogModeShareSheet;
//    [dialog show];


}

#pragma postToFBMessengerUsingFBSDK
-(void)postToFBMessengerUsingFBSDK
{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb-messenger://"]])
    {
        UIImage *image = [UIImage imageNamed:@"kipl"];
        // An example of sharing an image without a border.
        //    FBSDKMessengerShareOptions *options = [[FBSDKMessengerShareOptions alloc] init];
        //    options.renderAsSticker = YES;
        [FBSDKMessengerSharer shareImage:image withOptions:nil];
        
        //    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"corgi" ofType:@"webp"];
        //    NSData *webpData = [NSData dataWithContentsOfFile:filepath];
        //    [FBSDKMessengerSharer shareAnimatedWebP:webpData withOptions:nil];
        //    //Sharing an animated gif:
        //
        //    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"selfie_gif" ofType:@"gif"];
        //    NSData *gifData = [NSData dataWithContentsOfFile:filepath];
        //    [FBSDKMessengerSharer shareAnimatedGIF:gifData withOptions:nil];
        //   // Sharing a video:
        //
        //    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"selfie_vid" ofType:@"mp4"];
        //    NSData *videoData = [NSData dataWithContentsOfFile:filepath];
        //    [FBSDKMessengerSharer shareVideo:videoData withOptions:nil];
        //   // Sharing an audio clip:
        //
        //    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"selfie" ofType:@"mp3"];
        //    NSData *mp3Data = [NSData dataWithContentsOfFile:filepath];
        //    [FBSDKMessengerSharer shareAudio:mp3Data withOptions:nil];
    }
    else
    {
        [self alert:@"Alert" msg:@"Facebook Messanger is not available on your device"];
    }
}

#pragma FBSDKSHaring Delegates
-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"shared successfully->%@",results);
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"error in sharing->%@",error.userInfo);
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"sharer cancelled by user");
}

#pragma Instagram Share

-(void) postToInstagram
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        CGRect rect = CGRectMake(0 ,0 , 0, 0);
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIGraphicsEndImageContext();
        NSString  *jpgPath = [[NSBundle mainBundle] pathForResource:@"kipl" ofType:@"png"];
        
        NSURL *igImageHookFile = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"file://%@", jpgPath]];
        self.dic.UTI = @"com.instagram.photo";
        
        self.dic = [self setupControllerWithURL:igImageHookFile usingDelegate:self];
        
        self.dic=[UIDocumentInteractionController interactionControllerWithURL:igImageHookFile];
        [self.dic presentOpenInMenuFromRect: rect    inView: self.view animated: YES ];
    }
    else
    {
        [self alert:@"Alert" msg:@"Instagram is not installed on your device"];
    }
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate
{
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    return interactionController;
}

#pragma WhatsApp Share

-(void) postToWhatsapp
{
    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]])
    {
        //for image
        UIImage     * iconImage = [UIImage imageNamed:@"kipl"];
        NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        //for video
//        NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wam"];
//        savePath = [[NSBundle mainBundle] pathForResource:@"Movie" ofType:@"m4v"];
        
        [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
        
        self.dic = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        //for image
        self.dic.UTI = @"net.whatsapp.image";
        //for video
        //self.dic.UTI = @"net.whatsapp.movie";
        
        self.dic.delegate = self;
        [self.dic presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
    }
    else
    {
        [self alert:@"Alert" msg:@"Whatsapp is not installed on your device"];
    }
}

#pragma LinkedIn Share

-(void)postToLinkedIn
{
//    NSURL *url = [NSURL URLWithString:@"http://api.linkedin.com/v1/people/~/shares"];
//    OAMutableURLRequest *request =
//    [[OAMutableURLRequest alloc] initWithURL:url
//                                    consumer:[self getConsumer]
//                                       token:self.accesstoken
//                                    callback:nil
//                           signatureProvider:nil];
//    
//    NSDictionary *update = [[NSDictionary alloc] initWithObjectsAndKeys:
//                            
//                            [[NSDictionary alloc]
//                             initWithObjectsAndKeys:
//                             @"anyone",@"code",nil], @"visibility",
//                            
//                            @"comment goes here", @"comment",
//                            [[NSDictionary alloc]
//                             initWithObjectsAndKeys:
//                             @"description goes here",@"description",
//                             @"www.google.com",@"submittedUrl",
//                             @"title goes here",@"title",
//                             @"http://economy.blog.ocregister.com/files/2009/01/linkedin-logo.jpg",@"submittedImageUrl",nil],@"content",
//                            nil];
//    [request setValue:@"json" forHTTPHeaderField:@"x-li-format"];
//    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
//    NSString *updateString = [update JSONString];
//    [request setHTTPBodyWithString:updateString];
//    [request setHTTPMethod:@"POST"];
//    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
//    [fetcher fetchDataWithRequest:request
//                         delegate:self
//                didFinishSelector:@selector(postUpdateApiCallResult:didFinish:)
//                  didFailSelector:@selector(postUpdateApiCallResult:didFail:)];
//    
}

#pragma AlertViewController

-(void) alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
