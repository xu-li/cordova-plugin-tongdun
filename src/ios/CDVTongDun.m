//
//  CDVTongDun.m
//  cordova-plugin-tongdun
//
//  Created by xu.li on 12/23/13.
//
//

#import "CDVTongDun.h"
#import "FMDeviceManager.h"

@implementation CDVTongDun


- (void)pluginInitialize {
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];

    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    NSString* sandbox = [[self.commandDelegate settings] objectForKey:@"tongdun_sandbox"];
    NSString* partnerId = [[self.commandDelegate settings] objectForKey:@"tongdun_partner_id"];
    
    if ([sandbox isEqual:@"true"]) {
        [options setValue:@"sandbox" forKey:@"env"];
    } else {
        [options setValue:@"product" forKey:@"env"];
    }
    
    [options setValue:partnerId forKey:@"partner"];
    
    manager->initWithOptions(options);
}


- (void)getSignature:(CDVInvokedUrlCommand *)command
{
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    NSString *signature = manager->getDeviceInfo();
    
    NSLog(@"Signature: %@", signature);
    
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:signature];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}

@end
