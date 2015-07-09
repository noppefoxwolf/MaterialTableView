//
//  MaterialTableView.m
//  MaterialTableView
//
//  Created by Tomoya_Hirano on 7/9/27 H.
//  Copyright (c) 27 Heisei Tomoya_Hirano. All rights reserved.
//

#import "MaterialTableView.h"
@interface MaterialTableView (){
    
}

@property UIButton*button;
@property UITableView*tableView;
@end

@implementation MaterialTableView
@synthesize headerView = _headerView,buttonHidden= _buttonHidden;

- (instancetype)initWithFrame:(CGRect)frame tableView:(UITableView*)tableView{
    self = [super initWithFrame:frame];
    if (self) {
        self.minHeaderHeight = 44;
        self.maxHeaderHeight = 44*3;
        self.buttonSize = 56;
        self.buttonColor = [UIColor orangeColor];
        self.buttonImage = nil;
        
        self.tableView = tableView;
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addSubview:self.tableView];
        
        self.headerView = [UIView new];
        self.headerView.backgroundColor = [UIColor redColor];
        [self addSubview:self.headerView];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button addTarget:self action:@selector(pushButton) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.button];
        
        self.headerHidden = true;
        self.buttonHidden = false;
        [self layoutSubviews];
    }
    return self;
}

- (void)pushButton{
    self.buttonBlock?self.buttonBlock():nil;
}

- (void)layoutSubviews{
    [self syncUIProperty];
    [self headerViewHidden:self.headerHidden animate:false];
}

- (void)syncUIProperty{
    [self.button setBackgroundColor:self.buttonColor];
    [self.button setImage:self.buttonImage forState:UIControlStateNormal];
    self.button.hidden = self.buttonHidden;
}

- (void)headerViewHidden:(BOOL)hidden animate:(BOOL)animate{
    if ([self.delegate respondsToSelector:@selector(MaterialTableViewWillShowHeader:)]) {
        [self.delegate MaterialTableViewWillShowHeader:self];
    }
    
    CGRect headerRect;
    CGRect tableRect;
    CGRect buttonRect;
    CGFloat headerHeight = hidden?self.minHeaderHeight:self.maxHeaderHeight;
    headerRect = CGRectMake(0,
                            0,
                            self.bounds.size.width,
                            headerHeight);
    tableRect = CGRectMake(0,
                           headerHeight,
                           self.bounds.size.width,
                           self.bounds.size.height-headerHeight);
    buttonRect = CGRectMake(self.bounds.size.width-self.buttonSize-16,
                            headerHeight-(self.buttonSize/2),
                            self.buttonSize,
                            self.buttonSize);
    self.button.layer.cornerRadius = self.buttonSize/2;
    self.button.layer.shadowOpacity = 0.5;
    self.button.layer.shadowRadius = 1.0;
    self.button.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    if (animate) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.headerView.frame = headerRect;
                             self.tableView.frame = tableRect;
                             self.button.frame = buttonRect;
                         } completion:^(BOOL finished) {
                             if ([self.delegate respondsToSelector:@selector(MaterialTableViewDidShowHeader:)]) {
                                 [self.delegate MaterialTableViewDidShowHeader:self];
                             }
                         }];
    }else{
        self.headerView.frame = headerRect;
        self.tableView.frame = tableRect;
        self.button.frame = buttonRect;
        if ([self.delegate respondsToSelector:@selector(MaterialTableViewDidShowHeader:)]) {
            [self.delegate MaterialTableViewDidShowHeader:self];
        }
    }
}

- (void)setHeaderView:(UIView *)headerView{
    [self.button removeFromSuperview];
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [self addSubview:_headerView];
    [self.headerView addSubview:self.button];
    [self layoutSubviews];
}

- (UIView*)headerView{
    return _headerView;
}

- (void)setButtonHidden:(BOOL)buttonHidden{
    _buttonHidden = buttonHidden;
    [self layoutSubviews];
}

- (BOOL)buttonHidden{
    return _buttonHidden;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if([object isKindOfClass:[UITableView class]]
       && [keyPath isEqualToString:@"contentOffset"]){
        if (self.tableView.contentOffset.y>0) {
            if (!self.headerHidden) {
                self.headerHidden = true;
                [self headerViewHidden:true animate:true];
            }
        }else{
            if (self.headerHidden) {
                self.headerHidden = false;
                [self headerViewHidden:false animate:true];
            }
        }
    }
}

- (void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

@end
