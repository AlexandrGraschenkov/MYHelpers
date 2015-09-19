//
//  MYHelpers.m
//  ___________
//
//  Created by Alexander on 10.08.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MYHelpers.h"

@interface UIGradientView : UIView
@property (nonatomic,readonly,retain) CAGradientLayer  *layer;
@end

@implementation UIGradientView
+ (Class)layerClass {
    return [CAGradientLayer class];
}
@end

@implementation UIView (Utils)

#pragma mark - Frame Setters/Getters
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.frame.size.width;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.frame.size.height;
}

- (CGFloat)rightMarign {
    return self.superview.bounds.size.width - CGRectGetMaxX(self.frame);
}

- (void)setRightMarign:(CGFloat)rightMarign {
    self.x = self.superview.bounds.size.width - rightMarign - self.frame.size.width;
}

- (CGFloat)bottomMarign {
    return self.superview.bounds.size.height - CGRectGetMaxY(self.frame);
}

- (void)setBottomMarign:(CGFloat)bottomMarign {
    self.y = self.superview.bounds.size.height - bottomMarign - self.frame.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)position {
    CGRect frame = self.frame;
    frame.origin = position;
    [self setFrame:frame];
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    [self setFrame:frame];
}

#pragma mark -

- (void)removeAllSubviews {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

@end

#pragma mark - UIImage+Utils

@implementation UIImage (Utils)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

#pragma mark - UIColor+Utils

@implementation UIColor (Utils)
+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)colorWithHexValue:(uint)hexValue andAlpha:(float)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [UIColor colorWithHexString:hexString andAlpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(float)alpha
{
    UIColor *col;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue])
        col = [self colorWithHexValue:hexValue andAlpha:alpha];
    else
        // invalid hex string
        col = [self blackColor];
    return col;
}

@end

#pragma mark - UIScrollView+Utls

@implementation UIScrollView (Utils)
- (CGFloat)contentWidth {
    return self.contentSize.width;
}
- (void)setContentWidth:(CGFloat)contentWidth {
    self.contentSize = CGSizeMake(contentWidth, self.contentSize.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}
- (void)setContentHeight:(CGFloat)contentHeight {
    self.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
}
@end

#pragma mark - NSDictionary+Utils

@implementation NSDictionary (Utils)

- (id)objectForKeyExcludeNSNull:(id)aKey {
    id obj = [self objectForKey:aKey];
    return ([obj isKindOfClass:[NSNull class]]) ? nil : obj;
}

- (NSString *)toHttpRequestString {
    NSMutableArray *arrayOfPairs = [NSMutableArray arrayWithCapacity:[self allKeys].count];
    for (NSString *key in [self allKeys]) {
        NSString *value = [self valueForKey:key];
        NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [arrayOfPairs addObject:pair];
    }
    NSString *toReturn = [arrayOfPairs componentsJoinedByString:@"&"];
    return toReturn;
}

- (NSString *)toCoreDataRequestString {
    NSString *toReturn = @"(YES == YES)";
    for (NSString *key in [self allKeys]) {
        NSString *value = [self valueForKey:key];
        NSString *pair = [NSString stringWithFormat:@" AND (%@ == %@)", key, value];
        toReturn = [toReturn stringByAppendingString:pair];
    }
    return toReturn;
}

- (NSString*)JSONString {
    return [[NSString alloc]initWithData:self.JSONData encoding:NSUTF8StringEncoding];
}

- (NSData*)JSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}
@end

#pragma mark - NSArray+Utils

@implementation NSArray (Utils)

- (id)objectAtIndexOrNil:(NSUInteger)index{
    if (index < self.count)
        return [self objectAtIndex:index];
    return nil;
}

- (NSArray *)containNotObjects:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray new];
    for (id object in array) {
        if (![self containsObject:object]) {
            [result addObject:object];
        }
    }
    return result;
}

- (NSArray *)shuffle
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [NSArray arrayWithArray:array];
}

- (NSString*)JSONString {
    return [[NSString alloc]initWithData:self.JSONData encoding:NSUTF8StringEncoding];
}

- (NSData*)JSONData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}
@end

#pragma mark - NSString+Utils

@implementation NSString (Utils)

- (NSString *)append:(NSString *)appendString {
    return [self stringByAppendingString:appendString];
}
- (NSURL*)toURL {
    return [NSURL URLWithString:self];
}

- (NSString *)URLEncodedString {
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();@&=+$,?%#[]", kCFStringEncodingUTF8));
	return encodedString;
}

- (NSString *)URLDecodedString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)lightURLEncodeString {
    NSMutableString *tempStr = [NSMutableString stringWithString:self];
    [tempStr replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempStr length])];
    return [[NSString stringWithFormat:@"%@",tempStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (BOOL)emailValidate:(NSString *)email {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:email];
}

- (CGSize)sizeForStringWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    CGSize boundingSize = {size.width, MAXFLOAT};
    CGRect contentRect = [self boundingRectWithSize:boundingSize
                                            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes:@{NSFontAttributeName:font}
                                            context:NULL];
    return CGSizeMake(size.width, ceilf(contentRect.size.height));
#else
    // iOS 6
    contentSize = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(size.width, MAXFLOAT)];
    return CGSizeMake(size.width, ceilf(contentSize.height));
#endif
}

- (id)JSON
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

@end

#pragma mark - NSObject+Utils

@implementation NSObject (Utils)

- (BOOL)isEmpty {
    return self == nil
    || ([self respondsToSelector:@selector(length)]
        && [(NSData *)self length] == 0)
    || ([self respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0)
    || ([self respondsToSelector:@selector(isEqualToString:)]
        && [(NSString *)self isEqualToString:@""]);
}

- (BOOL)isNotNull {
    return ![self isKindOfClass:[NSNull class]];
}

@end

#pragma mark - UiTableView+Utils

@implementation UITableView (Utils)

- (void)deselectSelectedRow {
    [self deselectRowAtIndexPath:self.indexPathForSelectedRow animated:YES];
}

@end
