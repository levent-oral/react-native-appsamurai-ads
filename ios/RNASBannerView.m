#import "RNASBannerView.h"

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/UIView+React.h>
#import <React/RCTLog.h>
#else
#import "RCTBridgeModule.h"
#import "UIView+React.h"
#import "RCTLog.h"
#endif

@implementation RNASBannerView
{
    ASBannerView *_bannerView;
}

- (void)dealloc
{
    _bannerView.delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        super.backgroundColor = [UIColor clearColor];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootViewController = [keyWindow rootViewController];
        _bannerView = [[ASBannerView alloc] initWithAdSize:ASAdSize.asAdSizeBanner];
        _bannerView.delegate = self;
        _bannerView.rootViewController = rootViewController;
        [self addSubview:_bannerView];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
    RCTLogError(@"RNASBannerView cannot have subviews");
}
#pragma clang diagnostic pop

- (void)loadBanner
{
    if(self.onSizeChange) {
      CGSize size =  CGSizeMake(320, 50);
//      CGSize size = CGSizeFromGADAdSize(_bannerView.adSize);
        if(!CGSizeEqualToSize(size, self.bounds.size)) {
            self.onSizeChange(@{
                                @"width": @(size.width),
                                @"height": @(size.height)
                                });
        }
    }

  ASAdRequest *request = [[ASAdRequest alloc] init];
  request.testDevices = _testDevices;
  for (NSString *testDevice in request.testDevices) {
    NSLog(@"Test Device: %@",testDevice);
  }
  [_bannerView loadAdWithAdRequest:request];
}

- (void)setTestDevices:(NSArray *)testDevices
{
  NSLog(@"Setting Test Devices");
  _testDevices = testDevices;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _bannerView.frame = self.bounds;
}

# pragma mark GADBannerViewDelegate

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(__unused ASBannerView *)adView
{
   if (self.onAdLoaded) {
       self.onAdLoaded(@{});
   }
}

/// Tells the delegate an ad request failed.
- (void)adView:(__unused ASBannerView *)adView
didFailToReceiveAdWithError:(ASAdRequestError *)error
{
    if (self.onAdFailedToLoad) {
        self.onAdFailedToLoad(@{ @"error": @{ @"message": [error localizedDescription] } });
    }
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(__unused ASBannerView *)adView
{
    if (self.onAdOpened) {
        self.onAdOpened(@{});
    }
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(__unused ASBannerView *)adView
{
    if (self.onAdClosed) {
        self.onAdClosed(@{});
    }
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(__unused ASBannerView *)adView
{
    if (self.onAdLeftApplication) {
        self.onAdLeftApplication(@{});
    }
}
@end