//
//  ZHViewController.m
//  ZHTableViewGroup
//
//  Created by 15038777234 on 03/18/2017.
//  Copyright (c) 2017 15038777234. All rights reserved.
//

#import "ZHViewController.h"
#import <ZHTableViewGroup/ZHTableViewDataSource.h>
#import "ZHCellOneTableViewCell.h"
#import "ZHCellTwoTableViewCell.h"
#import "ZHOtherTableViewCell.h"
#import "ListCellViewController.h"

@interface ZHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ZHTableViewDataSource *dataSource;
@property (nonatomic, strong) NSArray<NSString *> *list;

@end

@implementation ZHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	// Do any additional setup after loading the view, typically from a nib.
    self.dataSource = [[ZHTableViewDataSource alloc] initWithTableView:self.tableView];

}

- (void)reloadCells {
    [self.dataSource clearData];
    __weak typeof(self) weakSelf = self;
    [self.dataSource addGroupWithCompletionHandle:^(ZHTableViewGroup *group) {
        __strong typeof(weakSelf) self = weakSelf;
        if ([self.list containsObject:@"Your Image"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOneCellWithCell:cell];
            }];
        }
        if ([self.list containsObject:@"Your Background"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerTwoCellWithCell:cell];
            }];
        }
        if ([self.list containsObject:@"E-mail"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOtherCell:cell title:@"E-mail" detailTitle:@"25867347@qq.com" accessoryType:UITableViewCellAccessoryNone];
            }];
        }
        if ([self.list containsObject:@"Name"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOtherCell:cell title:@"Name" detailTitle:@"Tina" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }];
        }
        if ([self.list containsObject:@"Gender"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOtherCell:cell title:@"Gender" detailTitle:@"Female" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }];
        }
        if ([self.list containsObject:@"Interest List"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOtherCell:cell title:@"Interest List" detailTitle:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }];
        }
        if ([self.list containsObject:@"Blank Cell"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerBlankCell:cell];
            }];
        }
        if ([self.list containsObject:@"Shipping Address Book"]) {
            [group addCellWithCompletionHandle:^(ZHTableViewCell *cell) {
                [self registerOtherCell:cell title:@"Shipping Address Book" detailTitle:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }];
        }

    }];
    [self.dataSource reloadTableViewData];
}

- (void)registerOneCellWithCell:(ZHTableViewCell *)cell {
    [self setCell:cell cellNumber:1 anyClass:[ZHCellOneTableViewCell class] height:76 identifier:@"ZHCellOneTableViewCellIdentifier"];
    [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.textLabel.text = @"Your Image";
    }];
}

- (void)registerTwoCellWithCell:(ZHTableViewCell *)cell {
    [self setCell:cell cellNumber:1 anyClass:[ZHCellTwoTableViewCell class] height:61 identifier:@"ZHCellTwoTableViewCellIdentifier"];
    [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.textLabel.text = @"Your Background";
    }];

}

- (void)registerOtherCell:(ZHTableViewCell *)cell title:(NSString *)title detailTitle:(NSString *)detailTitle accessoryType:(UITableViewCellAccessoryType)accessoryType {
    [self setCell:cell cellNumber:1 anyClass:[ZHOtherTableViewCell class] height:44 identifier:@"ZHOtherTableViewCellIdentifier"];
    [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.textLabel.text = title;
        cell.detailTextLabel.text = detailTitle;
        cell.accessoryType = accessoryType;
    }];

}

- (void)registerBlankCell:(ZHTableViewCell *)cell {
    [self setCell:cell cellNumber:1 anyClass:[UITableViewCell class] height:10 identifier:@"UITableViewCellBlankIdentifier"];
    [cell setConfigCompletionHandle:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.backgroundColor = [UIColor clearColor];
    }];
}

- (void)setCell:(ZHTableViewCell *)cell cellNumber:(NSInteger)cellNumber anyClass:(Class)anyClass height:(CGFloat)height identifier:(NSString *)identifier {
    cell.cellNumber = cellNumber;
    cell.anyClass = anyClass;
    cell.height = height;
    cell.identifier = identifier;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource heightForRowAtDataSource:self.dataSource indexPath:indexPath customHeightCompletionHandle:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [ZHTableViewDataSource heightForHeaderInSectionWithDataSource:self.dataSource section:section customHeightCompletionHandle:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [ZHTableViewDataSource heightForFooterInSectionWithDataSource:self.dataSource section:section customHeightCompletionHandle:nil];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForHeaderInSectionWithDataSource:self.dataSource section:section];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [ZHTableViewDataSource viewForFooterInSectionWithDataSource:self.dataSource section:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHTableViewDataSource numberOfRowsInSectionWithDataSource:self.dataSource section:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHTableViewDataSource cellForRowAtWithDataSource:self.dataSource indexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZHTableViewDataSource numberOfSectionsWithDataSource:self.dataSource];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        return ;
    }
    UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
    if (nav.viewControllers.count <= 0) {
        return;
    }
    if (![nav.viewControllers.firstObject isKindOfClass:[ListCellViewController class]]) {
        return;
    }
    ListCellViewController *controller = nav.viewControllers.firstObject;
    controller.selectTitles = [NSMutableArray arrayWithArray:self.list];
    [controller setSaveCompletionHandle:^(NSArray *list) {
        self.list = list;
        [self reloadCells];
    }];
}

@end
