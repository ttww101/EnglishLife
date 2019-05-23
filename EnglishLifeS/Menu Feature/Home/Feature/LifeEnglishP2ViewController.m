//
//  EnglishP2ViewController.m
//  iHealthS
//
//  Created by Apple on 2019/3/21.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "LifeEnglishP2ViewController.h"
#import "EnglishData.h"
#import "EnglishLifeCellContorllerTableViewCell.h"

@interface LifeEnglishP2ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mtableView;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage1;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage2;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage3;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage4;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage5;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage6;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage7;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage8;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage9;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqpage10;
@property (weak, nonatomic) IBOutlet UILabel *gheikcmaeoxqP2title;



@property NSString *jsonString;

//宣告一個存放連絡人的陣列變數，_contacts
@property NSMutableArray * gheikcmaeoxqcontactsL;
@property NSMutableArray * gheikcmaeoxqcontactsR;
@property NSMutableArray * gheikcmaeoxqanswerL;
@property NSMutableArray * gheikcmaeoxqanswerL_sw;
@property NSMutableArray * gheikcmaeoxqanswerR;
@property NSMutableArray * gheikcmaeoxqanswerR_sw;
@end

EnglishLifeCellContorllerTableViewCell *cell;

@implementation LifeEnglishP2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _url = @"http://47.75.131.189/a4dcb6f3661942c3f3d6090cf5320934/";
    
    self.gheikcmaeoxqP2title.text = _labTitle;
    
    NSLog(@" URL : %@", _url);
    NSLog(@" SORT : %@", _sort);
    
    _gheikcmaeoxqcontactsL = [[NSMutableArray alloc] init];
    _gheikcmaeoxqcontactsR = [[NSMutableArray alloc] init];
    _gheikcmaeoxqanswerL = [[NSMutableArray alloc] init];
    _gheikcmaeoxqanswerR = [[NSMutableArray alloc] init];
    _gheikcmaeoxqanswerL_sw = [[NSMutableArray alloc] init];
    _gheikcmaeoxqanswerR_sw = [[NSMutableArray alloc] init];
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:_url];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = [NSString stringWithFormat:@"sort=%@", _sort] ;//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    _jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    EnglishData *EnData = [[EnglishData alloc] initWithString:_jsonString error:nil];
    
    for(int i = 0 ; i < EnData.data.count; i += 1){
        DATA *data = EnData.data[i];
        if( i % 2){
            [_gheikcmaeoxqcontactsL addObject:data.chinese];
            [_gheikcmaeoxqanswerL addObject:data.english];
            [_gheikcmaeoxqanswerL_sw addObject:@""];
        } else {
            [_gheikcmaeoxqcontactsR addObject:data.chinese];
            [_gheikcmaeoxqanswerR addObject:data.english];
            [_gheikcmaeoxqanswerR_sw addObject:@""];
        }
    }
    
  
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    [self.mtableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    self.gheikcmaeoxqpage1.tag = 1;
    self.gheikcmaeoxqpage2.tag = 2;
    self.gheikcmaeoxqpage3.tag = 3;
    self.gheikcmaeoxqpage4.tag = 4;
    self.gheikcmaeoxqpage5.tag = 5;
    self.gheikcmaeoxqpage6.tag = 6;
    self.gheikcmaeoxqpage7.tag = 7;
    self.gheikcmaeoxqpage8.tag = 8;
    self.gheikcmaeoxqpage9.tag = 9;
    self.gheikcmaeoxqpage10.tag = 10;
    
    [self.gheikcmaeoxqpage1 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage2 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage3 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage4 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage5 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage6 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage7 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage8 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage9 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqpage10 addTarget:self action:@selector(onClickPageButton:)forControlEvents:UIControlEventTouchDown];

    [self.view addSubview:self.mtableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"reuse";
    //自訂Cell的類別
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        //載入CustomCell.xib檔
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"reuse" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[EnglishLifeCellContorllerTableViewCell class]]){
                cell = (EnglishLifeCellContorllerTableViewCell *)view;
            }
        }
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell.gheikcmaeoxqLbtan setTitle:[_gheikcmaeoxqcontactsL objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.gheikcmaeoxqRbtn setTitle:[_gheikcmaeoxqcontactsR objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [cell.gheikcmaeoxqLt setText:[_gheikcmaeoxqanswerL_sw objectAtIndex:indexPath.row]];
    [cell.gheikcmaeoxqRt setText:[_gheikcmaeoxqanswerR_sw objectAtIndex:indexPath.row]];
    
    [cell.gheikcmaeoxqLbtan addTarget:self action:@selector(onClickedL:) forControlEvents:UIControlEventTouchUpInside];
    cell.gheikcmaeoxqLbtan .tag = indexPath.row;
    [cell.gheikcmaeoxqRbtn addTarget:self action:@selector(onClickedR:) forControlEvents:UIControlEventTouchUpInside];
    cell.gheikcmaeoxqRbtn .tag = indexPath.row;

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_gheikcmaeoxqcontactsL count];
}



- (void)onClickedL:(UIButton *)sender{
    
    
    for(int i =0 ; i < 10 ; i++)
    {
        if( i == sender.tag)
        {
            if([_gheikcmaeoxqanswerL_sw[i] isEqualToString:@""]){
                _gheikcmaeoxqanswerL_sw[i] = _gheikcmaeoxqanswerL[i];
            } else {
                _gheikcmaeoxqanswerL_sw[i] = @"";
            }
            [_mtableView reloadData];
        }
    }
}

- (void)onClickedR:(UIButton *)sender{
    
    for(int i =0 ; i < 10 ; i++)
    {
        if( i == sender.tag)
        {
            if([_gheikcmaeoxqanswerR_sw[i] isEqualToString:@""]){
                _gheikcmaeoxqanswerR_sw[i] = _gheikcmaeoxqanswerR[i];
            } else {
                _gheikcmaeoxqanswerR_sw[i] = @"";
            }
            [_mtableView reloadData];
        }
    }
}

- (IBAction)onClickPageButton:(UIButton*)sender {
    
    for(int i =0; i< 11 ; i++){
        if(i == sender.tag){
            
            _gheikcmaeoxqcontactsL = [[NSMutableArray alloc] init];
            _gheikcmaeoxqcontactsR = [[NSMutableArray alloc] init];
            _gheikcmaeoxqanswerL = [[NSMutableArray alloc] init];
            _gheikcmaeoxqanswerR = [[NSMutableArray alloc] init];
            _gheikcmaeoxqanswerL_sw = [[NSMutableArray alloc] init];
            _gheikcmaeoxqanswerR_sw = [[NSMutableArray alloc] init];
            
            //第一步，创建URL
            NSURL *url = [NSURL URLWithString:_url];
            NSString * page = [[NSString alloc] initWithFormat:@"%ld", (long)sender.tag];
            NSDictionary *jsonBodyDict = @{@"sort":_sort, @"page":page};
            
            //第二步，创建请求
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //设置请求方式为POST，默认为GET
            [request setHTTPMethod:@"POST"];
            //设置参数
            NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
            [request setHTTPBody:jsonBodyData];
            //第三步，连接服务器
            NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            _jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
            EnglishData *EnData = [[EnglishData alloc] initWithString:_jsonString error:nil];
            
            for(int i = 0 ; i < EnData.data.count; i += 1){
                DATA *data = EnData.data[i];
                if( i % 2){
                    [_gheikcmaeoxqcontactsL addObject:data.chinese];
                    [_gheikcmaeoxqanswerL addObject:data.english];
                    [_gheikcmaeoxqanswerL_sw addObject:@""];
                } else {
                    [_gheikcmaeoxqcontactsR addObject:data.chinese];
                    [_gheikcmaeoxqanswerR addObject:data.english];
                    [_gheikcmaeoxqanswerR_sw addObject:@""];
                }
            }
            
             [_mtableView reloadData];
        }
    }
}

@end
