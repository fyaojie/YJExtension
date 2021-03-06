//
//  ViewController.m
//  YJExtensionDemo
//
//  Created by o dream boy on 2018/3/26.
//  Copyright © 2018年 child. All rights reserved.
//

#import "ViewController.h"
#import "DataViewController.h"
#import <YJExtension.h>
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

//- (void)loadView {
//    [super loadView];
//    NSLog(@"%f", self.yj_safeAreaInsets.bottom);
//    NSLog(@"%f", self.yj_safeAreaInsets.top);
//}

- (NSArray *)dataSource {
    return @[@"NSData"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[NSDate yj_dateWithTimestamp:1527747855]);
    
    NSLog(@"%@",[UIDevice yj_description]);
    NSLog(@"%@", [@"abc=888" yj_URLQuery]);
    NSLog(@"%@", [@"abc=888" yj_URLParse]);

    NSLog(@"%f", self.yj_safeAreaInsets.bottom);
    NSLog(@"%f", self.yj_safeAreaInsets.top);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//    self.tableView.hidden = YES;
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    bgView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:bgView];
////    [self.view setNeedsLayout];
//    bgView.cms_separatorColor = [UIColor redColor];
//    bgView.showBottomSeparator = YES;
//    bgView.bottomSeparatorInsets = UIEdgeInsetsMake(0, 2, 0, 2);
//}

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
