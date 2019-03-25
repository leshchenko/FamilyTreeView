//
//  ConnectionModel.h
//  Ruslan
//
//  Created by Ruslan on 2/17/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectionModel : NSObject

@property (nonatomic) NSString * title;
@property (nonatomic) NSString * photoUrl;
@property (nonatomic) NSString * connectionId;
@property (nonatomic) int connectionLevel;

@end

NS_ASSUME_NONNULL_END
