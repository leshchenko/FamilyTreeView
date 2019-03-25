//
//  ImageData.h
//  Ruslan
//
//  Created by Ruslan on 2/24/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageData : NSObject
@property (nonatomic) NSString * notch;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat initialRadius;
@property (nonatomic) CGSize initialSize;
@property (nonatomic) CGFloat degree;
@end

NS_ASSUME_NONNULL_END
