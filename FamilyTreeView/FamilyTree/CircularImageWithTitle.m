//
//  CircularImageWithTitle.m
//  Ruslan
//
//  Created by Ruslan on 2/17/19.
//  Copyright © 2019 Ruslan. All rights reserved.
//

#import "CircularImageWithTitle.h"


@interface CircularImageWithTitle()

@property (strong, nonatomic) IBOutlet UIView * contentView;
@property (weak, nonatomic) IBOutlet UIImageView * circularImageView;
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@end

@implementation CircularImageWithTitle


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"CircularImageWithTitle" owner:self options:nil];
        self.contentView.frame = frame;
        self.bounds = frame;
        [self addSubview:self.contentView];
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"CircularImageWithTitle" owner:self options:nil];
        [self addSubview:self.contentView];
        [self setupViews];
    }
    return self;
}


- (void)layoutSubviews
{
    self.circularImageView.layer.cornerRadius = self.circularImageView.frame.size.width/2;
}

- (void) setupViews
{
    self.circularImageView.layer.cornerRadius = self.circularImageView.frame.size.width/2;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(tapOnView:)]];
}

- (void) tapOnView:(UITapGestureRecognizer *)tap
{
    [self.delegate wasTappedWith:self];
}

- (void) loadImageWithURL:(NSString *)url
{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
        if (data == nil) {
            
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.circularImageView.image = [UIImage imageWithData: data];
        });
    });
}

- (void)display:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
