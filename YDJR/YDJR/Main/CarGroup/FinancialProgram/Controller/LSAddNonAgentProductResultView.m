//
//  LSAddNonAgentProductResultView.m
//  YDJR
//
//  Created by 李爽 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductResultView.h"
#import "LSChoosedProductsModel.h"
#import "LSAddNonAgentProductResultTableViewCell.h"

#define CELL_ID      @"CELL_ID"
@interface LSAddNonAgentProductResultView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *leftTitlesArray;

@end

@implementation LSAddNonAgentProductResultView

- (instancetype)initWithFrame:(CGRect)frame productModel:(LSChoosedProductsModel *)choosedProductsModel
{
	self = [super initWithFrame:frame];
	if (self) {
		self.choosedProductsModel = choosedProductsModel;
		[self p_setupView];
	}
	return self;
}

#pragma mark - p_setupView
-(void)p_setupView
{
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1696 * wScale, 1256 * hScale) style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[LSAddNonAgentProductResultTableViewCell class] forCellReuseIdentifier:CELL_ID];
	[self addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 7;
	}else{
		return 6;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LSAddNonAgentProductResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
	if (indexPath.section == 1 && indexPath.row == 5) {
		cell.L_subTitleLable.font = [UIFont systemFontOfSize:17];
		cell.L_subTitleLable.textColor = [UIColor hexString:@"#FF000000"];
	}else{
		cell.L_subTitleLable.font = [UIFont systemFontOfSize:15];
		cell.L_subTitleLable.textColor = [UIColor hexString:@"#FF666666"];
	}
	if (indexPath.section == 0) {
		cell.L_subTitleLable.text = self.leftTitlesArray[indexPath.section][indexPath.row];
		cell.L_ContentLable.textColor = [UIColor hexString:@"#FF000000"];
		if (indexPath.row == 0) {
			cell.L_TitleLable.hidden = NO;
			cell.L_TitleLable.text = @"表面支出";
			cell.L_ContentLable.text = [self.choosedProductsModel.cj cut];
		}else{
			cell.L_TitleLable.hidden = YES;
			if (indexPath.row == 1) {
				cell.L_ContentLable.text = [self.choosedProductsModel.gzs cut];
			}
			if (indexPath.row == 2) {
				cell.L_ContentLable.text = [self.choosedProductsModel.bx cut];
			}
			if (indexPath.row == 3) {
				cell.L_ContentLable.text = [[self.choosedProductsModel.yg cutOutStringContainsDot]cut];
			}
			if (indexPath.row == 4) {
				cell.L_ContentLable.text = [self.choosedProductsModel.dkfwf cut];
			}
			if (indexPath.row == 5) {
				cell.L_ContentLable.text = [self.choosedProductsModel.qs cut];
			}
			if (indexPath.row == 6) {
				cell.L_ContentLable.text = [self.choosedProductsModel.lgj cut];
			}
		}
		return cell;
	}else{
		if (indexPath.row == 5) {
			cell.L_TitleLable.text = @"实际购车成本";
			cell.L_TitleLable.hidden = NO;
			cell.L_subTitleLable.text = [self.choosedProductsModel.khsjgccb cut];
			cell.L_ContentLable.text = @"";
			return cell;
		}else{
			cell.L_subTitleLable.text = self.leftTitlesArray[indexPath.section][indexPath.row];
			cell.L_ContentLable.textColor = [UIColor hexString:@"#FF1DBA35"];
			if (indexPath.row == 0) {
				cell.L_TitleLable.hidden = NO;
				cell.L_TitleLable.text = @"政策优惠";
				cell.L_ContentLable.text = [self.choosedProductsModel.cjrl cut];
			}else{
				cell.L_TitleLable.hidden = YES;
				if (indexPath.row == 1) {
					cell.L_ContentLable.text = [self.choosedProductsModel.by cut];
				}
				if (indexPath.row == 2) {
					cell.L_ContentLable.text = [self.choosedProductsModel.tzhb cut];
				}
				if (indexPath.row == 3) {
					cell.L_ContentLable.text = [self.choosedProductsModel.kpz cut];
				}
				if (indexPath.row == 4) {
					cell.L_ContentLable.text = [self.choosedProductsModel.gskds cut];
				}
			}
			return cell;
		}
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112 * hScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 24 * hScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 24 * hScale)];
	view.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
	return view;
}

#pragma mark - lazyload
- (NSArray *)leftTitlesArray
{
	if (!_leftTitlesArray) {
		_leftTitlesArray = @[@[@"车价:",@"购置税:",@"保险:",@"月供:",@"贷款服务费:",@"期数:",@"留购价:"],@[@"车价让利:",@"赠送保养、精品:",@"投资回报:",@"抗通货膨胀:",@"抵稅:"]];
	}
	return _leftTitlesArray;
}

@end
