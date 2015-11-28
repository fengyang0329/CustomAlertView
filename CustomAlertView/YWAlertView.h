//
//  YWAlertView.h
//  CustomAlertView
//
//  Created by 龙章辉 on 15/11/27.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YWAlertViewDelegate;
@interface YWAlertView : UIView

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,weak)id<YWAlertViewDelegate>delegate;


- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate buttonTitles:(nullable NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;
- (void)dismiss;

/**
 *  设置每个按钮的标题颜色
 *
 */
- (void)setButtonTitlesColor:(nullable UIColor *)color,...;

/**
 *  设置某个按钮的标题颜色
 *
 */
- (void)setbuttonTitleColor:(UIColor *)color WithIndex:(NSInteger)index;


/**
 *  设置每个按钮的标题font
 *
 */
- (void)setButtonTitlesFont:(nullable UIFont *)font,...;

/**
 *  设置某个按钮的标题font
 *
 */
- (void)setbuttonTitleFont:(UIFont *)font WithIndex:(NSInteger)index;

@end


@protocol YWAlertViewDelegate <NSObject>

@optional
- (void)alertView:(YWAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


NS_ASSUME_NONNULL_END