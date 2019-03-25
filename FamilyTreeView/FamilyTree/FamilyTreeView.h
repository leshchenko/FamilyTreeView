//
//  FamilyTreeView.h
//  Ruslan
//
//  Created by Ruslan on 2/17/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionModel.h"
#import "ImageData.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FamilyTreeViewDelegate <NSObject>

- (void) imageWasTappedWith:(ImageData *)data;

@end

@interface FamilyTreeView : UIView

@property (nonatomic) id<FamilyTreeViewDelegate>delegate;
@property (nonatomic) NSString * mainUserPhotoURL;
@property (nonatomic) NSArray<NSArray<ConnectionModel *> *> * allConnections;


- (void) reloadData;

@end

NS_ASSUME_NONNULL_END
