//
//  ChooseLanguageCell.m
//  PlayCarParadise
//
//  Created by liuyujia on 2018/4/11.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import "ChooseLanguageCell.h"
@interface ChooseLanguageCell()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation ChooseLanguageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLbl];
        [self addSubview:self.iconImg];
        [self addSubview:self.lineView];
        [self makeConstrain];
    }
    return self;
}

-(void)makeConstrain{
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(15*layoutBy6());
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(90*layoutBy6());
    }];
    
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20*layoutBy6());
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(15*layoutBy6());
        make.width.mas_equalTo(15*layoutBy6());
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5*layoutBy6());
    }];
}

#pragma mark - getter and setter
-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:13*layoutBy6()];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLbl;
}

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [UIImageView new];
        _iconImg.image = imageName(@"shoppingcart_header_unselected");
    }
    return _iconImg;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = hexStringToColor(@"c4c4c4");
    }
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self changeSelectionColorForSelectedOrHiglightedState:selected];
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    [super setHighlighted:highlighted animated:animated];
////    [self changeSelectionColorForSelectedOrHiglightedState:highlighted];
//}

#pragma mark - private methods
- (void)changeSelectionColorForSelectedOrHiglightedState:(BOOL)state
{
    if (state) {
        //选中时候的样式
        _iconImg.image = imageName(@"shoppingcart_header_selected");
    }else{
        _iconImg.image = imageName(@"shoppingcart_header_unselected");

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
