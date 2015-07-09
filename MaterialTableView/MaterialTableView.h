//
//  MaterialTableView.h
//  MaterialTableView
//
//  Created by Tomoya_Hirano on 7/9/27 H.
//  Copyright (c) 27 Heisei Tomoya_Hirano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaterialTableView;
@protocol MaterialTableViewDelegate <NSObject>
- (void)MaterialTableViewWillShowHeader:(MaterialTableView*)view;
- (void)MaterialTableViewDidShowHeader:(MaterialTableView*)view;
@end
@interface MaterialTableView : UIView
- (instancetype)initWithFrame:(CGRect)frame tableView:(UITableView*)tableView;

/**action of button push.*/
@property (nonatomic,assign) void(^buttonBlock)();
/**button hidden*/
@property BOOL buttonHidden;

/**set your header view*/
@property UIView* headerView;
/**header height of header closed*/
@property CGFloat minHeaderHeight;
/**header height of header opened*/
@property CGFloat maxHeaderHeight;

/**button height and width.(must same value)*/
@property CGFloat  buttonSize;
/**button color*/
@property UIColor* buttonColor;
/**button image*/
@property UIImage* buttonImage;

/**delegate*/
@property (nonatomic,assign)id<MaterialTableViewDelegate>delegate;

/**Header view state*/
@property BOOL headerHidden;
@end
