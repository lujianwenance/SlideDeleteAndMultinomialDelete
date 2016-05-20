//
//  ViewController.m
//  test
//
//  Created by l on 16/3/14.
//  Copyright © 2016年 l. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *deleteIndexArray;
@property (nonatomic, assign) UITableViewCellEditingStyle editingStyle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem =  self.editButtonItem;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickedSaveButton:)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.editingStyle = UITableViewCellEditingStyleDelete;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.dateArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        [self.dateArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {

    if (self.tableView.editing) {
        
        self.editingStyle = UITableViewCellEditingStyleDelete;
        [self.tableView setEditing:NO animated:YES];
    } else {
        
        self.editingStyle = UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
        [self.tableView setEditing:YES animated:YES];
    }
}

- (NSMutableArray *)deleteIndexArray {

    if (!_deleteIndexArray) {
        _deleteIndexArray = [NSMutableArray array];
    }
    
    return _deleteIndexArray;
}

- (void)clickedSaveButton:(UIBarButtonItem *)item {

    if (!self.tableView.editing) {
        return;
    }
    
    NSMutableArray *deleteArray = [NSMutableArray array];
    for (NSIndexPath *index in self.deleteIndexArray) {
        [deleteArray addObject:self.dateArray[index.row]];
    }
    
    [self.dateArray removeObjectsInArray:deleteArray];
    [self.tableView deleteRowsAtIndexPaths:self.deleteIndexArray withRowAnimation:UITableViewRowAnimationFade];
    [self.deleteIndexArray removeAllObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   NSString *CellIdentifier = @"CellIdentifier";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dateArray[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.editingStyle;
}

//IOS8之前
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    return @"删除a";
}

//IOS8及之后
//自定义删除
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [self.dateArray removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }];
//    
////    action.backgroundColor = [UIColor yellowColor];
//    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    action.backgroundEffect = blurEffect;
//    //如果要实现类似于QQ和微信的侧滑出现多个按钮，就在此处添加多个UITableViewRowAction就可以了
//    
//    return @[action];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.dateArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.deleteIndexArray addObject:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.deleteIndexArray removeObject:indexPath];
}

@end
