//
//  FamilyTreeView.m
//  Ruslan
//
//  Created by Ruslan on 2/17/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import "FamilyTreeView.h"
#import "CircularImageWithTitle.h"
#import "ImageData.h"

@interface FamilyTreeView () <CircularImageWithTitleDelegate>

@property (nonatomic) CGSize imagesSize;
@property (nonatomic) CGPoint viewCenter;
@property (nonatomic) CGFloat firstOrederRadius;

@property (nonatomic) CGFloat firstX;
@property (nonatomic) CGFloat firstY;

@property (nonatomic) NSMutableArray<CircularImageWithTitle *> * connectionImages;

@end

@implementation FamilyTreeView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) setupView
{
    [self setupSizes];
    
    
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(move:)]];
    
    [self drawAllConnections];
    [self addMainUser];
}

- (void) drawAllConnections
{
    if (self.allConnections == nil) {
        return;
    }
    for (int i = 1; i <= self.allConnections.count; i++) {
        NSArray<ConnectionModel *> * connections = self.allConnections[i - 1];
        CGFloat radius = [self radiusFor:i];
        CGFloat circleLenght = 2 * M_PI * radius;
        CGFloat imageWidth = circleLenght / connections.count;
        CGSize imageSize;
        if (imageWidth <= self.imagesSize.width) {
            imageSize = CGSizeMake(imageWidth, imageWidth);
        }
        else {
            imageSize = self.imagesSize;
        }
        
        CGFloat degreesPerImage = 360 / connections.count;
        int degree = i%2 ? 0 : 30;
        for (int connectionPosition = 0; connectionPosition < connections.count; connectionPosition++) {
            if (degree > 360) {
                degree = degree - 360;
            }
            
            CGFloat radianDegree = [self degreeToRadian:degree];
            CGFloat xPoint = (radius * cos(radianDegree)) + (self.frame.size.width / 2) - (imageSize.width / 2);
            CGFloat yPoint = (radius * sin(radianDegree)) + (self.frame.size.height / 2);
            CGRect frame = CGRectMake(xPoint , yPoint, imageSize.width, imageSize.height);
            ImageData * imageData = [ImageData new];
            imageData.radius = radius;
            imageData.initialRadius = radius;
            imageData.degree = degree;
            imageData.initialSize = imageSize;
            imageData.notch = connections[connectionPosition].connectionId;
            [self addImageWithData:imageData
                             frame:frame
                          imageUrl:connections[connectionPosition].photoUrl
                             title:[connections[connectionPosition] title]];
            degree+= degreesPerImage;
        }
    }
}

- (void) setupSizes
{
    CGFloat lessSideSize = [self lessSideSize];
    
    self.imagesSize = CGSizeMake(lessSideSize * 0.2, lessSideSize * 0.2);
    self.viewCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.firstOrederRadius = [self lessSideSize] * 0.25;
}

- (CGFloat) lessSideSize
{
    CGFloat lessSideSize;
    if (self.frame.size.height > self.frame.size.width) {
        
        lessSideSize = self.frame.size.width;
    }
    else {
        
        lessSideSize = self.frame.size.height;
    }
    return lessSideSize;
}

- (CGFloat) radiusFor:(int)circle
{
    return ([self lessSideSize] * (0.25 * circle));
}

- (void) addMainUser
{
    CGFloat xPoint = self.viewCenter.x - (self.imagesSize.width / 2);
    CGFloat yPoint = self.viewCenter.y;
    CGRect frame = CGRectMake(xPoint, yPoint, self.imagesSize.width, self.imagesSize.height);
    [self addImageWithData:nil
                     frame:frame
                  imageUrl:self.mainUserPhotoURL
                     title:nil];
}

- (CircularImageWithTitle *) addImageWithData:(ImageData *)data
                                        frame:(CGRect)frame
                                     imageUrl:(NSString *)url
                                        title:(NSString *)title
{
    CircularImageWithTitle * image = [[CircularImageWithTitle alloc] initWithFrame:frame];
    [image display:title];
    image.data = data;
    image.delegate = self;
    [image loadImageWithURL:url];
    [self addSubview:image];
    [self bringSubviewToFront:image];
    return image;
}

-(void)move:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:self];
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.firstX = sender.view.center.x;
        self.firstY = translatedPoint.y;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint velocity = [sender velocityInView:self];
        
        for (CircularImageWithTitle * image in self.subviews) {
            if (image.data != nil) {
                CGFloat imageRadius = image.data.radius;
                CGFloat nextRadius;
                if (velocity.y > 0) {
                    nextRadius = imageRadius + (fabs(velocity.y) * 0.01);
                    if (nextRadius >= image.data.initialRadius) {
                        nextRadius = image.data.initialRadius;
                    }
                    image.data.radius = nextRadius;
                    
                } else {
                    nextRadius = imageRadius - (fabs(velocity.y) * 0.01);
                    if (nextRadius <= 0) {
                        nextRadius = 0;
                    }
                    
                    image.data.radius = nextRadius;
                }
                CGFloat radius = image.data.radius;
                CGFloat radianDegree = [self degreeToRadian:image.data.degree];
                CGFloat xPoint = (radius * cos(radianDegree)) + (self.frame.size.width / 2) - (image.frame.size.width / 2);
                CGFloat yPoint = (radius * sin(radianDegree)) + (self.frame.size.height / 2) - (image.frame.size.height / 2);
                CGFloat alpha = 1.0;
                if (radius < self.firstOrederRadius) {
                    alpha = radius / self.firstOrederRadius;
                } else {
                    alpha = 1;
                }
                image.alpha = alpha;
                
                CGFloat newWidth = (radius/self.firstOrederRadius) * image.data.initialSize.width;
                if (newWidth >= image.data.initialSize.width) {
                    newWidth = image.data.initialSize.width;
                }
                CGFloat newHeight = (radius/self.firstOrederRadius) * image.data.initialSize.height;
                if (newHeight >= image.data.initialSize.height) {
                    newHeight = image.data.initialSize.height;
                }
                CGRect frame = CGRectMake(xPoint , yPoint, newWidth, newHeight);
                [image setFrame:frame];
            }
        }
        
        [self layoutSubviews];
    }
}

- (void) reloadData
{
    for (UIView * subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self setupView];
    [self layoutIfNeeded];
}

- (CGFloat) degreeToRadian:(NSInteger)degree
{
    return degree * M_PI / 180;
}

// MARK: - CircularImageWithTitleDelegate
- (void) wasTappedWith:(CircularImageWithTitle *)view
{
    [self.delegate imageWasTappedWith:view.data];
}
@end
