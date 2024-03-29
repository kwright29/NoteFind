//
//  InfiniteScrollActivityView.m
//  NoteFind
//
//  Created by Khloe Wright on 7/28/22.
//

#import "InfiniteScrollActivityView.h"

@implementation InfiniteScrollActivityView

UIActivityIndicatorView* activityIndicatorView;
static CGFloat kInfiniteScrollActivityViewDefaultHeight = 60.0;

+ (CGFloat)defaultHeight{
    return kInfiniteScrollActivityViewDefaultHeight;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setupActivityIndicator];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupActivityIndicator];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (void)setupActivityIndicator{
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
    activityIndicatorView.hidesWhenStopped = true;
    [self addSubview:activityIndicatorView];
}

-(void)stopAnimating{
    [activityIndicatorView stopAnimating];
    self.hidden = true;
}

-(void)startAnimating{
    self.hidden = false;
    [activityIndicatorView startAnimating];
}


@end
