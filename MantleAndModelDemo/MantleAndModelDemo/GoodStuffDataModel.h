//
//  GoodStuffDataModel.h
//  MantleAndModelDemo
//
//  Created by APP on 2017/2/14.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "MTLModel.h"


@interface GoodStuffDataModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger stuffID;
@property (nonatomic, strong) NSString *stuff_des;
@property (nonatomic, strong) NSString *stuff_titles;
@property (nonatomic, strong) NSString *stuff_picurl;
@property (nonatomic, strong) NSString *start_discount;


@end
/*
 Printing description of dictlist:
 {
 "deal_num" = 5;
 des = "\U53ef\U62c6\U5378\U5237\U5934 \U5237\U5934\U7ec6\U5bc6\U6574\U9f50 \U6613\U6e05\U6d17 \U5e72\U71e5\U900f\U6c14";
 "dis_price" = 10;
 discount = "4.3";
 "is_onsale" = 1;
 "is_view_show" = 0;
 "is_vip_price" = 0;
 "item_url" = "https://m.repai.com/item/view/id/2014603465924347";
 "item_urls" = "https://m.repai.com/item/view/id/2014603465924347?arg=ok&top=40";
 "lee_price" = "4.9";
 "lefttop_pic" = "";
 limitCount = 0;
 "now_price" = "9.9";
 "num_iid" = 2014603465924347;
 "origin_price" = 23;
 "pic_url" = "https://pic.repaiapp.com/pic/ee/af/90/eeaf90252e28cc78d70ad2a24b0170fd76e5fa48.jpg";
 "rp_quantity" = 2480;
 "rp_sold" = "56.6\U4e07";
 "rp_type" = 103;
 shopId = 1;
 "show_time" = "\U65e0";
 "spic_url" = "https://pic.repaiapp.com/pic/ee/af/90/eeaf90252e28cc78d70ad2a24b0170fd76e5fa48.jpg";
 "start_discount" = "2017-01-13 00:00:00";
 "tag_bt0" = "\U5c45\U5bb6\U5fc5\U5907";
 "tag_bt0url" = "http://zhekou.repai.com/jkjby/view/rp_b2c_update1.php?type=1&jid=17&snew=1";
 "tag_bt1" = "\U5988\U5988";
 "tag_bt1url" = "http://zhekou.repai.com/jkjby/view/rp_b2c_update1.php?type=1&jid=13&snew=1";
 tagimage = "http://m.repai.com/static/new_img/buy_f.png?v=1";
 tezheng = "https://pic.repaiapp.com/pic/6f/97/48/6f9748c3a0185faaa709d601ed66f9377d5db3a4.png";
 tezhengjurl = "http://m.repai.com/item/view/id/2014603465924347/?push=target";
 title = "5\U5305\U88c5 400\U5f20\U4e09\U5c42 \U62bd\U7eb8 \U9762\U5dfe\U7eb8\U9910\U5dfe\U7eb8\U536b\U751f\U7eb8 \U7eaf\U6728\U6d46\U7eb8\U5dfe";
 "total_love_number" = 0;
 }
 
 */
