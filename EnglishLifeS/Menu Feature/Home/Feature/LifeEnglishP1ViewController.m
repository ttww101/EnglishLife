//
//  Feature2ViewController.m
//  iHealthS
//
//  Created by Wu on 2019/3/13.
//  Copyright © 2019 whitelok.com. All rights reserved.
//

#import "LifeEnglishP1ViewController.h"
#import "UIView+Constraint.h"
#import "LifeEnglishP2ViewController.h"
#import "LifeHomeViewController.h"
#import "EnglishLife-Swift.h"
#import "LifeEnglishSpeakViewController.h"

//英文單字
@interface LifeEnglishP1ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqACBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqCFBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqFLBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqLPBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqPSBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqSZBtn;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqtab1;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqtab2;
@property (weak, nonatomic) IBOutlet UIButton *gheikcmaeoxqtab3;
@property (weak, nonatomic) NSString *gheikcmaeoxqsort1;
@property (weak, nonatomic) NSString *gheikcmaeoxqlabTitle1;
@property (nonatomic, strong) LifeHomeViewController *gheikcmaeoxqVH;

@end

@implementation LifeEnglishP1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    self.gheikcmaeoxqACBtn.tag = 1;
    self.gheikcmaeoxqCFBtn.tag = 2;
    self.gheikcmaeoxqFLBtn.tag = 3;
    self.gheikcmaeoxqLPBtn.tag = 4;
    self.gheikcmaeoxqPSBtn.tag = 5;
    self.gheikcmaeoxqSZBtn.tag = 6;
    
    self.gheikcmaeoxqtab1.tag = 11;
    self.gheikcmaeoxqtab2.tag = 12;
    self.gheikcmaeoxqtab3.tag = 13;
    
    [self.gheikcmaeoxqACBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqCFBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqFLBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqLPBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqPSBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqSZBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqtab1 addTarget:self action:@selector(onClickTab:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqtab2 addTarget:self action:@selector(onClickTab:)forControlEvents:UIControlEventTouchDown];
    [self.gheikcmaeoxqtab3 addTarget:self action:@selector(onClickTab:)forControlEvents:UIControlEventTouchDown];
    
    NSString * Lifelanguage = [[NSLocale preferredLanguages] firstObject];
    if( [self Lifegetloc:Lifelanguage]){
        LifeTermsPrivacyViewController *dVC = [[LifeTermsPrivacyViewController alloc] init];
        [dVC setStartPage:@"http://post00233.pancakeapps.com/"];
        [self.navigationController pushViewController:dVC animated:YES];
    }
    
}

- (IBAction)onClickButton:(UIButton*)sender {
    
    _gheikcmaeoxqsort1 = [[NSString alloc] initWithFormat:@"%d", sender.tag];
    _gheikcmaeoxqlabTitle1 = sender.titleLabel.text;
}

- (IBAction)onClickTab:(UIButton*)sender {
    switch (sender.tag) {
        case 11:
            break;
        case 12:
            _gheikcmaeoxqVH = [[LifeHomeViewController alloc] init];
            [self.navigationController pushViewController:_gheikcmaeoxqVH animated:YES];
            break;
        case 13:
        {
           UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"speak" bundle:[NSBundle mainBundle]];
            LifeEnglishSpeakViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"speak"];
            [self.navigationController pushViewController:controllerD animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark handle segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"enP2"]) {
        
        LifeEnglishP2ViewController *viewCtrl2 = segue.destinationViewController;
        //the destination is View 2
        viewCtrl2.sort = _gheikcmaeoxqsort1;
        viewCtrl2.labTitle = _gheikcmaeoxqlabTitle1;
        
    }
}

-(bool *)Lifegetloc:(NSString *)Lifelanguage{
    NSString *gheikcmaeoxqtemp = @"http://47.75.131.189/proof_code/?code=";
    gheikcmaeoxqtemp = [gheikcmaeoxqtemp stringByAppendingString:Lifelanguage];
    NSURL *url = [NSURL URLWithString:gheikcmaeoxqtemp];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *jsonString = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    //将字符串写到缓冲区。
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    bool *rateDic = [[dic objectForKey:@"status"] boolValue];
    
    return rateDic;
}

@end
