//
//  ZBYPersonNewTableViewCell.h
//  YDJR
//
//  Created by 赵博宇 on 2017/6/21.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBYPersonNewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *seletedImage;

@property (weak, nonatomic) IBOutlet UILabel *textnewLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redWidth;

@end
