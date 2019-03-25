//
//  CircularImageWithTitle.h
//  Ruslan
//
//  Created by Ruslan on 2/17/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageData.h"

NS_ASSUME_NONNULL_BEGIN
@class CircularImageWithTitle;

@protocol CircularImageWithTitleDelegate <NSObject>

- (void) wasTappedWith:(CircularImageWithTitle *)view;

@end

@interface CircularImageWithTitle : UIView

@property (nonatomic) id<CircularImageWithTitleDelegate>delegate;

- (void) loadImageWithURL:(NSString *)url;
- (void) display:(NSString *)title;

@property (nonatomic) ImageData * data;

@end

NS_ASSUME_NONNULL_END
