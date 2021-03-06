//
//  RNAppSamuraiInterstitial.h
//  RNAppSamuraiAds
//
//  Created by Levent ORAL on 31.07.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#else
#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"
#endif

@import AppSamuraiAdSDK;

@interface RNAppSamuraiInterstitial : RCTEventEmitter <RCTBridgeModule, ASInterstitialDelegate>

@end
