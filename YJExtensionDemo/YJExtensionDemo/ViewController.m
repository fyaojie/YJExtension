//
//  ViewController.m
//  YJExtensionDemo
//
//  Created by o dream boy on 2018/3/26.
//  Copyright © 2018年 child. All rights reserved.
//

#import "ViewController.h"
#import "DataViewController.h"
#import "YJExtension.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (NSArray *)dataSource {
    return @[@"NSData"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",[NSDate yj_dateWithTimestamp:1527747855]);
    
    NSLog(@"%@",[UIDevice yj_description]);
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DataViewController *dataVC = [[DataViewController alloc] initWithNibName:@"DataViewController" bundle:nil];
    [self.navigationController pushViewController:dataVC animated:YES];
}

@end
