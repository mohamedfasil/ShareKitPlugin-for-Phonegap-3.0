//
//  ShareKitPlugin.m
//
//  Created by Erick Camacho on 28/07/11.
//  MIT Licensed
//  Phonegap 3.0 support by Mohamed Fasil

#import "ShareKitPlugin.h"
#import "SHKActionSheet.h"
#import "SHKTwitter.h"
#import "SHKFacebook.h"
#import "SHKMail.h"


@interface ShareKitPlugin ()

- (void)IsLoggedToService:(BOOL)isLogged callback:(NSString *) callback;

@end

@implementation ShareKitPlugin


- (void)share:(CDVInvokedUrlCommand*)command {
    
    NSString *message = [command.arguments objectAtIndex:0];
    SHKItem *item;
    
    if ([command.arguments count] == 2) {
        NSURL *itemUrl = [NSURL URLWithString:[command.arguments objectAtIndex:1]];
        item = [SHKItem URL:itemUrl title:message contentType:SHKURLContentTypeWebpage];
    } else {
        item = [SHKItem text:message];
    }
    
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [SHK setRootViewController:self.viewController];
    
	[actionSheet showInView:self.viewController.view];
}

- (void)isLoggedToTwitter:(CDVInvokedUrlCommand*)command {
    NSString *callback = [command.arguments objectAtIndex:0];
    [self IsLoggedToService:[SHKTwitter isServiceAuthorized] callback:callback];
}

- (void)isLoggedToFacebook:(CDVInvokedUrlCommand*)command {
    
    NSString *callback = [command.arguments objectAtIndex:0];
    [self IsLoggedToService:[SHKFacebook isServiceAuthorized] callback:callback];
}

- (void)IsLoggedToService:(BOOL)isLogged callback:(NSString *) callback {
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsInt: isLogged ];
    [self writeJavascript:[pluginResult toSuccessCallbackString:callback]];
}


- (void)logoutFromTwitter:(CDVInvokedUrlCommand*)command {
    [SHKTwitter logout];
}

- (void)logoutFromFacebook:(CDVInvokedUrlCommand*)command {
    
    [SHKFacebook logout];
}

- (void)facebookConnect:(CDVInvokedUrlCommand*)command {
    if (![SHKFacebook isServiceAuthorized]) {
        [SHK setRootViewController:self.viewController];
        [SHKFacebook loginToService];
    }
}

- (void)shareToFacebook:(CDVInvokedUrlCommand*)command {
    
    [SHK setRootViewController:self.viewController];
    
    SHKItem *item;
    
    NSString *message = [command.arguments objectAtIndex:1];
    if ([command.arguments objectAtIndex:2]==NULL) {
        NSURL *itemUrl = [NSURL URLWithString:[command.arguments objectAtIndex:2]];
        item = [SHKItem URL:itemUrl title:message contentType:SHKURLContentTypeWebpage];
    } else {
        item = [SHKItem text:message];
    }
    
    [SHKFacebook shareItem:item];
    
}

- (void)shareToTwitter:(CDVInvokedUrlCommand*)command {
    [SHK setRootViewController:self.viewController];
    
    SHKItem *item;
    
    NSString *message = [command.arguments objectAtIndex:1];
    if ([command.arguments objectAtIndex:2]==NULL) {
        NSURL *itemUrl = [NSURL URLWithString:[command.arguments objectAtIndex:2]];
        item = [SHKItem URL:itemUrl title:message contentType:SHKURLContentTypeWebpage];
    } else {
        item = [SHKItem text:message];
    }
    
    [SHKTwitter shareItem:item];
    
}

- (void)shareToMail:(CDVInvokedUrlCommand*)command {
    [SHK setRootViewController:self.viewController];
    
    SHKItem *item;
    
    NSString *subject = [command.arguments objectAtIndex:1];
    NSString *body = [command.arguments objectAtIndex:2];
    
    item = [SHKItem text:body];
    item.title = subject;
    
    [SHKMail shareItem:item];
    
}

@end
