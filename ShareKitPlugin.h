//
//  ShareKitPlugin.h
//
//
//  Created by Erick Camacho on 28/07/11.
//  MIT Licensed
// Updated by Mohamed Fasil

#import <Foundation/Foundation.h>

#import "SHK.h"
#import "SHKSharer+Phonegap.h"
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVPluginResult.h>



@interface ShareKitPlugin : CDVPlugin {
    
    
}


- (void)share:(CDVInvokedUrlCommand*)command;

- (void)isLoggedToTwitter:(CDVInvokedUrlCommand*)command;

- (void)isLoggedToFacebook:(CDVInvokedUrlCommand*)command;

- (void)logoutFromTwitter:(CDVInvokedUrlCommand*)command;

- (void)logoutFromFacebook:(CDVInvokedUrlCommand*)command;

- (void)facebookConnect:(CDVInvokedUrlCommand*)command;

- (void)shareToFacebook:(CDVInvokedUrlCommand*)command;

- (void)shareToTwitter:(CDVInvokedUrlCommand*)command;

- (void)shareToMail:(CDVInvokedUrlCommand*)command;

@end
