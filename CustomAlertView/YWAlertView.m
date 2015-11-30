//
//  YWAlertView.m
//  CustomAlertView
//
//  Created by 龙章辉 on 15/11/27.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import "YWAlertView.h"

#define kContentWidth 270.0
#define kStartX 20.0  //标题和提示语距离左右两边的间距
#define kStartY 15.0
#define kSpaceY 10.0  //Y轴间距

#define kTitleColor [UIColor colorWithRed:(72/255.0) green:(72/255.0) blue:(72/255.0) alpha:1.0]
#define kMessageColor [UIColor colorWithRed:(137/255.0) green:(137/255.0) blue:(137/255.0) alpha:1.0]
#define kDefaultBtnTitleColor [UIColor colorWithRed:(0/255.0) green:(149/255.0) blue:(226/255.0) alpha:1.0]

#define kLineWid 1
#define kLineColor [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1.0]

#define kBtnHeight 45

@interface YWAlertView ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView  *contentBgView;
@property(nonatomic,strong)UIView  *lineView;
@property(nonatomic,assign)BOOL visible;
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)NSMutableArray *btns;

@end
@implementation YWAlertView


- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate buttonTitles:(nullable NSString *)buttonTitles, ...
{
    if (self==[super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        UIColor *bgColor = [UIColor blackColor];
        bgColor = [bgColor colorWithAlphaComponent:0.3];
        [self setBackgroundColor:bgColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self];

        _visible = NO;
        self.alpha = 0.0;
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = NO;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        
        _contentBgView = [[UIView alloc] init];
        _contentBgView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentBgView.clipsToBounds = YES;
        _contentBgView.layer.cornerRadius = 8;
        [_contentBgView setBackgroundColor:[UIColor whiteColor]];
        [_scrollView addSubview:_contentBgView];
        

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_scrollView attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-startX-[_contentBgView]-startX-|" options:0 metrics:@{@"startX":@(kStartX)} views:NSDictionaryOfVariableBindings(_contentBgView)]];
        [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentBgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentBgView)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentBgView attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
         [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentBgView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kContentWidth]];
        
        if (title.length > 0)
        {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
            _titleLabel.textColor = kTitleColor;
            _titleLabel.numberOfLines = 0;
            [_titleLabel setBackgroundColor:[UIColor clearColor]];
            _titleLabel.text = title;
            [_contentBgView addSubview:_titleLabel];
        }
       

        if (message.length > 0)
        {
            _messageLabel = [[UILabel alloc] init];
            _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _messageLabel.textAlignment = NSTextAlignmentCenter;
            _messageLabel.font = [UIFont systemFontOfSize:14.0];
            _messageLabel.textColor = kMessageColor;
            _messageLabel.numberOfLines = 0;
            [_messageLabel setBackgroundColor:[UIColor clearColor]];
            _messageLabel.text = message;
            [_contentBgView addSubview:_messageLabel];
        }
    
        va_list args;
        va_start(args, buttonTitles);
        _titles = [NSMutableArray array];
        for (NSString *str = buttonTitles; str != nil; str = va_arg(args,NSString*))
        {
            [_titles addObject:str];
        }
        if (_titles.count > 0 && (_titleLabel || _messageLabel))
        {
            _lineView = [[UIView alloc] init];
            _lineView.translatesAutoresizingMaskIntoConstraints = NO;
            [_lineView setBackgroundColor:kLineColor];
            [_contentBgView addSubview:_lineView];
        }

        [self addContentBgViewConstraints];
    }
    return self;
}


- (void)show
{
    if (!_visible)
    {
        _visible = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
        }completion:nil];
    }
}

- (void)dismiss
{
    if (_visible)
    {
        _visible = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.0;
        }completion:nil];
    }
}

- (void)addContentBgViewConstraints
{
    if (_titleLabel)
    {
          [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-startX-[_titleLabel]-startX-|" options:0 metrics:@{@"startX":@(kStartX)} views:NSDictionaryOfVariableBindings(_titleLabel)]];
          [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-startY-[_titleLabel]" options:0 metrics:@{@"startY":@(kStartY)} views:NSDictionaryOfVariableBindings(_titleLabel)]];
    }
    if(_messageLabel)
    {
        [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-startX-[_messageLabel]-startX-|" options:0 metrics:@{@"startX":@(kStartX)} views:NSDictionaryOfVariableBindings(_messageLabel)]];
        [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeTop relatedBy:0 toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kSpaceY]];
        
    }
    if (_titles.count > 0)
    {
        if (_lineView)
        {
            [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_lineView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lineView)]];
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeTop relatedBy:0 toItem:_messageLabel?_messageLabel:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:kSpaceY]];
             [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:kLineWid]];
        }
        //添加底部点击按钮
        [self initButtons];
    }
    else
    {
        if (_messageLabel)
        {
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel attribute:NSLayoutAttributeBottom relatedBy:0 toItem:_contentBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kStartY]];
        }
        else if(_titleLabel)
        {
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:0 toItem:_contentBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-kStartY]];
        }

    }
}


- (void)initButtons
{
    if (_titles.count==0)
    {
        return;
    }
    if (_btns==nil)
    {
        _btns = [NSMutableArray array];
    }
    //按钮个数小于等于2，横排，大于2，坚排
    if (_titles.count <=2)
    {
        float btnWidth = kContentWidth/_titles.count;
        UIButton *tmpBtn;
        for (int i=0; i<_titles.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:kDefaultBtnTitleColor forState:UIControlStateNormal];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [_contentBgView addSubview:btn];
            
            
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:0 toItem:_lineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:kBtnHeight]];
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:btnWidth]];
            
            if (i == _titles.count-1)
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:0 toItem:_contentBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            }
            if (tmpBtn)
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
                
                //添加按钮分隔线
                UIView *line = [[UIView alloc] init];
                line.translatesAutoresizingMaskIntoConstraints = NO;
                [line setBackgroundColor:kLineColor];
                [_contentBgView addSubview:line];
                
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeLeading relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
                 [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeTop relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
                 [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeBottom relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
                 [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kLineWid]];
            }
            else
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeading relatedBy:0 toItem:_contentBgView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
            }
            
            tmpBtn = btn;
            [_btns addObject:btn];
            
        }
    }
    else
    {
        UIButton *tmpBtn;
        for (int i=0; i<_titles.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:kDefaultBtnTitleColor forState:UIControlStateNormal];
            btn.translatesAutoresizingMaskIntoConstraints = NO;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [_contentBgView addSubview:btn];
            
             [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btn]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)]];
            [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:kBtnHeight]];
          
            if (i == _titles.count-1)
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:0 toItem:_contentBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            }
            if (tmpBtn)
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
                
                //添加按钮分隔线
                UIView *line = [[UIView alloc] init];
                line.translatesAutoresizingMaskIntoConstraints = NO;
                [line setBackgroundColor:kLineColor];
                [_contentBgView addSubview:line];
                
                 [_contentBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[line]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(line)]];
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeTop relatedBy:0 toItem:tmpBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:line attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:kLineWid]];
            }
            else
            {
                [_contentBgView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:0 toItem:_lineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            }
            tmpBtn = btn;
            [_btns addObject:btn];
        }

    }
}


#pragma mark 按钮点击方法
- (void)clickedBtn:(UIButton *)btn
{
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:btn.tag];
    }
}

#pragma mark setting

#pragma mark Color Setting
- (void)setButtonTitlesColor:(UIColor *)color, ...
{
    va_list args;
    va_start(args, color);
    NSMutableArray *colors = [NSMutableArray array];
    for (UIColor *tmpColor = color; tmpColor != nil; tmpColor = va_arg(args,UIColor*))
    {
        if ([tmpColor isKindOfClass:[UIColor class]])
        {
            [colors addObject:tmpColor];
        }
        
    }
    for (int i=0; i<_btns.count; i++)
    {
        UIColor *titleColor;
        UIButton *btn = _btns[i];
        if (colors.count > i)
        {
            titleColor = colors[i];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setbuttonTitleColor:(UIColor *)color WithIndex:(NSInteger)index
{
    UIColor *titleColor;
    if (![color isKindOfClass:[UIColor class]]) {
        return;
    }
    titleColor = color;
    if (_btns.count > index)
    {
        UIButton *btn = _btns[index];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];

    }
}


#pragma mark Font Setting
- (void)setButtonTitlesFont:(UIFont *)font, ...
{
    va_list args;
    va_start(args, font);
    NSMutableArray *fonts = [NSMutableArray array];
    for (UIFont *tmpFont = font; tmpFont != nil; tmpFont = va_arg(args,UIFont*))
    {
        if ([tmpFont isKindOfClass:[UIFont class]])
        {
            [fonts addObject:tmpFont];
        }
        
    }
    for (int i=0; i<_btns.count; i++)
    {
        UIFont *titleFont;
        UIButton *btn = _btns[i];
        if (fonts.count > i)
        {
            titleFont = fonts[i];
            [btn.titleLabel setFont:titleFont];
        }
    }
}

- (void)setbuttonTitleFont:(UIFont *)font WithIndex:(NSInteger)index
{
    UIFont *titleFont;
    if (![font isKindOfClass:[UIFont class]]) {
        return;
    }
    titleFont = font;
    if (_btns.count > index)
    {
        UIButton *btn = _btns[index];
        [btn.titleLabel setFont:titleFont];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
