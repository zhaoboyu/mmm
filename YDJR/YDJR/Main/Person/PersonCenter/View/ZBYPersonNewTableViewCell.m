//
//  ZBYPersonNewTableViewCell.m
//  YDJR
//
//  Created by 赵博宇 on 2017/6/21.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYPersonNewTableViewCell.h"



@implementation ZBYPersonNewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self.selected) {
            self.textnewLabel.textColor = [UIColor hexString:@"#333333"];
        }else{
            self.textnewLabel.textColor = [UIColor hexString:@"#999999"];
        }
    }
    return self;
}
@end
