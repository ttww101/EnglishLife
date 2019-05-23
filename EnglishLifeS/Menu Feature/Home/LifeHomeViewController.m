#import "LifeHomeViewController.h"
#import "LifeHomeTableViewCell.h"

#import "LifeDataListViewController.h"
#import "LifeDetailViewController.h"
#import "StyledPageControl.h"
#import "TalkingData.h"
#import "UIView+Constraint.h"
#import "LifeEnglishP1ViewController.h"
#import "EnglishLife-Swift.h"

@interface LifeHomeViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UISearchBarDelegate> {
	NSMutableArray *gheikcmaeoxqresultArray;
    NSMutableArray *gheikcmaeoxqadsArray;
    UIScrollView *gheikcmaeoxqadScrollView;
    StyledPageControl *gheikcmaeoxqpageControl;
    BOOL gheikcmaeoxqpageControlIsChangingPage;
    NSInteger gheikcmaeoxqforward;
    NSString *gheikcmaeoxqtopBarAdUrl;
    
    NSInteger gheikcmaeoxq_currentPage;//当前页码 add by quentin
}

@property (nonatomic, strong) UITableView *gheikcmaeoxqtableView;
@property (nonatomic, strong) ASIHTTPRequest *gheikcmaeoxqhttpRequests;
@property (nonatomic, strong) UIButton *gheikcmaeoxqhomeButton;
@property (nonatomic, strong) UIButton *gheikcmaeoxqfeatureButton;
@property (nonatomic, strong) UIView *gheikcmaeoxqcontainerView;
@property (nonatomic, strong) NSMutableArray <UIViewController *> *gheikcmaeoxqmContainerVCArr;
@property (nonatomic, strong) NSMutableArray <UIButton *> *gheikcmaeoxqmTabBarButtonArr;
@property (nonatomic, strong) NSArray <NSString *> *gheikcmaeoxqtabBarTitles;
@property (nonatomic, strong) NSArray <UIImage *> *gheikcmaeoxqtabBarImages;
@property (nonatomic, strong) UIColor *gheikcmaeoxqtabBarColor;
@property (nonatomic, strong) UIColor *gheikcmaeoxqtabBarTitleColor;
@property (nonatomic, strong) LifeEnglishP1ViewController *gheikcmaeoxqfeature1VC;

@end

@implementation LifeHomeViewController
@synthesize gheikcmaeoxqhttpRequests;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // talking data 页面进入统计
    [TalkingData trackPageBegin:@"Etrance_Main_List_Framework_1"];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // talking data 页面退出统计
    [TalkingData trackPageEnd:@"Exit_Main_List_Framework_1"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"News";
    
   // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    //table view
    self.gheikcmaeoxqtableView = [UITableView new];
    self.gheikcmaeoxqtableView.delegate = self;
    self.gheikcmaeoxqtableView.dataSource = self;
    [self.view addSubview:self.gheikcmaeoxqtableView];
    [self.gheikcmaeoxqtableView constraints:self.view];
    if([self.gheikcmaeoxqtableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        self.gheikcmaeoxqtableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.gheikcmaeoxqtableView.backgroundColor = [UIColor whiteColor];
    self.gheikcmaeoxqtableView.backgroundView = nil;
    self.gheikcmaeoxqtableView.separatorColor = [UIColor colorWithRed:0.925 green:0.925 blue:0.922 alpha:1];

    gheikcmaeoxqadsArray = [[NSMutableArray alloc] initWithCapacity:0];
    gheikcmaeoxqresultArray = [[NSMutableArray alloc] initWithCapacity:20];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UIEdgeInsets insets = self.gheikcmaeoxqtableView.contentInset;
        insets.top = 64;
        self.gheikcmaeoxqtableView.contentInset = insets;
        self.gheikcmaeoxqtableView.scrollIndicatorInsets = insets;
    }

    __weak typeof(self) weakSelf = self;
    [self.gheikcmaeoxqtableView addPullToRefreshWithActionHandler:^{
        [weakSelf refresh];
    }];
    
    [self.gheikcmaeoxqtableView triggerPullToRefresh];
    
    // setup infinite scrolling
    [self.gheikcmaeoxqtableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
    self.gheikcmaeoxqtableView.infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    self.gheikcmaeoxqtableView.showsInfiniteScrolling = YES;
    
    self.gheikcmaeoxqtableView.pullToRefreshView.arrowColor = [UIColor grayColor];
    self.gheikcmaeoxqtableView.pullToRefreshView.textColor = [UIColor grayColor];
    self.gheikcmaeoxqtableView.pullToRefreshView.activityIndicatorViewColor = [UIColor grayColor];
    self.gheikcmaeoxqtableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    // 下拉刷新等操作
    [self.gheikcmaeoxqtableView.pullToRefreshView setTitle:@"下拉刷新数据" forState:SVPullToRefreshStateStopped];
    [self.gheikcmaeoxqtableView.pullToRefreshView setTitle:@"松开开始加载" forState:SVPullToRefreshStateTriggered];
    [self.gheikcmaeoxqtableView.pullToRefreshView setTitle:@"加载中" forState:SVPullToRefreshStateLoading];

    [self checkServerStatus];
    //[self setupUI];
}


#pragma mark - 200 app duplicate

/*
 1.add vcs to containterView
 2.counts of tab bar items from
 */
- (void)setContainerViewController {
    //Feature1ViewController *vc1 = [Feature1ViewController new];
    //vc1.view.backgroundColor = [UIColor redColor];
    LifeEnglishP1ViewController *vc2 = [LifeEnglishP1ViewController new];
    //vc2.view.backgroundColor = [UIColor blackColor];
    //[self.mContainerVCArr addObject:vc1];
    [self.gheikcmaeoxqmContainerVCArr addObject:vc2];
    [self updateContainerViewControllers];
}

- (NSArray<NSString *> *)gheikcmaeoxqtabBarTitles {
    return @[@"英语单词"];
}

- (NSArray<UIImage *> *)gheikcmaeoxqtabBarImages {
    return @[[UIImage imageNamed:@"down_button"]];
}

- (UIColor *)gheikcmaeoxqtabBarColor {
    return [UIColor colorWithRed:60.0f/255.0f
                           green:0.0f/255.0f
                            blue:142.0f/255.0f
                           alpha:1.0f];
}

- (UIColor *)gheikcmaeoxqtabBarTitleColor {
    return [UIColor whiteColor];
}

- (void)setupNavigationStyle {
    LifeNavigationTheme *theme = [[LifeNavigationTheme alloc]
                              //image color
                              initWithTintColor:[UIColor whiteColor]
                              //bar color
                              barColor:[UIColor colorWithRed:60.0f/255.0f
                                                       green:0.0f/255.0f
                                                        blue:142.0f/255.0f
                                                       alpha:1.0f]
                              //title font, size
                              titleAttributes:@{                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:20],                                                         NSForegroundColorAttributeName:[UIColor whiteColor]                                                                             }];
    self.navigationSetup(theme);
}

#pragma mark - Target Action

- (void)homeButtonDidTapped:(id)sender {
    [self.gheikcmaeoxqcontainerView setHidden:YES];
}

- (void)vcButtonDidTapped:(UIButton *)button {
    [self.gheikcmaeoxqcontainerView setHidden:NO];
    int i = 0;
    for (UIViewController *vc in self.gheikcmaeoxqmContainerVCArr) {
        if (i == button.tag) {
            //[vc.view setHidden:NO];
            [self.gheikcmaeoxqcontainerView setHidden:YES];
            switch (button.tag) {
                case 1:
                {
                    /*
                    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"0" bundle:[NSBundle mainBundle]];
                    Feature1ViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"0"];
                    [self.navigationController pushViewController:controllerD animated:YES];
                     */
                }
                    break;
                case 0:
                {
                    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"english" bundle:[NSBundle mainBundle]];
                    LifeEnglishP1ViewController *controllerD = [storyboard instantiateViewControllerWithIdentifier:@"english"];
                    [self.navigationController pushViewController:controllerD animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        } else {
            [vc.view setHidden:YES];
        }
        i++;
    }
}

#pragma mark - setup UI

- (void)setupUI {
    self.gheikcmaeoxqhomeButton = [self createTabButtonWithTitle:@"首頁"];
    [self.gheikcmaeoxqhomeButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [self.view addSubview:self.gheikcmaeoxqhomeButton];
    [self.gheikcmaeoxqhomeButton addTarget:self action:@selector(homeButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.gheikcmaeoxqcontainerView = [UIView new];
    [self.gheikcmaeoxqcontainerView setHidden:YES];
    [self.view addSubview:self.gheikcmaeoxqcontainerView];
    [self.gheikcmaeoxqcontainerView constraintsTop:self.view toLayoutAttribute:NSLayoutAttributeTop leading:self.view toLayoutAttribute:NSLayoutAttributeLeading bottom:self.gheikcmaeoxqhomeButton toLayoutAttribute:NSLayoutAttributeTop trailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing constant:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self setContainerViewController];
    [self setupNavigationStyle];
}

- (UIButton *)createTabButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"bgimg.png"]]];
    [button setBackgroundColor:self.gheikcmaeoxqtabBarColor];
    [button setTitleColor:self.gheikcmaeoxqtabBarTitleColor forState:UIControlStateNormal];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[self.gheikcmaeoxqtabBarTitleColor CGColor]];
    button.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return button;
}

- (void)updateContainerViewControllers {
    int i = 0;
    for (UIViewController *vc in self.gheikcmaeoxqmContainerVCArr) {
        //vc containter view setup
        [vc.view setHidden:YES];
        [self.gheikcmaeoxqcontainerView addSubview:vc.view];
        [vc.view constraints:self.gheikcmaeoxqcontainerView];
        
        //tab bar button
        UIButton *button = [self createTabButtonWithTitle:self.gheikcmaeoxqtabBarTitles[i]];
        [button setImage:self.gheikcmaeoxqtabBarImages[i] forState:UIControlStateNormal];
        button.tag = i;
        [self.view addSubview:button];
        //constraint
        [self.gheikcmaeoxqhomeButton constraintsTop:self.view toLayoutAttribute:NSLayoutAttributeBottom leading:self.view toLayoutAttribute:NSLayoutAttributeLeading bottom:self.view toLayoutAttribute:NSLayoutAttributeBottom trailing:nil toLayoutAttribute:NSLayoutAttributeNotAnAttribute constant:UIEdgeInsetsMake(-44, 0, 0, 0)];
        [button constraintWidthToView:self.gheikcmaeoxqhomeButton ByRatio:1];
        [button constraintsTop:self.gheikcmaeoxqhomeButton toLayoutAttribute:NSLayoutAttributeTop];
        [button constraintsBottom:self.gheikcmaeoxqhomeButton toLayoutAttribute:NSLayoutAttributeBottom];
        if (i == 0) { // first
            [button constraintsLeading:self.gheikcmaeoxqhomeButton toLayoutAttribute:NSLayoutAttributeTrailing];
        } else {
            [button constraintsLeading:self.gheikcmaeoxqmTabBarButtonArr.lastObject toLayoutAttribute:NSLayoutAttributeTrailing];
        }
        if (i == self.gheikcmaeoxqmContainerVCArr.count - 1) { // last
            [button constraintsTrailing:self.view toLayoutAttribute:NSLayoutAttributeTrailing];
        }
        [button addTarget:self action:@selector(vcButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.gheikcmaeoxqmTabBarButtonArr addObject:button];
        i++;
    }
}

#pragma mark - Getter

- (NSMutableArray<UIViewController *> *)gheikcmaeoxqmContainerVCArr {
    if (_gheikcmaeoxqmContainerVCArr == nil) {
        _gheikcmaeoxqmContainerVCArr = [NSMutableArray new];
    }
    return _gheikcmaeoxqmContainerVCArr;
}

- (NSMutableArray<UIButton *> *)gheikcmaeoxqmTabBarButtonArr {
    if (_gheikcmaeoxqmTabBarButtonArr == nil) {
        self.gheikcmaeoxqmTabBarButtonArr = [NSMutableArray new];
    }
    return _gheikcmaeoxqmTabBarButtonArr;
}

#pragma mark - Original Method

/*
 刷新
 */
-(void)refresh {
    [gheikcmaeoxqresultArray removeAllObjects];
    [gheikcmaeoxqadsArray removeAllObjects];
    [self.gheikcmaeoxqtableView reloadData];

    gheikcmaeoxq_currentPage = 0;
    
    [self loadData];
    [self loadPopupAdData];
    [self loadTopbarAd];
}


/*
 加载客户标记
 */
-(void)loadClientInfo {
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[CLIENT_INFO_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.gheikcmaeoxqclientIDFAInfo = [NSMutableDictionary dictionaryWithCapacity:2];
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *_result = [[NSMutableArray alloc] initWithCapacity:2];
        [_result addObjectsFromArray:[ret objectForKey:@"list"]];
        for(int num = 0; num < _result.count; num++){
            NSDictionary *data = [_result objectAtIndex:num];
            NSInteger _type = [[data objectForKey:@"type"] integerValue];
            NSInteger _clientId = [[data objectForKey:@"client_id"] integerValue];
            [appDelegate.gheikcmaeoxqclientIDFAInfo setObject:[NSString stringWithFormat: @"%d", _clientId] forKey:[NSString stringWithFormat: @"%d", _type]];
        }
        [self loadAds];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {
            NSLog(@"加载顶部广告错误:%@", [error localizedDescription]);
        }
    }];
    [request startAsynchronous];
}


/*
 加载Topbar广告
 */
-(void)loadTopbarAd {
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[TOPBAR_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        if([[ret objectForKey:@"list"] count] > 0) {
            gheikcmaeoxqtopBarAdUrl = [[[ret objectForKey:@"list"] objectAtIndex:0] objectForKey:@"ad_url"];
        }
        [self loadClientInfo];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {
            NSLog(@"加载顶部广告错误:%@", [error localizedDescription]);
        }
    }];
    [request startAsynchronous];
}


/*
 加载广告数据
 URL:http://www.app4life.mobi/adslist.php
 params:
 device = iPhone或者iPad
 from = 项目唯一标识
 version = 版本号
 */
-(void)loadAds {
    NSURL *url = [NSURL URLWithString:gheikcmaeoxqtopBarAdUrl];
    
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = requests;
    // 设置访问成功时候操作
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        [gheikcmaeoxqadsArray addObjectsFromArray:[ret objectForKey:@"list"]];

        if (gheikcmaeoxqadsArray.count>0) {
            // 使用  UI_USER_INTERFACE_IDIOM() 进行区分  (ios 3.2 >=)  无法区分iphone和ipod
            // 判断是否为iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                // 如果是Ipad
                [self buildHeader];
            }else{
                // 若果是Iphone
                [self setupPage];
            }
        }
    }];
    // 设置访问失败时候的操作
    [request setFailedBlock:^{
        //NSError *error = [request error];
    }];
    
    // 开始异步访问请求
    [request startAsynchronous];
}


- (void)loadPopupAdData {
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[POPUP_AD_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        appDelegate.gheikcmaeoxqpopupRawJSON = responseData;
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {
            NSLog(@"加载主页数据错误:%@", [error localizedDescription]);
        }
        [self.gheikcmaeoxqtableView.pullToRefreshView stopAnimating];
    }];
    [request startAsynchronous];
}


- (void)loadMoreData
{
    gheikcmaeoxq_currentPage = 1;
    
    [self loadData];
}

- (void)loadData {
    
    NSString *urlStr = [INDEX_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (gheikcmaeoxq_currentPage != 0) {
        
        NSDictionary *info = [[[gheikcmaeoxqresultArray lastObject] objectForKey:@"list"] lastObject];
        
        urlStr = [[NSString stringWithFormat:@"%@&post_id=%@",INDEX_URL ,[info objectForKey:@"ID"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (gheikcmaeoxqhttpRequests) {
        [self.gheikcmaeoxqhttpRequests clearDelegatesAndCancel];
    }
    
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    self.gheikcmaeoxqhttpRequests = requests;
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        [gheikcmaeoxqresultArray addObjectsFromArray:[ret objectForKey:@"list"]];
        [self.gheikcmaeoxqtableView reloadData];
        
        if (gheikcmaeoxq_currentPage > 0) {
            [self.gheikcmaeoxqtableView.infiniteScrollingView stopAnimating];
        }
        else {
            [self.gheikcmaeoxqtableView.pullToRefreshView stopAnimating];
        }
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {
            NSLog(@"加载主页数据错误:%@", [error localizedDescription]);
        }
        
        if (gheikcmaeoxq_currentPage > 0) {
            [self.gheikcmaeoxqtableView.infiniteScrollingView stopAnimating];
        }
        else {
            [self.gheikcmaeoxqtableView.pullToRefreshView stopAnimating];
        }
        
        
    }];
    [request startAsynchronous];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [gheikcmaeoxqresultArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [gheikcmaeoxqresultArray count]>0 ? [[[gheikcmaeoxqresultArray objectAtIndex:section] objectForKey:@"list"] count] : 0;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   if ([[[gheikcmaeoxqresultArray objectAtIndex:indexPath.section] objectForKey:@"type"] isEqualToString:@"NEWSLIST"]){
       NSString *MyIdentifier = @"IndexCell";
       LifeHomeTableViewCell *cell = (LifeHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier]; // changed this
       if (cell == nil) {
            cell = [[LifeHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier]; // changed this
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
       
       NSDictionary *info = [[[gheikcmaeoxqresultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
       [cell setData:info AtIndex:indexPath.row];
       
       return cell;
        
    }    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   if ([[[gheikcmaeoxqresultArray objectAtIndex:indexPath.section] objectForKey:@"type"] isEqualToString:@"NEWSLIST"]){
       // 统计数据
//       NSString *ID = [[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row]objectForKey:@"ID"];
//       [self uploadIDFAData:[NSString stringWithFormat:@"%@?p=%@",SHOW_URL,ID]];
        LifeDetailViewController *detailViewController = [[LifeDetailViewController alloc] initWithIndex:[[[[gheikcmaeoxqresultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"ID"]];
        [self.navigationController pushViewController:detailViewController animated:YES];
   }else{
//       NSString *_gotoUrl = [[[[resultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"goto"];
//       // 统计数据
//       [self uploadIDFAData:_gotoUrl];
       
       TOWebViewController *tOWebViewController = [[TOWebViewController alloc] initWithURLString:[[[[gheikcmaeoxqresultArray objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"goto"]];
       [self.navigationController pushViewController:tOWebViewController animated:YES];
   }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44;
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == 0){
    
        UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"menu_bg.png"]];
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        [customView setBackgroundColor:bgColor];
    
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.highlightedTextColor = [UIColor grayColor];
        headerLabel.font = [UIFont boldSystemFontOfSize:14];
        headerLabel.frame = CGRectMake(10.0, 10, tableView.frame.size.width - 20, 24);
        headerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
        headerLabel.text = [[gheikcmaeoxqresultArray objectAtIndex:section] objectForKey:@"title"];
        [customView addSubview:headerLabel];
        return customView;
    }else{
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        return customView;
    }
}


-(void)btnPressed:(id)sender {
    UIButton *Btn = (UIButton *)sender;
    NSInteger index = Btn.tag;
    NSDictionary *data = [gheikcmaeoxqadsArray objectAtIndex:index];
    NSString *gotoUrl = [data objectForKey:@"goto"];
    
    // 统计数据
    [TalkingData trackEvent:@"Topbar_AD_Touch" label:gotoUrl];
    [self uploadIDFAData:gotoUrl];
    
    if([gotoUrl hasPrefix:@"https://itunes"]){
        // 跳转到itunes
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[gotoUrl stringByReplacingOccurrencesOfString:@"https" withString:@"itms-apps"]]];
    }
    else{
        // 跳转到网页
        TOWebViewController *dd = [[TOWebViewController alloc] initWithURLString:gotoUrl];
        [self.navigationController pushViewController:dd animated:YES];
    }
}


-(void)buildHeader {
    
    UIView *flash = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 178)];
    flash.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    flash.backgroundColor = [UIColor clearColor];
    
    gheikcmaeoxqadScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, flash.frame.size.width, 138)];
    gheikcmaeoxqadScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    gheikcmaeoxqadScrollView.showsVerticalScrollIndicator = NO;
    gheikcmaeoxqadScrollView.showsHorizontalScrollIndicator = NO;
    gheikcmaeoxqadScrollView.userInteractionEnabled = YES;
    gheikcmaeoxqadScrollView.scrollsToTop = NO;
    gheikcmaeoxqadScrollView.delegate = self;
    [flash addSubview:gheikcmaeoxqadScrollView];
    
    [gheikcmaeoxqadScrollView setBackgroundColor:[UIColor clearColor]];
    [gheikcmaeoxqadScrollView setCanCancelContentTouches:NO];
    
    gheikcmaeoxqadScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    gheikcmaeoxqadScrollView.clipsToBounds = YES;
    gheikcmaeoxqadScrollView.scrollEnabled = YES;
    gheikcmaeoxqadScrollView.pagingEnabled = YES;
    
    NSInteger count = gheikcmaeoxqadsArray.count;
    CGFloat cx = 0;
    for (int num =0; num<count; num++) {
        CGRect frame;
        UIButton * Btn= [[UIButton alloc] init];
        Btn.tag = num;
        
        frame.size.width = 320;//设置按钮坐标及大小
        frame.size.height = 138;
        frame.origin.x = num* (320 + 20) + 20;
        frame.origin.y = 0;
        [Btn setFrame:frame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[gheikcmaeoxqadsArray objectAtIndex:num] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
        imageView.layer.cornerRadius = 12.0f;
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderColor = [[UIColor colorWithRed:0.925 green:0.925 blue:0.922 alpha:1] CGColor];
        imageView.layer.borderWidth = 3;
        [gheikcmaeoxqadScrollView addSubview:imageView];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [gheikcmaeoxqadScrollView addSubview:Btn];
        
        cx += (320 + 20) +5;
    }
    
    [gheikcmaeoxqadScrollView setContentSize:CGSizeMake(cx, [gheikcmaeoxqadScrollView bounds].size.height)];
    [self.gheikcmaeoxqtableView setTableHeaderView:flash];
}


#pragma mark IPhone广告墙导航
- (void)setupPage
{
    UIView *flash = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth * 260)/600.0)];
    flash.backgroundColor = [UIColor clearColor];
    
    gheikcmaeoxqadScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, flash.frame.size.width, (kDeviceWidth * 260)/600.0)];
    gheikcmaeoxqadScrollView.showsVerticalScrollIndicator = NO;
    gheikcmaeoxqadScrollView.showsHorizontalScrollIndicator = NO;
    gheikcmaeoxqadScrollView.userInteractionEnabled = YES;
    gheikcmaeoxqadScrollView.delegate = self;
    gheikcmaeoxqadScrollView.scrollsToTop = NO;
    [flash addSubview:gheikcmaeoxqadScrollView];
    
    [gheikcmaeoxqadScrollView setBackgroundColor:[UIColor clearColor]];
    [gheikcmaeoxqadScrollView setCanCancelContentTouches:NO];
    
    gheikcmaeoxqadScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    gheikcmaeoxqadScrollView.clipsToBounds = YES;
    gheikcmaeoxqadScrollView.scrollEnabled = YES;
    gheikcmaeoxqadScrollView.pagingEnabled = YES;

    float count = gheikcmaeoxqadsArray.count;
    CGFloat cx = 0;
    for (int num =0; num<count; num++) {
        CGRect frame;
        UIButton * Btn= [[UIButton alloc] init];
        Btn.tag = num;
        
        frame.size.width = kDeviceWidth;//设置按钮坐标及大小
        frame.size.height = (kDeviceWidth * 260)/600.0;
        frame.origin.x = 0 + cx;
        frame.origin.y = 0;
        [Btn setFrame:frame];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[[gheikcmaeoxqadsArray objectAtIndex:num] objectForKey:@"thumb"]] placeholderImage:[UIImage imageNamed:@"placeholder-zt"]];
        [gheikcmaeoxqadScrollView addSubview:imageView];
        
        [Btn setBackgroundColor:[UIColor clearColor]];
        [Btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [gheikcmaeoxqadScrollView addSubview:Btn];
        
        cx += gheikcmaeoxqadScrollView.frame.size.width;
    }
    
    gheikcmaeoxqpageControl = [[StyledPageControl alloc] initWithFrame:CGRectMake(kDeviceWidth - 90, (kDeviceWidth * 260)/600.0 - 20, 80, 20.0f)];
    [gheikcmaeoxqpageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [gheikcmaeoxqpageControl setPageControlStyle:PageControlStyleDefault];
    [gheikcmaeoxqpageControl setNumberOfPages:count];
    [gheikcmaeoxqpageControl setCurrentPage:0];
    [gheikcmaeoxqpageControl setGapWidth:6];
    [gheikcmaeoxqpageControl setDiameter:8];
    [flash addSubview:gheikcmaeoxqpageControl];
    
    
    [gheikcmaeoxqadScrollView setContentSize:CGSizeMake(gheikcmaeoxqadScrollView.frame.size.width*count, [gheikcmaeoxqadScrollView bounds].size.height)];
    [self.gheikcmaeoxqtableView setTableHeaderView:flash];
}


- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    if (gheikcmaeoxqpageControlIsChangingPage) {
        return;
    }

    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    gheikcmaeoxqpageControl.currentPage = page;
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    gheikcmaeoxqpageControlIsChangingPage = NO;
}


- (void)changePage:(id)sender {
    CGRect frame = gheikcmaeoxqadScrollView.frame;
    frame.origin.x = frame.size.width * gheikcmaeoxqpageControl.currentPage;
    frame.origin.y = 0;
    [gheikcmaeoxqadScrollView scrollRectToVisible:frame animated:YES];
    gheikcmaeoxqpageControlIsChangingPage = YES;
}


- (void)pageControlPageDidChange:(UIPageControl *)spageControl {
    CGRect frame = gheikcmaeoxqadScrollView.frame;
    frame.origin.x = frame.size.width * spageControl.currentPage;
    frame.origin.y = 0;
    [gheikcmaeoxqadScrollView scrollRectToVisible:frame animated:YES];
    gheikcmaeoxqpageControlIsChangingPage = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    }
    return YES;
}


-(void) uploadIDFAData:(NSString*)gotoUrl {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSString *_gotoUrl = [gotoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *_client_id = [appDelegate.gheikcmaeoxqclientIDFAInfo objectForKey:@"1"];
    
    NSString *rawData = [NSString stringWithFormat:@"%@%@G%@G%@G%@", STAT_INFO_URL, @"1", _client_id, appDelegate.idfa, _gotoUrl];
    
    __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[rawData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    __weak ASIHTTPRequest *request = requests;
    [request setCompletionBlock:^{
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        if (error) {
            NSLog(@"上传统计数据错误:%@", [error localizedDescription]);
        }
    }];
    [request startAsynchronous];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.gheikcmaeoxqtableView reloadData];
}

#pragma mark - 远程服务检测

- (void)checkServerStatus {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(appDelegate.gheikcmaeoxqisFirstStart) {
        
        __block ASIHTTPRequest *requests = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@/app_type/%@", UPDATE, [NSString stringWithFormat:@"%d",APP_ID],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        __weak ASIHTTPRequest *request = requests;
        [request setCompletionBlock:^{
            NSData *responseData = [request responseData];
            NSDictionary *ret = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            BOOL isNeedUpdate = [[ret objectForKey:@"status"] boolValue];
            if (!isNeedUpdate) {
                NSString *description = [ret objectForKey:@"description"];
                NSURL *url = [NSURL URLWithString:[ret objectForKey:@"download_url"]];
                
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"更新提醒" message:description preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"去下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:url];
                    
                }];
                
                [alertCtrl addAction:cancelAction];
                [alertCtrl addAction:confirmAction];
                
                [self presentViewController:alertCtrl animated:YES completion:NULL];
            }
        }];
        [request setFailedBlock:^{
            NSLog(@"更新接口出错");
        }];
        //    [request setCompletionBlock:^{
        //
        //        if (self.progressHud) {
        //            [self.progressHud hide:YES];
        //            self.progressHud = nil;
        //        }
        //
        //        [SWSettings sharedInstance].firstLanuch = NO;
        //
        //        [_vpnButton setTitle:LSTR(@"连接成功") forState:UIControlStateNormal];
        //
        //        [self stopPlusAnimation];
        //
        //        _serverStatusLabel.text = @"连接成功";
        //        _serverStatusLabel.textColor = [UIColor whiteColor];
        //
        //        _checkStatus = YES;
        //        
        //        [self systemProxyStatus];
        //        
        //        
        //    }];
        [request startAsynchronous];
    }
}


@end
