//
//  MainController.m
//  JSPatchExc
//
//  Created by zhangpoor on 16/1/15.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "MainController.h"
#import "JSPHManager.h"
#import "WebController.h"


/**
 *  业务操作回调函数
 *
 *  @param isSucessed 操作是否成功
 *  @param oParam     操作的输出参数
 *  @param eMsg       操作错误信息    （当操作成功时为nil）
 */
typedef void (^BusinessOperationCallback)(BOOL isSucessed,id outParam,NSString *eMsg);


typedef void (^ABlock)(id param);

@interface MainController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tb;
    NSArray *_dataSource;


}

@property(nonatomic,copy)NSString *url;

@end



@implementation MainController

- (NSString *)changeStr:(NSString *)str
{
    

    return [str stringByAppendingString:_dataSource[11]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"size:%@",NSStringFromCGSize(kScreenSize));
    
    [self initParam];
    [self initUI];
}

#pragma mark - <init>
- (void)initParam
{
    _dataSource = @[@"0",@"1",@"2",@"3",@"4"];
    self.url = @"http://www.baidu.com";//@"http://www.qq.com";//
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"主 页";
    CGRect _rect        = self.view.bounds;
    _rect.origin.y      = 150;
    _rect.size.height   -= _rect.origin.y;
    
    _tb = [[UITableView alloc]initWithFrame:_rect style:UITableViewStylePlain];
    _tb.delegate    = self;
    _tb.dataSource  = self;
    //_tb.backgroundColor = [UIColor greenColor];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tb.tableHeaderView = [[UIView alloc]init];
    
    [self.view addSubview:_tb];


    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor greenColor];
    _btn.frame = CGRectMake(10, 80, 150 , 40);
    [_btn setTitle:@"加载jsph方案01" forState:UIControlStateNormal];
    _btn.tag = 0;
    [_btn addTarget:self
             action:@selector(btnAction:)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    
    UIButton *_btn01 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn01.backgroundColor = [UIColor greenColor];
    _btn01.frame = CGRectMake(200, 80, 150 , 40);
    [_btn01 setTitle:@"SomeAction" forState:UIControlStateNormal];

    [_btn01 addTarget:self
             action:@selector(someAction)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn01];
    

}

#pragma mark - <action>
- (void)btnAction:(UIButton *)sender
{
    /*
    if (sender.tag == 0)
    {
        [[JSPHManager sharedInstance] loadJS:
         [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"]];
        [sender setTitle:@"已加载jsph方案01" forState:UIControlStateNormal];
    }
    else
    {
        [[JSPHManager sharedInstance] loadJS:
         [[NSBundle mainBundle] pathForResource:@"demo001" ofType:@"js"]];
        [sender setTitle:@"已加载jsph方案02" forState:UIControlStateNormal];
    }
    
    sender.tag = 1 - sender.tag;
     */
    
    [[JSPHManager sharedInstance] loadJS:
     [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"]];
    [sender setTitle:@"已加载jsph方案01" forState:UIControlStateNormal];
}

- (void)someAction
{
    //NSLog(@"%@",[MainController changeStr:@"abc"]);
    
    
}



- (void)cell000Action:(NSString *)str
{
    self.url = str;
    NSLog(@"url:%@",self.url);
}

- (void)cell001Action:(NSString *)str
{
    UIAlertController *_alter =
    [UIAlertController alertControllerWithTitle:@"Navtive Title"
                                        message:str
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:@"取消"
                             style:UIAlertActionStyleCancel
                           handler:
     ^(UIAlertAction * _Nonnull action) {
         NSLog(@"alter_cancelAction:%@",str);
     }];
    
    [_alter addAction:cancelAction];
    
    
    [self presentViewController:_alter
                       animated:YES
                     completion:
     ^{
         NSLog(@"alter_presentViewController:%@",str);
     }];
}

- (void)cell002Action:(NSString *)str
{
    NSLog(@"cell002Action_%@",str);
    
    WebController *_webVC = [WebController createWebVC:self.url];
    
    [self.navigationController pushViewController:_webVC animated:YES];
}
- (void)cell003Action:(NSString *)str
{
    NSLog(@"cell003Action_%@",str);

}

- (void)callBlock:(ABlock)block
{
    if (block) {
        block(@"abc");
    }
    NSLog(@"callBlock");

}

#pragma mark - <tableview delegate>
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ViewController_cell001";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:str];
        
    }
    
    _cell.textLabel.text = _dataSource[indexPath.row];
    
    if (indexPath.row % 2 == 0) {
        _cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    else
    {
        _cell.contentView.backgroundColor = [UIColor brownColor];
    }
    
    return _cell;
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[self changeStr:@"aaaa"];
    
    switch (indexPath.row) {
        case 0:
        {
            [self cell000Action:@"cell000Action"];
        }
            break;
        case 1:
        {
            [self cell001Action:@"cell001Action"];
        }
            break;
        case 2:
        {
            [self cell002Action:@"cell002Action"];
        }
            break;
        case 3:
        {
            [self performSelector:@selector(cell003Action:) withObject:@"cell003Action"];
        }
            break;
        case 4:
        {
            [self performSelector:@selector(cell004Action:) withObject:@"cell004Action"];
        }
            break;
        default:
            break;
    }
    
    
    
}

@end
