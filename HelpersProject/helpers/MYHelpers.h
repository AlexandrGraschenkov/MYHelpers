//
//  MYHelpers.h
//  ___________
//
//  Created by Alexander on 10.08.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYMacros.h"

#pragma mark - UIView+Utils

@interface UIView (Utils)

@property (nonatomic) CGSize  size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// works only when superview has been set
@property (nonatomic) CGFloat rightMarign;
@property (nonatomic) CGFloat bottomMarign;

- (void)removeAllSubviews;

@end

#pragma mark - UIImage+Utils

@interface UIImage (Utils)
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)colorizeImageWithColor:(UIColor *)color;
/// @return `UIImage` with size passed in
- (UIImage *)aspectFillImageWithSize:(CGSize)size;
- (UIImage *)aspectFitImageWithSize:(CGSize)size;
- (BOOL)hasAlpha;
@end

#pragma mark - UIColor+Utils

@interface UIColor (Utils)
+ (UIColor *)randomColor;
+ (UIColor *)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha;
@end

#pragma mark - UIButton+Utls
@interface UIButton (UItils)
@property (nonatomic, strong) NSString *title;
@end

#pragma mark - UIScrollView+Utls

@interface UIScrollView (Utils)
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;
@end

#pragma mark - NSDictionary+Utils

@interface NSDictionary (Utils)
- (id)objectForKeyExcludeNSNull:(id)aKey;
- (NSString *)toCoreDataRequestString;
- (NSString *)toHttpRequestString;
- (NSString*)JSONString;
- (NSData*)JSONData;
@end

#pragma mark - NSArray+Utils

@interface NSArray (Utils)
- (id)objectAtIndexOrNil:(NSUInteger)index;
- (NSArray *)containNotObjects:(NSArray *)array;
- (NSArray *)shuffle;
- (NSArray *)uniqueValues;
- (NSString*)JSONString;
- (NSData*)JSONData;
@end

#pragma mark - NSString+Utils

@interface NSString (Utils)
- (NSString *)trim; // trim whitespace characters with new line
- (NSString *):(NSString *)appendString;
- (NSURL *)toURL;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
- (NSString *)lightURLEncodeString;
+ (BOOL)emailValidate:(NSString *)email;
- (CGSize)sizeForStringWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (id)JSON;
@end

#pragma mark - NSObject+Utils

@interface NSObject (Utils)
- (BOOL)isNotNull;
- (BOOL)isEmpty;
@end

#pragma mark - UITableView+Utils

@interface UITableView (Utils)
- (void)deselectSelectedRow;
@end

