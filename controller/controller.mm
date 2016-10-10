//    												
//    												
//    	 ______    ______    ______					
//    	/\  __ \  /\  ___\  /\  ___\			
//    	\ \  __<  \ \  __\_ \ \  __\_		
//    	 \ \_____\ \ \_____\ \ \_____\		
//    	  \/_____/  \/_____/  \/_____/			
//    												
//    												
//    												
// title:  boeProject
// author: haozhiyu1990
// date:   2016-09-30 07:16:12 +0000
//

#import "controller.h"

#pragma mark - AddressInfo

@implementation AddressInfo

@synthesize a_id = _a_id;
@synthesize address = _address;
@synthesize home = _home;
@synthesize name = _name;
@synthesize qu = _qu;
@synthesize qu_id = _qu_id;
@synthesize sheng = _sheng;
@synthesize sheng_id = _sheng_id;
@synthesize shi = _shi;
@synthesize shi_id = _shi_id;
@synthesize tel = _tel;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - Area

@implementation Area

@synthesize qu_id = _qu_id;
@synthesize title = _title;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ArtistInfo

@implementation ArtistInfo

@synthesize collection = _collection;
@synthesize collection_num = _collection_num;
@synthesize content = _content;
@synthesize fans = _fans;
@synthesize image = _image;
@synthesize nike = _nike;
@synthesize products_list = _products_list;
@synthesize u_id = _u_id;
@synthesize works_num = _works_num;

CONVERT_PROPERTY_CLASS( products_list, ArtistWorkList );

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ArtistWorkList

@implementation ArtistWorkList

@synthesize image = _image;
@synthesize p_id = _p_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - BalanceInfo

@implementation BalanceInfo

@synthesize balance = _balance;
@synthesize nike = _nike;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - BannerInfo

@implementation BannerInfo

@synthesize banner_id = _banner_id;
@synthesize banner_image = _banner_image;
@synthesize banner_title = _banner_title;
@synthesize banner_url = _banner_url;
@synthesize types = _types;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - CapitalFlow

@implementation CapitalFlow

@synthesize created_at = _created_at;
@synthesize o_id = _o_id;
@synthesize order_num = _order_num;
@synthesize p_id = _p_id;
@synthesize price = _price;
@synthesize title = _title;
@synthesize type = _type;
@synthesize types = _types;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - City

@implementation City

@synthesize shi_id = _shi_id;
@synthesize title = _title;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ClassList

@implementation ClassList

@synthesize c_id = _c_id;
@synthesize title = _title;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - CommentInfo

@implementation CommentInfo

@synthesize c_id = _c_id;
@synthesize content = _content;
@synthesize image = _image;
@synthesize nike = _nike;
@synthesize r_comment_list = _r_comment_list;
@synthesize u_id = _u_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - DetailsInfo

@implementation DetailsInfo

@synthesize classs = _classs;
@synthesize coll_nums = _coll_nums;
@synthesize collection = _collection;
@synthesize comment_list = _comment_list;
@synthesize content = _content;
@synthesize created_at = _created_at;
@synthesize electronic_nums = _electronic_nums;
@synthesize electronic_price = _electronic_price;
@synthesize electronics_nume = _electronics_nume;
@synthesize guess_list = _guess_list;
@synthesize image = _image;
@synthesize image_url = _image_url;
@synthesize material_num = _material_num;
@synthesize material_nums = _material_nums;
@synthesize material_price = _material_price;
@synthesize material_sum = _material_sum;
@synthesize p_id = _p_id;
@synthesize pay_type = _pay_type;
@synthesize pictureFrameTypeOne = _pictureFrameTypeOne;
@synthesize pictureFrameTypeTwo = _pictureFrameTypeTwo;
@synthesize plates = _plates;
@synthesize price_open = _price_open;
@synthesize reward_nums = _reward_nums;
@synthesize theme = _theme;
@synthesize title = _title;
@synthesize u_id = _u_id;
@synthesize u_image = _u_image;
@synthesize u_name = _u_name;
@synthesize works_nums = _works_nums;
@synthesize years = _years;
@synthesize zambia = _zambia;
@synthesize zambia_nums = _zambia_nums;

CONVERT_PROPERTY_CLASS( comment_list, CommentInfo );
CONVERT_PROPERTY_CLASS( guess_list, GuessInfo );

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - EquipmentList

@implementation EquipmentList

@synthesize authoris = _authoris;
@synthesize e_id = _e_id;
@synthesize e_time = _e_time;
@synthesize l_time = _l_time;
@synthesize mac_id = _mac_id;
@synthesize push_type = _push_type;
@synthesize s_time = _s_time;
@synthesize title = _title;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - FindIndex

@implementation FindIndex

@synthesize classs = _classs;
@synthesize coll_nums = _coll_nums;
@synthesize created_at = _created_at;
@synthesize follow_nums = _follow_nums;
@synthesize image = _image;
@synthesize image_url = _image_url;
@synthesize material_nums = _material_nums;
@synthesize p_id = _p_id;
@synthesize plates = _plates;
@synthesize theme = _theme;
@synthesize title = _title;
@synthesize u_image = _u_image;
@synthesize u_name = _u_name;
@synthesize years = _years;
@synthesize zambia_nums = _zambia_nums;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - GuessInfo

@implementation GuessInfo

@synthesize image = _image;
@synthesize p_id = _p_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - HomeIndex

@implementation HomeIndex

@synthesize classs = _classs;
@synthesize coll_nums = _coll_nums;
@synthesize collection = _collection;
@synthesize created_at = _created_at;
@synthesize image = _image;
@synthesize p_id = _p_id;
@synthesize plates = _plates;
@synthesize theme = _theme;
@synthesize title = _title;
@synthesize u_image = _u_image;
@synthesize u_name = _u_name;
@synthesize years = _years;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - OrderInfo

@implementation OrderInfo

@synthesize balance = _balance;
@synthesize created_at = _created_at;
@synthesize image = _image;
@synthesize image_url = _image_url;
@synthesize nike = _nike;
@synthesize o_id = _o_id;
@synthesize order_num = _order_num;
@synthesize order_type = _order_type;
@synthesize orders = _orders;
@synthesize p_id = _p_id;
@synthesize price = _price;
@synthesize s_address = _s_address;
@synthesize s_name = _s_name;
@synthesize s_tel = _s_tel;
@synthesize state = _state;
@synthesize state_order = _state_order;
@synthesize title = _title;
@synthesize types = _types;
@synthesize u_id = _u_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - Provi

@implementation Provi

@synthesize sheng_id = _sheng_id;
@synthesize title = _title;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RankingList

@implementation RankingList

@synthesize collection_list = _collection_list;
@synthesize follow_list = _follow_list;
@synthesize purchase_list = _purchase_list;

CONVERT_PROPERTY_CLASS( collection_list, FindIndex );
CONVERT_PROPERTY_CLASS( follow_list, FindIndex );
CONVERT_PROPERTY_CLASS( purchase_list, FindIndex );

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ReCommentInfo

@implementation ReCommentInfo

@synthesize c_id = _c_id;
@synthesize content = _content;
@synthesize image = _image;
@synthesize nike = _nike;
@synthesize u_id = _u_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ShareToEquipObj

@implementation ShareToEquipObj

@synthesize all_list = _all_list;
@synthesize my_list = _my_list;

CONVERT_PROPERTY_CLASS( all_list, all_listObje );
CONVERT_PROPERTY_CLASS( my_list, my_listObje );

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - SpecialInfo

@implementation SpecialInfo

@synthesize content = _content;
@synthesize created_at = _created_at;
@synthesize image = _image;
@synthesize nike = _nike;
@synthesize p_id = _p_id;
@synthesize read_num = _read_num;
@synthesize s_id = _s_id;
@synthesize time = _time;
@synthesize title = _title;
@synthesize u_id = _u_id;
@synthesize u_image = _u_image;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - ThemeList

@implementation ThemeList

@synthesize c_id = _c_id;
@synthesize title = _title;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - UserInfo

@implementation UserInfo

@synthesize collection_num = _collection_num;
@synthesize content = _content;
@synthesize fans = _fans;
@synthesize image = _image;
@synthesize nike = _nike;
@synthesize tel = _tel;
@synthesize token = _token;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - VerifyInfo

@implementation VerifyInfo

@synthesize time = _time;
@synthesize user = _user;
@synthesize verify = _verify;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - VerifyIs

@implementation VerifyIs

@synthesize cation = _cation;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - all_listObje

@implementation all_listObje

@synthesize authoris = _authoris;
@synthesize e_id = _e_id;
@synthesize e_time = _e_time;
@synthesize image = _image;
@synthesize l_time = _l_time;
@synthesize mac_id = _mac_id;
@synthesize nike = _nike;
@synthesize push_type = _push_type;
@synthesize s_time = _s_time;
@synthesize title = _title;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - my_listObje

@implementation my_listObje

@synthesize image = _image;
@synthesize nike = _nike;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - GET /app.php/Finds/activity_list

#pragma mark - REQ_APP_PHP_FINDS_ACTIVITY_LIST

@implementation REQ_APP_PHP_FINDS_ACTIVITY_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_ACTIVITY_LIST

@implementation RESP_APP_PHP_FINDS_ACTIVITY_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, SpecialInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_ACTIVITY_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_ACTIVITY_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/activity_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_ACTIVITY_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/activity_read

#pragma mark - REQ_APP_PHP_FINDS_ACTIVITY_READ

@implementation REQ_APP_PHP_FINDS_ACTIVITY_READ

@synthesize s_id = _s_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_ACTIVITY_READ

@implementation RESP_APP_PHP_FINDS_ACTIVITY_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_ACTIVITY_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_ACTIVITY_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/activity_read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_ACTIVITY_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/artist

#pragma mark - REQ_APP_PHP_FINDS_ARTIST

@implementation REQ_APP_PHP_FINDS_ARTIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_ARTIST

@implementation RESP_APP_PHP_FINDS_ARTIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ArtistInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_ARTIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_ARTIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/artist"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_ARTIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/artist_read

#pragma mark - REQ_APP_PHP_FINDS_ARTIST_READ

@implementation REQ_APP_PHP_FINDS_ARTIST_READ

@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_ARTIST_READ

@implementation RESP_APP_PHP_FINDS_ARTIST_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_ARTIST_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_ARTIST_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/artist_read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_ARTIST_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/artist_works_list

#pragma mark - REQ_APP_PHP_FINDS_ARTIST_WORKS_LIST

@implementation REQ_APP_PHP_FINDS_ARTIST_WORKS_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize u_id = _u_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_ARTIST_WORKS_LIST

@implementation RESP_APP_PHP_FINDS_ARTIST_WORKS_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ArtistWorkList );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_ARTIST_WORKS_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_ARTIST_WORKS_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/artist_works_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_ARTIST_WORKS_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/collection_list

#pragma mark - REQ_APP_PHP_FINDS_COLLECTION_LIST

@implementation REQ_APP_PHP_FINDS_COLLECTION_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_COLLECTION_LIST

@implementation RESP_APP_PHP_FINDS_COLLECTION_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ArtistInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_COLLECTION_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_COLLECTION_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/collection_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_COLLECTION_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/fanss

#pragma mark - REQ_APP_PHP_FINDS_FANSS

@implementation REQ_APP_PHP_FINDS_FANSS

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_FANSS

@implementation RESP_APP_PHP_FINDS_FANSS

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ArtistInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_FANSS

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_FANSS alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/fanss"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_FANSS objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/index

#pragma mark - REQ_APP_PHP_FINDS_INDEX

@implementation REQ_APP_PHP_FINDS_INDEX

@synthesize artist = _artist;
@synthesize classs = _classs;
@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize plates = _plates;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_INDEX

@implementation RESP_APP_PHP_FINDS_INDEX

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, FindIndex );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_INDEX

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_INDEX alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/index"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_INDEX objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/ranking_list

#pragma mark - RESP_APP_PHP_FINDS_RANKING_LIST

@implementation RESP_APP_PHP_FINDS_RANKING_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_RANKING_LIST

@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/ranking_list"];
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_RANKING_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/special

#pragma mark - REQ_APP_PHP_FINDS_SPECIAL

@implementation REQ_APP_PHP_FINDS_SPECIAL

@synthesize page = _page;
@synthesize pagecount = _pagecount;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_SPECIAL

@implementation RESP_APP_PHP_FINDS_SPECIAL

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, SpecialInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_SPECIAL

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_SPECIAL alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/special"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_SPECIAL objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Finds/special_read

#pragma mark - REQ_APP_PHP_FINDS_SPECIAL_READ

@implementation REQ_APP_PHP_FINDS_SPECIAL_READ

@synthesize s_id = _s_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_FINDS_SPECIAL_READ

@implementation RESP_APP_PHP_FINDS_SPECIAL_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_FINDS_SPECIAL_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_FINDS_SPECIAL_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Finds/special_read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_FINDS_SPECIAL_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/balance

#pragma mark - REQ_APP_PHP_INDEX_BALANCE

@implementation REQ_APP_PHP_INDEX_BALANCE

@synthesize a_id = _a_id;
@synthesize balance = _balance;
@synthesize content = _content;
@synthesize p_id = _p_id;
@synthesize price = _price;
@synthesize type = _type;
@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_BALANCE

@implementation RESP_APP_PHP_INDEX_BALANCE

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_BALANCE

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_BALANCE alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/balance"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_BALANCE objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/banner

#pragma mark - RESP_APP_PHP_INDEX_BANNER

@implementation RESP_APP_PHP_INDEX_BANNER

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, BannerInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_BANNER

@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/banner"];
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_BANNER objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/class_list

#pragma mark - RESP_APP_PHP_INDEX_CLASS_LIST

@implementation RESP_APP_PHP_INDEX_CLASS_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ClassList );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_CLASS_LIST

@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/class_list"];
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_CLASS_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/collection_add

#pragma mark - REQ_APP_PHP_INDEX_COLLECTION_ADD

@implementation REQ_APP_PHP_INDEX_COLLECTION_ADD

@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_COLLECTION_ADD

@implementation RESP_APP_PHP_INDEX_COLLECTION_ADD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_COLLECTION_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_COLLECTION_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/collection_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_COLLECTION_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/collection_del

#pragma mark - REQ_APP_PHP_INDEX_COLLECTION_DEL

@implementation REQ_APP_PHP_INDEX_COLLECTION_DEL

@synthesize u_id = _u_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_COLLECTION_DEL

@implementation RESP_APP_PHP_INDEX_COLLECTION_DEL

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_COLLECTION_DEL

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_COLLECTION_DEL alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/collection_del"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_COLLECTION_DEL objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/comment_add

#pragma mark - REQ_APP_PHP_INDEX_COMMENT_ADD

@implementation REQ_APP_PHP_INDEX_COMMENT_ADD

@synthesize content = _content;
@synthesize p_id = _p_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_COMMENT_ADD

@implementation RESP_APP_PHP_INDEX_COMMENT_ADD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_COMMENT_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_COMMENT_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/comment_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_COMMENT_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/gz_index

#pragma mark - REQ_APP_PHP_INDEX_GZ_INDEX

@implementation REQ_APP_PHP_INDEX_GZ_INDEX

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_GZ_INDEX

@implementation RESP_APP_PHP_INDEX_GZ_INDEX

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, HomeIndex );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_GZ_INDEX

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_GZ_INDEX alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/gz_index"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_GZ_INDEX objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/index

#pragma mark - REQ_APP_PHP_INDEX_INDEX

@implementation REQ_APP_PHP_INDEX_INDEX

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_INDEX

@implementation RESP_APP_PHP_INDEX_INDEX

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, HomeIndex );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_INDEX

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_INDEX alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/index"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_INDEX objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/r_comm_add

#pragma mark - REQ_APP_PHP_INDEX_R_COMM_ADD

@implementation REQ_APP_PHP_INDEX_R_COMM_ADD

@synthesize comm_id = _comm_id;
@synthesize p_id = _p_id;
@synthesize title = _title;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_R_COMM_ADD

@implementation RESP_APP_PHP_INDEX_R_COMM_ADD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_R_COMM_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_R_COMM_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/r_comm_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_R_COMM_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/read

#pragma mark - REQ_APP_PHP_INDEX_READ

@implementation REQ_APP_PHP_INDEX_READ

@synthesize p_id = _p_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_INDEX_READ

@implementation RESP_APP_PHP_INDEX_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_INDEX_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Index/theme_list

#pragma mark - RESP_APP_PHP_INDEX_THEME_LIST

@implementation RESP_APP_PHP_INDEX_THEME_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, ThemeList );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_INDEX_THEME_LIST

@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Index/theme_list"];
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_INDEX_THEME_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Jpush/index

#pragma mark - REQ_APP_PHP_JPUSH_INDEX

@implementation REQ_APP_PHP_JPUSH_INDEX

@synthesize e_id = _e_id;
@synthesize p_id = _p_id;
@synthesize pay_type = _pay_type;
@synthesize type = _type;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_JPUSH_INDEX

@implementation RESP_APP_PHP_JPUSH_INDEX

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_JPUSH_INDEX

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_JPUSH_INDEX alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Jpush/index"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_JPUSH_INDEX objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/address_add

#pragma mark - REQ_APP_PHP_USER_ADDRESS_ADD

@implementation REQ_APP_PHP_USER_ADDRESS_ADD

@synthesize a_id = _a_id;
@synthesize address = _address;
@synthesize city = _city;
@synthesize home = _home;
@synthesize name = _name;
@synthesize tel = _tel;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_ADDRESS_ADD

@implementation RESP_APP_PHP_USER_ADDRESS_ADD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_ADDRESS_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_ADDRESS_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/address_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_ADDRESS_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/address_del

#pragma mark - REQ_APP_PHP_USER_ADDRESS_DEL

@implementation REQ_APP_PHP_USER_ADDRESS_DEL

@synthesize a_id = _a_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_ADDRESS_DEL

@implementation RESP_APP_PHP_USER_ADDRESS_DEL

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_ADDRESS_DEL

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_ADDRESS_DEL alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/address_del"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_ADDRESS_DEL objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/address_list

#pragma mark - REQ_APP_PHP_USER_ADDRESS_LIST

@implementation REQ_APP_PHP_USER_ADDRESS_LIST

@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_ADDRESS_LIST

@implementation RESP_APP_PHP_USER_ADDRESS_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, AddressInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_ADDRESS_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_ADDRESS_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/address_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_ADDRESS_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/balance

#pragma mark - REQ_APP_PHP_USER_BALANCE

@implementation REQ_APP_PHP_USER_BALANCE

@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_BALANCE

@implementation RESP_APP_PHP_USER_BALANCE

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_BALANCE

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_BALANCE alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/balance"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_BALANCE objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/capital_flow

#pragma mark - REQ_APP_PHP_USER_CAPITAL_FLOW

@implementation REQ_APP_PHP_USER_CAPITAL_FLOW

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_CAPITAL_FLOW

@implementation RESP_APP_PHP_USER_CAPITAL_FLOW

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, CapitalFlow );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_CAPITAL_FLOW

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_CAPITAL_FLOW alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/capital_flow"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_CAPITAL_FLOW objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/codecation

#pragma mark - REQ_APP_PHP_USER_CODECATION

@implementation REQ_APP_PHP_USER_CODECATION

@synthesize code = _code;
@synthesize tel = _tel;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_CODECATION

@implementation RESP_APP_PHP_USER_CODECATION

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_CODECATION

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_CODECATION alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/codecation"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_CODECATION objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/equipment_add

#pragma mark - REQ_APP_PHP_USER_EQUIPMENT_ADD

@implementation REQ_APP_PHP_USER_EQUIPMENT_ADD

@synthesize mac_id = _mac_id;
@synthesize title = _title;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_EQUIPMENT_ADD

@implementation RESP_APP_PHP_USER_EQUIPMENT_ADD

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_EQUIPMENT_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_EQUIPMENT_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/equipment_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_EQUIPMENT_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/equipment_del

#pragma mark - REQ_APP_PHP_USER_EQUIPMENT_DEL

@implementation REQ_APP_PHP_USER_EQUIPMENT_DEL

@synthesize mac_id = _mac_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_EQUIPMENT_DEL

@implementation RESP_APP_PHP_USER_EQUIPMENT_DEL

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_EQUIPMENT_DEL

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_EQUIPMENT_DEL alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/equipment_del"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_EQUIPMENT_DEL objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/equipment_info

#pragma mark - REQ_APP_PHP_USER_EQUIPMENT_INFO

@implementation REQ_APP_PHP_USER_EQUIPMENT_INFO

@synthesize e_id = _e_id;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_EQUIPMENT_INFO

@implementation RESP_APP_PHP_USER_EQUIPMENT_INFO

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_EQUIPMENT_INFO

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_EQUIPMENT_INFO alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/equipment_info"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_EQUIPMENT_INFO objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/equipment_list

#pragma mark - REQ_APP_PHP_USER_EQUIPMENT_LIST

@implementation REQ_APP_PHP_USER_EQUIPMENT_LIST

@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_EQUIPMENT_LIST

@implementation RESP_APP_PHP_USER_EQUIPMENT_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, EquipmentList );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_EQUIPMENT_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_EQUIPMENT_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/equipment_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_EQUIPMENT_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/login

#pragma mark - REQ_APP_PHP_USER_LOGIN

@implementation REQ_APP_PHP_USER_LOGIN

@synthesize pass = _pass;
@synthesize tel = _tel;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_LOGIN

@implementation RESP_APP_PHP_USER_LOGIN

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_LOGIN

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_LOGIN alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/login"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_LOGIN objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/password

#pragma mark - REQ_APP_PHP_USER_PASSWORD

@implementation REQ_APP_PHP_USER_PASSWORD

@synthesize code = _code;
@synthesize newpass = _newpass;
@synthesize tel = _tel;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_PASSWORD

@implementation RESP_APP_PHP_USER_PASSWORD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_PASSWORD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_PASSWORD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/password"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_PASSWORD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/pay_list

#pragma mark - REQ_APP_PHP_USER_PAY_LIST

@implementation REQ_APP_PHP_USER_PAY_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_PAY_LIST

@implementation RESP_APP_PHP_USER_PAY_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, OrderInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_PAY_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_PAY_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/pay_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_PAY_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/pay_read

#pragma mark - REQ_APP_PHP_USER_PAY_READ

@implementation REQ_APP_PHP_USER_PAY_READ

@synthesize o_id = _o_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_PAY_READ

@implementation RESP_APP_PHP_USER_PAY_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_PAY_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_PAY_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/pay_read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_PAY_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/post_comd

#pragma mark - REQ_APP_PHP_USER_POST_COMD

@implementation REQ_APP_PHP_USER_POST_COMD

@synthesize o_id = _o_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_POST_COMD

@implementation RESP_APP_PHP_USER_POST_COMD

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_POST_COMD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_POST_COMD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/post_comd"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_POST_COMD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/pre_list

#pragma mark - REQ_APP_PHP_USER_PRE_LIST

@implementation REQ_APP_PHP_USER_PRE_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_PRE_LIST

@implementation RESP_APP_PHP_USER_PRE_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, OrderInfo );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_PRE_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_PRE_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/pre_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_PRE_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/pre_read

#pragma mark - REQ_APP_PHP_USER_PRE_READ

@implementation REQ_APP_PHP_USER_PRE_READ

@synthesize o_id = _o_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_PRE_READ

@implementation RESP_APP_PHP_USER_PRE_READ

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_PRE_READ

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_PRE_READ alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/pre_read"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_PRE_READ objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/qu

#pragma mark - REQ_APP_PHP_USER_QU

@implementation REQ_APP_PHP_USER_QU

@synthesize shi_id = _shi_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_QU

@implementation RESP_APP_PHP_USER_QU

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, Area );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_QU

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_QU alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/qu"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_QU objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/register

#pragma mark - REQ_APP_PHP_USER_REGISTER

@implementation REQ_APP_PHP_USER_REGISTER

@synthesize code = _code;
@synthesize pass = _pass;
@synthesize tel = _tel;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_REGISTER

@implementation RESP_APP_PHP_USER_REGISTER

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_REGISTER

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_REGISTER alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/register"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_REGISTER objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/share_equipment_list

#pragma mark - REQ_APP_PHP_USER_SHARE_EQUIPMENT_LIST

@implementation REQ_APP_PHP_USER_SHARE_EQUIPMENT_LIST

@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_SHARE_EQUIPMENT_LIST

@implementation RESP_APP_PHP_USER_SHARE_EQUIPMENT_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, EquipmentList );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_SHARE_EQUIPMENT_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_SHARE_EQUIPMENT_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/share_equipment_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_SHARE_EQUIPMENT_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/share_to_equipment_list

#pragma mark - REQ_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST

@implementation REQ_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST

@synthesize mac_id = _mac_id;
@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST

@implementation RESP_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/share_to_equipment_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/sheng

#pragma mark - RESP_APP_PHP_USER_SHENG

@implementation RESP_APP_PHP_USER_SHENG

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, Provi );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_SHENG

@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/sheng"];
		self.HTTP_GET( requestURI );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_SHENG objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/shi

#pragma mark - REQ_APP_PHP_USER_SHI

@implementation REQ_APP_PHP_USER_SHI

@synthesize sheng_id = _sheng_id;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_SHI

@implementation RESP_APP_PHP_USER_SHI

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, City );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_SHI

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_SHI alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/shi"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_SHI objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/user_content

#pragma mark - REQ_APP_PHP_USER_USER_CONTENT

@implementation REQ_APP_PHP_USER_USER_CONTENT

@synthesize content = _content;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_USER_CONTENT

@implementation RESP_APP_PHP_USER_USER_CONTENT

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_USER_CONTENT

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_USER_CONTENT alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/user_content"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_USER_CONTENT objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/user_image

#pragma mark - REQ_APP_PHP_USER_USER_IMAGE

@implementation REQ_APP_PHP_USER_USER_IMAGE

@synthesize image = _image;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_USER_IMAGE

@implementation RESP_APP_PHP_USER_USER_IMAGE

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_USER_IMAGE

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_USER_IMAGE alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/user_image"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_USER_IMAGE objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/user_info

#pragma mark - REQ_APP_PHP_USER_USER_INFO

@implementation REQ_APP_PHP_USER_USER_INFO

@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_USER_INFO

@implementation RESP_APP_PHP_USER_USER_INFO

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_USER_INFO

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_USER_INFO alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/user_info"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_USER_INFO objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/user_nike

#pragma mark - REQ_APP_PHP_USER_USER_NIKE

@implementation REQ_APP_PHP_USER_USER_NIKE

@synthesize nike = _nike;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_USER_NIKE

@implementation RESP_APP_PHP_USER_USER_NIKE

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_USER_NIKE

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_USER_NIKE alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/user_nike"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_USER_NIKE objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/works_add

#pragma mark - REQ_APP_PHP_USER_WORKS_ADD

@implementation REQ_APP_PHP_USER_WORKS_ADD

@synthesize classs = _classs;
@synthesize coll_nums = _coll_nums;
@synthesize coll_price = _coll_price;
@synthesize content = _content;
@synthesize image = _image;
@synthesize labels = _labels;
@synthesize open_images = _open_images;
@synthesize open_nums = _open_nums;
@synthesize open_price = _open_price;
@synthesize plates = _plates;
@synthesize price_open = _price_open;
@synthesize sales_status = _sales_status;
@synthesize secrecy = _secrecy;
@synthesize theme = _theme;
@synthesize title = _title;
@synthesize uid = _uid;
@synthesize years = _years;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_WORKS_ADD

@implementation RESP_APP_PHP_USER_WORKS_ADD

@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_WORKS_ADD

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_WORKS_ADD alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/works_add"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_WORKS_ADD objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/User/works_list

#pragma mark - REQ_APP_PHP_USER_WORKS_LIST

@implementation REQ_APP_PHP_USER_WORKS_LIST

@synthesize page = _page;
@synthesize pagecount = _pagecount;
@synthesize type = _type;
@synthesize uid = _uid;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_USER_WORKS_LIST

@implementation RESP_APP_PHP_USER_WORKS_LIST

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

CONVERT_PROPERTY_CLASS( info, HomeIndex );

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_USER_WORKS_LIST

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_USER_WORKS_LIST alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/User/works_list"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_USER_WORKS_LIST objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - GET /app.php/Verify/index

#pragma mark - REQ_APP_PHP_VERIFY_INDEX

@implementation REQ_APP_PHP_VERIFY_INDEX

@synthesize tel = _tel;
@synthesize type = _type;

- (BOOL)validate
{
	return YES;
}

@end

#pragma mark - RESP_APP_PHP_VERIFY_INDEX

@implementation RESP_APP_PHP_VERIFY_INDEX

@synthesize info = _info;
@synthesize msg = _msg;
@synthesize result = _result;

- (BOOL)validate
{
	return YES;
}

@end

@implementation API_APP_PHP_VERIFY_INDEX

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.req = [[[REQ_APP_PHP_VERIFY_INDEX alloc] init] autorelease];
		self.resp = nil;
	}
	return self;
}

- (void)dealloc
{
	self.req = nil;
	self.resp = nil;
	[super dealloc];
}

- (void)routine
{
	if ( self.sending )
	{
		if ( nil == self.req || NO == [self.req validate] )
		{
			self.failed = YES;
			return;
		}

		NSString * requestURI = [[ServerConfig sharedInstance].url stringByAppendingString:@"/app.php/Verify/index"];
		self.HTTP_GET( requestURI ).PARAM( [self.req objectToDictionary] );
	}
	else if ( self.succeed )
	{
		NSObject * result = self.responseJSON;

		if ( result && [result isKindOfClass:[NSDictionary class]] )
		{
			self.resp = [RESP_APP_PHP_VERIFY_INDEX objectFromDictionary:(NSDictionary *)result];
		}

		if ( nil == self.resp || NO == [self.resp validate] )
		{
			self.failed = YES;
			return;
		}
	}
	else if ( self.failed )
	{
		// TODO:
	}
	else if ( self.cancelled )
	{
		// TODO:
	}
}
@end

#pragma mark - config

@implementation ServerConfig

DEF_SINGLETON( ServerConfig )

DEF_INT( CONFIG_DEVELOPMENT,	0 )
DEF_INT( CONFIG_TEST,			1 )
DEF_INT( CONFIG_PRODUCTION,	2 )

@synthesize config = _config;
@dynamic url;
@dynamic testUrl;
@dynamic productionUrl;
@dynamic developmentUrl;

- (NSString *)url
{
	NSString * host = nil;

	if ( self.CONFIG_DEVELOPMENT == self.config )
	{
		host = self.developmentUrl;
	}
	else if ( self.CONFIG_TEST == self.config )
	{
		host = self.testUrl;
	}
	else
	{
		host = self.productionUrl;
	}

	if ( NO == [host hasPrefix:@"http://"] && NO == [host hasPrefix:@"https://"] )
	{
		host = [@"http://" stringByAppendingString:host];
	}

	return host;
}

- (NSString *)developmentUrl
{
	return @"http://boe.ccifc.cn/";
}

- (NSString *)testUrl
{
	return @"";
}

- (NSString *)productionUrl
{
	return @"";
}

@end

