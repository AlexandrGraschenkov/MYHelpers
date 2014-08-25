//
//  Macros.h
//  Rubin
//
//  Created by Alexander on 10.08.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#ifndef Rubin_Macros_h
#define Rubin_Macros_h

#define ApplicationDirectoryPath(DirectoryToSearch) ((NSString *)[NSSearchPathForDirectoriesInDomains(DirectoryToSearch, NSUserDomainMask, YES) objectAtIndex:0])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define ScreenSize                          ((CGSize *)(([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height) : CGSizeMake([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width))
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IS_IPAD                             ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IS_IPHONE                           ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad)
#define IS_IPHONE_5                         ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IOS_7                            ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0f)
#define IS_RETINA                           ([UIScreen mainScreen].scale==2.0)
#define IS_LANDSCAPE                        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
#define ONE_PIXEL                           (1.0f / [UIScreen mainScreen].scale)
#define BLOCK_SAFE_RUN(block, ...)          block ? block(__VA_ARGS__) : nil

#ifdef DEBUG
#define MYLog(...) NSLog(__VA_ARGS__)
#else
#define MYLog(...)
#endif

/// weak self in block
/* Usage:
 @weakself(^(NSObject *obj)) {
 NSLog(@"%@ %@", [self description], obj);
 return 0;
 } @weakselfend ;
*/
#define weakself(ARGS) \
"weakself should be called as @weakself" @"" ? \
({  __weak typeof(self) _private_weakSelf = self; \
ARGS { \
__strong typeof(_private_weakSelf) self __attribute__((unused)) = _private_weakSelf; \
return ^ (void) {

#define weakselfnotnil(ARGS) \
"weakself should be called as @weakself" @"" ? \
({  __weak typeof(self) _private_weakSelf = self; \
ARGS { \
__strong typeof(_private_weakSelf) self __attribute__((unused)) = _private_weakSelf; \
return ^ (void) { if (self)

#define weakselfend \
try {} @finally {} } (); }; \
}) : nil

#endif
