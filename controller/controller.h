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
// date:   2016-10-20 17:55:31 +0000
//

#import "Bee.h"

#pragma mark - models

@class AddressInfo;
@class Area;
@class ArtistInfo;
@class ArtistWorkList;
@class BalanceInfo;
@class BannerInfo;
@class CapitalFlow;
@class City;
@class ClassList;
@class CommentInfo;
@class DetailsInfo;
@class EquipmentList;
@class FindIndex;
@class GuessInfo;
@class HomeIndex;
@class OrderInfo;
@class Provi;
@class RankingList;
@class ReCommentInfo;
@class ShareToEquipObj;
@class SpecialInfo;
@class ThemeList;
@class UserInfo;
@class VerifyInfo;
@class VerifyIs;
@class all_listObje;
@class my_listObje;

@interface AddressInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			a_id;
@property (nonatomic, retain) NSString *			address;
@property (nonatomic, retain) NSString *			home;
@property (nonatomic, retain) NSString *			name;
@property (nonatomic, retain) NSString *			qu;
@property (nonatomic, retain) NSString *			qu_id;
@property (nonatomic, retain) NSString *			sheng;
@property (nonatomic, retain) NSString *			sheng_id;
@property (nonatomic, retain) NSString *			shi;
@property (nonatomic, retain) NSString *			shi_id;
@property (nonatomic, retain) NSString *			tel;
@end

@interface Area : BeeActiveObject
@property (nonatomic, retain) NSString *			qu_id;
@property (nonatomic, retain) NSString *			title;
@end

@interface ArtistInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			collection;
@property (nonatomic, retain) NSString *			collection_num;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			fans;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSArray *				products_list;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			works_num;
@end

@interface ArtistWorkList : BeeActiveObject
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			p_id;
@end

@interface BalanceInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			balance;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			uid;
@end

@interface BannerInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			banner_id;
@property (nonatomic, retain) NSString *			banner_image;
@property (nonatomic, retain) NSString *			banner_title;
@property (nonatomic, retain) NSString *			banner_url;
@property (nonatomic, retain) NSString *			types;
@end

@interface CapitalFlow : BeeActiveObject
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			o_id;
@property (nonatomic, retain) NSString *			order_num;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			price;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			type;
@property (nonatomic, retain) NSString *			types;
@end

@interface City : BeeActiveObject
@property (nonatomic, retain) NSString *			shi_id;
@property (nonatomic, retain) NSString *			title;
@end

@interface ClassList : BeeActiveObject
@property (nonatomic, retain) NSString *			c_id;
@property (nonatomic, retain) NSString *			title;
@end

@interface CommentInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			c_id;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSArray *				r_comment_list;
@property (nonatomic, retain) NSString *			u_id;
@end

@interface DetailsInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			athena;
@property (nonatomic, retain) NSString *			classs;
@property (nonatomic, retain) NSString *			coll_nums;
@property (nonatomic, retain) NSString *			collection;
@property (nonatomic, retain) NSArray *				comment_list;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			electronic_nums;
@property (nonatomic, retain) NSString *			electronic_price;
@property (nonatomic, retain) NSString *			electronics_nume;
@property (nonatomic, retain) NSArray *				guess_list;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			image_url;
@property (nonatomic, retain) NSString *			material_num;
@property (nonatomic, retain) NSString *			material_nums;
@property (nonatomic, retain) NSString *			material_price;
@property (nonatomic, retain) NSString *			material_sum;
@property (nonatomic, retain) NSString *			open_images;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			pay_type;
@property (nonatomic, retain) NSString *			pictureFrameTypeOne;
@property (nonatomic, retain) NSString *			pictureFrameTypeTwo;
@property (nonatomic, retain) NSString *			plates;
@property (nonatomic, retain) NSString *			price_open;
@property (nonatomic, retain) NSString *			reward_nums;
@property (nonatomic, retain) NSString *			theme;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			u_image;
@property (nonatomic, retain) NSString *			u_name;
@property (nonatomic, retain) NSString *			works_nums;
@property (nonatomic, retain) NSString *			years;
@property (nonatomic, retain) NSString *			zambia;
@property (nonatomic, retain) NSString *			zambia_nums;
@end

@interface EquipmentList : BeeActiveObject
@property (nonatomic, retain) NSString *			authoris;
@property (nonatomic, retain) NSString *			e_id;
@property (nonatomic, retain) NSString *			e_time;
@property (nonatomic, retain) NSString *			l_time;
@property (nonatomic, retain) NSString *			mac_id;
@property (nonatomic, retain) NSString *			push_type;
@property (nonatomic, retain) NSString *			s_time;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			uid;
@end

@interface FindIndex : BeeActiveObject
@property (nonatomic, retain) NSString *			classs;
@property (nonatomic, retain) NSString *			coll_nums;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			follow_nums;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			image_url;
@property (nonatomic, retain) NSString *			material_nums;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			plates;
@property (nonatomic, retain) NSString *			theme;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			u_image;
@property (nonatomic, retain) NSString *			u_name;
@property (nonatomic, retain) NSString *			years;
@property (nonatomic, retain) NSString *			zambia_nums;
@end

@interface GuessInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			p_id;
@end

@interface HomeIndex : BeeActiveObject
@property (nonatomic, retain) NSString *			classs;
@property (nonatomic, retain) NSString *			coll_nums;
@property (nonatomic, retain) NSString *			collection;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			p_id1;
@property (nonatomic, retain) NSString *			pay_type;
@property (nonatomic, retain) NSString *			plates;
@property (nonatomic, retain) NSString *			theme;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			u_image;
@property (nonatomic, retain) NSString *			u_name;
@property (nonatomic, retain) NSString *			years;
@end

@interface OrderInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			balance;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			image_url;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			o_id;
@property (nonatomic, retain) NSString *			order_num;
@property (nonatomic, retain) NSString *			order_type;
@property (nonatomic, retain) NSString *			orders;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			price;
@property (nonatomic, retain) NSString *			s_address;
@property (nonatomic, retain) NSString *			s_name;
@property (nonatomic, retain) NSString *			s_tel;
@property (nonatomic, retain) NSString *			state;
@property (nonatomic, retain) NSString *			state_order;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			types;
@property (nonatomic, retain) NSString *			u_id;
@end

@interface Provi : BeeActiveObject
@property (nonatomic, retain) NSString *			sheng_id;
@property (nonatomic, retain) NSString *			title;
@end

@interface RankingList : BeeActiveObject
@property (nonatomic, retain) NSArray *				collection_list;
@property (nonatomic, retain) NSArray *				follow_list;
@property (nonatomic, retain) NSArray *				purchase_list;
@end

@interface ReCommentInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			c_id;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			u_id;
@end

@interface ShareToEquipObj : BeeActiveObject
@property (nonatomic, retain) NSArray *				all_list;
@property (nonatomic, retain) NSArray *				my_list;
@end

@interface SpecialInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			created_at;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			read_num;
@property (nonatomic, retain) NSString *			s_id;
@property (nonatomic, retain) NSString *			time;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			u_image;
@end

@interface ThemeList : BeeActiveObject
@property (nonatomic, retain) NSString *			c_id;
@property (nonatomic, retain) NSString *			title;
@end

@interface UserInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			collection_num;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			fans;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			tel;
@property (nonatomic, retain) NSString *			token;
@property (nonatomic, retain) NSString *			uid;
@end

@interface VerifyInfo : BeeActiveObject
@property (nonatomic, retain) NSString *			time;
@property (nonatomic, retain) NSString *			user;
@property (nonatomic, retain) NSString *			verify;
@end

@interface VerifyIs : BeeActiveObject
@property (nonatomic, retain) NSString *			cation;
@end

@interface all_listObje : BeeActiveObject
@property (nonatomic, retain) NSString *			authoris;
@property (nonatomic, retain) NSString *			e_id;
@property (nonatomic, retain) NSString *			e_time;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			l_time;
@property (nonatomic, retain) NSString *			mac_id;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			push_type;
@property (nonatomic, retain) NSString *			s_time;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			uid;
@end

@interface my_listObje : BeeActiveObject
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			uid;
@end

#pragma mark - controllers

#pragma mark - GET /app.php/Finds/activity_list

@interface REQ_APP_PHP_FINDS_ACTIVITY_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@end

@interface RESP_APP_PHP_FINDS_ACTIVITY_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_ACTIVITY_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_ACTIVITY_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_ACTIVITY_LIST *	resp;
@end

#pragma mark - GET /app.php/Finds/activity_read

@interface REQ_APP_PHP_FINDS_ACTIVITY_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			s_id;
@end

@interface RESP_APP_PHP_FINDS_ACTIVITY_READ : BeeActiveObject
@property (nonatomic, retain) SpecialInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_ACTIVITY_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_ACTIVITY_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_ACTIVITY_READ *	resp;
@end

#pragma mark - GET /app.php/Finds/artist

@interface REQ_APP_PHP_FINDS_ARTIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_FINDS_ARTIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_ARTIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_ARTIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_ARTIST *	resp;
@end

#pragma mark - GET /app.php/Finds/artist_read

@interface REQ_APP_PHP_FINDS_ARTIST_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_FINDS_ARTIST_READ : BeeActiveObject
@property (nonatomic, retain) ArtistInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_ARTIST_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_ARTIST_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_ARTIST_READ *	resp;
@end

#pragma mark - GET /app.php/Finds/artist_works_list

@interface REQ_APP_PHP_FINDS_ARTIST_WORKS_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			u_id;
@end

@interface RESP_APP_PHP_FINDS_ARTIST_WORKS_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_ARTIST_WORKS_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_ARTIST_WORKS_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_ARTIST_WORKS_LIST *	resp;
@end

#pragma mark - GET /app.php/Finds/collection_list

@interface REQ_APP_PHP_FINDS_COLLECTION_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_FINDS_COLLECTION_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_COLLECTION_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_COLLECTION_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_COLLECTION_LIST *	resp;
@end

#pragma mark - GET /app.php/Finds/fanss

@interface REQ_APP_PHP_FINDS_FANSS : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_FINDS_FANSS : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_FANSS : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_FANSS *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_FANSS *	resp;
@end

#pragma mark - GET /app.php/Finds/index

@interface REQ_APP_PHP_FINDS_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			artist;
@property (nonatomic, retain) NSString *			classs;
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			plates;
@end

@interface RESP_APP_PHP_FINDS_INDEX : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_INDEX : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_INDEX *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_INDEX *	resp;
@end

#pragma mark - GET /app.php/Finds/ranking_list

@interface RESP_APP_PHP_FINDS_RANKING_LIST : BeeActiveObject
@property (nonatomic, retain) RankingList *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_RANKING_LIST : BeeAPI
@property (nonatomic, retain) RESP_APP_PHP_FINDS_RANKING_LIST *	resp;
@end

#pragma mark - GET /app.php/Finds/special

@interface REQ_APP_PHP_FINDS_SPECIAL : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@end

@interface RESP_APP_PHP_FINDS_SPECIAL : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_SPECIAL : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_SPECIAL *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_SPECIAL *	resp;
@end

#pragma mark - GET /app.php/Finds/special_read

@interface REQ_APP_PHP_FINDS_SPECIAL_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			s_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_FINDS_SPECIAL_READ : BeeActiveObject
@property (nonatomic, retain) SpecialInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_FINDS_SPECIAL_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_FINDS_SPECIAL_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_FINDS_SPECIAL_READ *	resp;
@end

#pragma mark - GET /app.php/Index/balance

@interface REQ_APP_PHP_INDEX_BALANCE : BeeActiveObject
@property (nonatomic, retain) NSString *			a_id;
@property (nonatomic, retain) NSString *			balance;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			price;
@property (nonatomic, retain) NSString *			type;
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_BALANCE : BeeActiveObject
@property (nonatomic, retain) OrderInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_BALANCE : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_BALANCE *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_BALANCE *	resp;
@end

#pragma mark - GET /app.php/Index/banner

@interface RESP_APP_PHP_INDEX_BANNER : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_BANNER : BeeAPI
@property (nonatomic, retain) RESP_APP_PHP_INDEX_BANNER *	resp;
@end

#pragma mark - GET /app.php/Index/class_list

@interface RESP_APP_PHP_INDEX_CLASS_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_CLASS_LIST : BeeAPI
@property (nonatomic, retain) RESP_APP_PHP_INDEX_CLASS_LIST *	resp;
@end

#pragma mark - GET /app.php/Index/collection_add

@interface REQ_APP_PHP_INDEX_COLLECTION_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_COLLECTION_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_COLLECTION_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_COLLECTION_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_COLLECTION_ADD *	resp;
@end

#pragma mark - GET /app.php/Index/collection_del

@interface REQ_APP_PHP_INDEX_COLLECTION_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			u_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_COLLECTION_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_COLLECTION_DEL : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_COLLECTION_DEL *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_COLLECTION_DEL *	resp;
@end

#pragma mark - GET /app.php/Index/comment_add

@interface REQ_APP_PHP_INDEX_COMMENT_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_COMMENT_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_COMMENT_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_COMMENT_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_COMMENT_ADD *	resp;
@end

#pragma mark - GET /app.php/Index/gz_index

@interface REQ_APP_PHP_INDEX_GZ_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_GZ_INDEX : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_GZ_INDEX : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_GZ_INDEX *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_GZ_INDEX *	resp;
@end

#pragma mark - GET /app.php/Index/index

@interface REQ_APP_PHP_INDEX_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_INDEX : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_INDEX : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_INDEX *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_INDEX *	resp;
@end

#pragma mark - GET /app.php/Index/r_comm_add

@interface REQ_APP_PHP_INDEX_R_COMM_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			comm_id;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_R_COMM_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_R_COMM_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_R_COMM_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_R_COMM_ADD *	resp;
@end

#pragma mark - GET /app.php/Index/read

@interface REQ_APP_PHP_INDEX_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_INDEX_READ : BeeActiveObject
@property (nonatomic, retain) DetailsInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_INDEX_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_INDEX_READ *	resp;
@end

#pragma mark - GET /app.php/Index/theme_list

@interface RESP_APP_PHP_INDEX_THEME_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_INDEX_THEME_LIST : BeeAPI
@property (nonatomic, retain) RESP_APP_PHP_INDEX_THEME_LIST *	resp;
@end

#pragma mark - GET /app.php/Jpush/index

@interface REQ_APP_PHP_JPUSH_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			e_id;
@property (nonatomic, retain) NSString *			p_id;
@property (nonatomic, retain) NSString *			pay_type;
@property (nonatomic, retain) NSString *			type;
@end

@interface RESP_APP_PHP_JPUSH_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_JPUSH_INDEX : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_JPUSH_INDEX *	req;
@property (nonatomic, retain) RESP_APP_PHP_JPUSH_INDEX *	resp;
@end

#pragma mark - GET /app.php/User/address_add

@interface REQ_APP_PHP_USER_ADDRESS_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			a_id;
@property (nonatomic, retain) NSString *			address;
@property (nonatomic, retain) NSString *			city;
@property (nonatomic, retain) NSString *			home;
@property (nonatomic, retain) NSString *			name;
@property (nonatomic, retain) NSString *			tel;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_ADDRESS_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_ADDRESS_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_ADDRESS_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_ADDRESS_ADD *	resp;
@end

#pragma mark - GET /app.php/User/address_del

@interface REQ_APP_PHP_USER_ADDRESS_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			a_id;
@end

@interface RESP_APP_PHP_USER_ADDRESS_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_ADDRESS_DEL : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_ADDRESS_DEL *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_ADDRESS_DEL *	resp;
@end

#pragma mark - GET /app.php/User/address_list

@interface REQ_APP_PHP_USER_ADDRESS_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_ADDRESS_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_ADDRESS_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_ADDRESS_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_ADDRESS_LIST *	resp;
@end

#pragma mark - GET /app.php/User/balance

@interface REQ_APP_PHP_USER_BALANCE : BeeActiveObject
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_BALANCE : BeeActiveObject
@property (nonatomic, retain) BalanceInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_BALANCE : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_BALANCE *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_BALANCE *	resp;
@end

#pragma mark - GET /app.php/User/capital_flow

@interface REQ_APP_PHP_USER_CAPITAL_FLOW : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_CAPITAL_FLOW : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_CAPITAL_FLOW : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_CAPITAL_FLOW *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_CAPITAL_FLOW *	resp;
@end

#pragma mark - GET /app.php/User/codecation

@interface REQ_APP_PHP_USER_CODECATION : BeeActiveObject
@property (nonatomic, retain) NSString *			code;
@property (nonatomic, retain) NSString *			tel;
@end

@interface RESP_APP_PHP_USER_CODECATION : BeeActiveObject
@property (nonatomic, retain) VerifyIs *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_CODECATION : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_CODECATION *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_CODECATION *	resp;
@end

#pragma mark - GET /app.php/User/equipment_add

@interface REQ_APP_PHP_USER_EQUIPMENT_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			mac_id;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_EQUIPMENT_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_EQUIPMENT_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_EQUIPMENT_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_EQUIPMENT_ADD *	resp;
@end

#pragma mark - GET /app.php/User/equipment_del

@interface REQ_APP_PHP_USER_EQUIPMENT_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			mac_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_EQUIPMENT_DEL : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_EQUIPMENT_DEL : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_EQUIPMENT_DEL *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_EQUIPMENT_DEL *	resp;
@end

#pragma mark - GET /app.php/User/equipment_info

@interface REQ_APP_PHP_USER_EQUIPMENT_INFO : BeeActiveObject
@property (nonatomic, retain) NSString *			e_id;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_EQUIPMENT_INFO : BeeActiveObject
@property (nonatomic, retain) EquipmentList *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_EQUIPMENT_INFO : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_EQUIPMENT_INFO *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_EQUIPMENT_INFO *	resp;
@end

#pragma mark - GET /app.php/User/equipment_list

@interface REQ_APP_PHP_USER_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_EQUIPMENT_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_EQUIPMENT_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_EQUIPMENT_LIST *	resp;
@end

#pragma mark - GET /app.php/User/login

@interface REQ_APP_PHP_USER_LOGIN : BeeActiveObject
@property (nonatomic, retain) NSString *			pass;
@property (nonatomic, retain) NSString *			tel;
@end

@interface RESP_APP_PHP_USER_LOGIN : BeeActiveObject
@property (nonatomic, retain) UserInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_LOGIN : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_LOGIN *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_LOGIN *	resp;
@end

#pragma mark - GET /app.php/User/password

@interface REQ_APP_PHP_USER_PASSWORD : BeeActiveObject
@property (nonatomic, retain) NSString *			code;
@property (nonatomic, retain) NSString *			newpass;
@property (nonatomic, retain) NSString *			tel;
@end

@interface RESP_APP_PHP_USER_PASSWORD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_PASSWORD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_PASSWORD *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_PASSWORD *	resp;
@end

#pragma mark - GET /app.php/User/pay_list

@interface REQ_APP_PHP_USER_PAY_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_PAY_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_PAY_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_PAY_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_PAY_LIST *	resp;
@end

#pragma mark - GET /app.php/User/pay_read

@interface REQ_APP_PHP_USER_PAY_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			o_id;
@end

@interface RESP_APP_PHP_USER_PAY_READ : BeeActiveObject
@property (nonatomic, retain) OrderInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_PAY_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_PAY_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_PAY_READ *	resp;
@end

#pragma mark - GET /app.php/User/post_comd

@interface REQ_APP_PHP_USER_POST_COMD : BeeActiveObject
@property (nonatomic, retain) NSString *			o_id;
@end

@interface RESP_APP_PHP_USER_POST_COMD : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_POST_COMD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_POST_COMD *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_POST_COMD *	resp;
@end

#pragma mark - GET /app.php/User/pre_list

@interface REQ_APP_PHP_USER_PRE_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_PRE_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_PRE_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_PRE_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_PRE_LIST *	resp;
@end

#pragma mark - GET /app.php/User/pre_read

@interface REQ_APP_PHP_USER_PRE_READ : BeeActiveObject
@property (nonatomic, retain) NSString *			o_id;
@end

@interface RESP_APP_PHP_USER_PRE_READ : BeeActiveObject
@property (nonatomic, retain) OrderInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_PRE_READ : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_PRE_READ *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_PRE_READ *	resp;
@end

#pragma mark - GET /app.php/User/qu

@interface REQ_APP_PHP_USER_QU : BeeActiveObject
@property (nonatomic, retain) NSString *			shi_id;
@end

@interface RESP_APP_PHP_USER_QU : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_QU : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_QU *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_QU *	resp;
@end

#pragma mark - GET /app.php/User/register

@interface REQ_APP_PHP_USER_REGISTER : BeeActiveObject
@property (nonatomic, retain) NSString *			code;
@property (nonatomic, retain) NSString *			pass;
@property (nonatomic, retain) NSString *			tel;
@end

@interface RESP_APP_PHP_USER_REGISTER : BeeActiveObject
@property (nonatomic, retain) UserInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_REGISTER : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_REGISTER *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_REGISTER *	resp;
@end

#pragma mark - GET /app.php/User/share_equipment_list

@interface REQ_APP_PHP_USER_SHARE_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_SHARE_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_SHARE_EQUIPMENT_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_SHARE_EQUIPMENT_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_SHARE_EQUIPMENT_LIST *	resp;
@end

#pragma mark - GET /app.php/User/share_to_equipment_list

@interface REQ_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			mac_id;
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST : BeeActiveObject
@property (nonatomic, retain) ShareToEquipObj *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_SHARE_TO_EQUIPMENT_LIST *	resp;
@end

#pragma mark - GET /app.php/User/sheng

@interface RESP_APP_PHP_USER_SHENG : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_SHENG : BeeAPI
@property (nonatomic, retain) RESP_APP_PHP_USER_SHENG *	resp;
@end

#pragma mark - GET /app.php/User/shi

@interface REQ_APP_PHP_USER_SHI : BeeActiveObject
@property (nonatomic, retain) NSString *			sheng_id;
@end

@interface RESP_APP_PHP_USER_SHI : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_SHI : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_SHI *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_SHI *	resp;
@end

#pragma mark - GET /app.php/User/user_content

@interface REQ_APP_PHP_USER_USER_CONTENT : BeeActiveObject
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_USER_CONTENT : BeeActiveObject
@property (nonatomic, retain) NSString *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_USER_CONTENT : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_USER_CONTENT *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_USER_CONTENT *	resp;
@end

#pragma mark - GET /app.php/User/user_image

@interface REQ_APP_PHP_USER_USER_IMAGE : BeeActiveObject
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_USER_IMAGE : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_USER_IMAGE : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_USER_IMAGE *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_USER_IMAGE *	resp;
@end

#pragma mark - GET /app.php/User/user_info

@interface REQ_APP_PHP_USER_USER_INFO : BeeActiveObject
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_USER_INFO : BeeActiveObject
@property (nonatomic, retain) UserInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_USER_INFO : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_USER_INFO *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_USER_INFO *	resp;
@end

#pragma mark - GET /app.php/User/user_nike

@interface REQ_APP_PHP_USER_USER_NIKE : BeeActiveObject
@property (nonatomic, retain) NSString *			nike;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_USER_NIKE : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_USER_NIKE : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_USER_NIKE *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_USER_NIKE *	resp;
@end

#pragma mark - GET /app.php/User/works_add

@interface REQ_APP_PHP_USER_WORKS_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			classs;
@property (nonatomic, retain) NSString *			coll_nums;
@property (nonatomic, retain) NSString *			coll_price;
@property (nonatomic, retain) NSString *			content;
@property (nonatomic, retain) NSString *			image;
@property (nonatomic, retain) NSString *			labels;
@property (nonatomic, retain) NSString *			open_images;
@property (nonatomic, retain) NSString *			open_nums;
@property (nonatomic, retain) NSString *			open_price;
@property (nonatomic, retain) NSString *			plates;
@property (nonatomic, retain) NSString *			price_open;
@property (nonatomic, retain) NSString *			sales_status;
@property (nonatomic, retain) NSString *			secrecy;
@property (nonatomic, retain) NSString *			theme;
@property (nonatomic, retain) NSString *			title;
@property (nonatomic, retain) NSString *			uid;
@property (nonatomic, retain) NSString *			years;
@end

@interface RESP_APP_PHP_USER_WORKS_ADD : BeeActiveObject
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_WORKS_ADD : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_WORKS_ADD *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_WORKS_ADD *	resp;
@end

#pragma mark - GET /app.php/User/works_list

@interface REQ_APP_PHP_USER_WORKS_LIST : BeeActiveObject
@property (nonatomic, retain) NSString *			page;
@property (nonatomic, retain) NSString *			pagecount;
@property (nonatomic, retain) NSString *			type;
@property (nonatomic, retain) NSString *			uid;
@end

@interface RESP_APP_PHP_USER_WORKS_LIST : BeeActiveObject
@property (nonatomic, retain) NSArray *				info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_USER_WORKS_LIST : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_USER_WORKS_LIST *	req;
@property (nonatomic, retain) RESP_APP_PHP_USER_WORKS_LIST *	resp;
@end

#pragma mark - GET /app.php/Verify/index

@interface REQ_APP_PHP_VERIFY_INDEX : BeeActiveObject
@property (nonatomic, retain) NSString *			tel;
@property (nonatomic, retain) NSString *			type;
@end

@interface RESP_APP_PHP_VERIFY_INDEX : BeeActiveObject
@property (nonatomic, retain) VerifyInfo *			info;
@property (nonatomic, retain) NSString *			msg;
@property (nonatomic, retain) NSString *			result;
@end

@interface API_APP_PHP_VERIFY_INDEX : BeeAPI
@property (nonatomic, retain) REQ_APP_PHP_VERIFY_INDEX *	req;
@property (nonatomic, retain) RESP_APP_PHP_VERIFY_INDEX *	resp;
@end

#pragma mark - config

@interface ServerConfig : NSObject

AS_SINGLETON( ServerConfig )

AS_INT( CONFIG_DEVELOPMENT )
AS_INT( CONFIG_TEST )
AS_INT( CONFIG_PRODUCTION )

@property (nonatomic, assign) NSUInteger			config;

@property (nonatomic, readonly) NSString *			url;
@property (nonatomic, readonly) NSString *			testUrl;
@property (nonatomic, readonly) NSString *			productionUrl;
@property (nonatomic, readonly) NSString *			developmentUrl;

@end

