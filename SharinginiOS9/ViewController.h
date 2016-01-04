//
//  ViewController.h
//  SharinginiOS9
//
//  Created by Krishana on 11/24/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController : UIViewController<FBSDKSharingDelegate,UIDocumentInteractionControllerDelegate>
@property (nonatomic, retain) UIDocumentInteractionController *dic;

@end

