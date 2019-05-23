#import "LifeMoreAppCell.h"
#import "UIImageView+WebCache.h"

@implementation LifeMoreAppCell

@synthesize gheikcmaeoxqiconView,gheikcmaeoxqnameLabel,gheikcmaeoxqdescLabel,gheikcmaeoxqcommendView,gheikcmaeoxqcommendLabel,gheikcmaeoxqpriceButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIndentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIndentifier]) {
        
        gheikcmaeoxqiconView = [[UIImageView alloc] init];
        gheikcmaeoxqiconView.frame = CGRectMake(10,6.5, 57, 57);
        gheikcmaeoxqiconView.layer.cornerRadius = 12.0f;
        gheikcmaeoxqiconView.layer.masksToBounds = YES;
        [self.contentView addSubview:gheikcmaeoxqiconView];
        //图标
        
        gheikcmaeoxqnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 8.0f, self.contentView.frame.size.width - 125, 15.0f)];
        gheikcmaeoxqnameLabel.backgroundColor = [UIColor clearColor];
        gheikcmaeoxqnameLabel.textAlignment = NSTextAlignmentLeft;
        gheikcmaeoxqnameLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:gheikcmaeoxqnameLabel];
        //名称
				    
        gheikcmaeoxqdescLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 30.0f, self.contentView.frame.size.width - 125, 36)];
        gheikcmaeoxqdescLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        gheikcmaeoxqdescLabel.backgroundColor = [UIColor clearColor];
        gheikcmaeoxqdescLabel.font = [UIFont systemFontOfSize:12];
        gheikcmaeoxqdescLabel.numberOfLines = 2;
        gheikcmaeoxqdescLabel.lineBreakMode = NSLineBreakByWordWrapping;
        gheikcmaeoxqdescLabel.textColor = [UIColor lightGrayColor];
        gheikcmaeoxqdescLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:gheikcmaeoxqdescLabel];
        //简介
        
        
        gheikcmaeoxqcommendView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 40, 8, 30, 14)];
        gheikcmaeoxqcommendView.backgroundColor = [UIColor redColor];
        gheikcmaeoxqcommendView.layer.cornerRadius = 2.0f;
        gheikcmaeoxqcommendView.layer.masksToBounds = YES;
        [self.contentView addSubview:gheikcmaeoxqcommendView];
        
        gheikcmaeoxqcommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width -40, 8, 30, 14)];
        gheikcmaeoxqcommendLabel.backgroundColor = [UIColor clearColor];
        gheikcmaeoxqcommendLabel.font = [UIFont systemFontOfSize:10];
        gheikcmaeoxqcommendLabel.textColor = [UIColor whiteColor];
        gheikcmaeoxqcommendLabel.shadowColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        gheikcmaeoxqcommendLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:gheikcmaeoxqcommendLabel];
        //是否推荐
        
        
        gheikcmaeoxqpriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        gheikcmaeoxqpriceButton.frame = CGRectMake ((self.contentView.frame.size.width - 40) , 30.0f, 30.0f, 16.0f);
        gheikcmaeoxqpriceButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin + UIViewAutoresizingFlexibleRightMargin  +UIViewAutoresizingFlexibleBottomMargin;
        gheikcmaeoxqpriceButton.backgroundColor = [UIColor colorWithRed:0.92 green:0.19 blue:0.52 alpha:1];
        gheikcmaeoxqpriceButton.layer.cornerRadius = 2.0f;
        gheikcmaeoxqpriceButton.layer.masksToBounds = YES;
        [gheikcmaeoxqpriceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        gheikcmaeoxqpriceButton.titleLabel.font = [UIFont systemFontOfSize:10];
        gheikcmaeoxqpriceButton.userInteractionEnabled = NO;
        [self.contentView addSubview:gheikcmaeoxqpriceButton];
        
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setAppData:(NSDictionary *)app AtIndex:(NSInteger)index
{
    [gheikcmaeoxqiconView sd_setImageWithURL:[NSURL URLWithString:[app objectForKey:@"app_icon"]] placeholderImage:[UIImage imageNamed:@"app_placeholder_icon.png"]];
    
    CGSize labelSize = [[app objectForKey:@"app_name"] sizeWithFont:[UIFont boldSystemFontOfSize:13]
                                                  constrainedToSize:CGSizeMake(300, MAXFLOAT)
                                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        float xx = 0;
        if (labelSize.width  >= self.contentView.frame.size.width - 125) {
            xx = self.contentView.frame.size.width - 125;
        }else{
            xx = labelSize.width;
        }
        
        gheikcmaeoxqnameLabel.frame = CGRectMake(80.0f, 8.0f, xx, 15.0f);
        gheikcmaeoxqnameLabel.text = [app objectForKey:@"app_name"];//app名称
        gheikcmaeoxqdescLabel.text = [app objectForKey:@"app_desc"];//app简介
        
        if ([[app objectForKey:@"app_commend"] integerValue] == 1) {
            gheikcmaeoxqcommendView.backgroundColor = [UIColor redColor];
            gheikcmaeoxqcommendLabel.text = @"热门";//推荐app
            gheikcmaeoxqcommendView.frame = CGRectMake(xx + 80.0 + 10, 8, 30, 14);
            gheikcmaeoxqcommendLabel.frame = CGRectMake(xx + 80.0 + 10, 8, 30, 14);
        }else{
            gheikcmaeoxqcommendView.backgroundColor = [UIColor clearColor];
            gheikcmaeoxqcommendLabel.text = @"";
            
        }
        
    }else{
        
        gheikcmaeoxqnameLabel.frame = CGRectMake(80.0f, 8.0f, labelSize.width, 15.0f);
        gheikcmaeoxqnameLabel.text = [app objectForKey:@"app_name"];//app名称
        gheikcmaeoxqdescLabel.text = [app objectForKey:@"app_desc"];//app简介
        
        if ([[app objectForKey:@"app_commend"] integerValue] == 1) {
            gheikcmaeoxqcommendView.backgroundColor = [UIColor redColor];
            gheikcmaeoxqcommendLabel.text = @"热门";//推荐app
            gheikcmaeoxqcommendView.frame = CGRectMake(labelSize.width + 80.0 + 10, 8, 30, 14);
            gheikcmaeoxqcommendLabel.frame = CGRectMake(labelSize.width + 80.0 + 10, 8, 30, 14);
        }else{
            gheikcmaeoxqcommendView.backgroundColor = [UIColor clearColor];
            gheikcmaeoxqcommendLabel.text = @"";
            
        }
    }
    
    
    if ([[app objectForKey:@"app_price"] integerValue] == 0) {
        [gheikcmaeoxqpriceButton setTitle:@"免费" forState:UIControlStateNormal];
    }else{
        [gheikcmaeoxqpriceButton setTitle:[NSString stringWithFormat:@"￥%ld",(long)[[app objectForKey:@"app_price"] integerValue]] forState:UIControlStateNormal];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


@end
