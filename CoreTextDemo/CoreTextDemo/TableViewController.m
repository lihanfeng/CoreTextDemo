//
//  TableViewController.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/18.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "TableViewController.h"
#import "CircleTextController.h"
#import "MixTextController.h"
#import "AroundTextController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CoreText";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"CoreText圆形排版";
    } else if (indexPath.row == 1 ) {
        cell.textLabel.text = @"CoreText图文混排";
    } else if (indexPath.row == 2 ) {
        cell.textLabel.text = @"CoreText图文环绕";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        CircleTextController *vc = [CircleTextController new];
        vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        MixTextController *vc = [[MixTextController alloc] initWithNibName:@"MixTextController" bundle:nil];
        vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        AroundTextController *vc = [[AroundTextController alloc] initWithNibName:@"AroundTextController" bundle:nil];
        vc.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
