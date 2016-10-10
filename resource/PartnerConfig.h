//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

/**
 *  @Author jxd, 15-01-16 13:01:01
 *
 *  需要替换的内容开始
 */


//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088211034504655"

//收款支付宝账号
#define SellerID  @"66280486@qq.com"

//应用注册scheme,在xxx-Info.plist定义URL types
#define AppScheme @"zpfproject"

//回调url，问后台要
#define NotifyURL @"http://wwww.xxx.com/api.php/Alipay/index"


//商户私钥，不用改
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMFain+4I4rA8ZvFmQo6l5BYnuDcWSlaWqHy5gpgS515GrLFqx1vvn0dbcSkeqs14du1fMJQ/6puK019MeiWYnfeCHCFpuGJXxS2oyCY5USrOQbbR8Qydm15MC9oWRzEFQCT2D1vkMRfEsdEoIDQSSGX1mR+HLInt/pXUvYUr9kVAgMBAAECgYEArGLK5IAJwCWxw43ymjoO8zTvwc7y93mFIKptCoc8I1Pbx9OQchg0n1vjh9SVQZwymC5A4wZQS2UZ2mZqXtHlSyfdWvBNdytYvL0JDMF3LD9RZgBEo65bhJACOkE0/GblRM2dPswolv2w+lIHu6Qn1wVTH/SAvWUZRfK1EqqrWmkCQQDt//z6nVT7tYtRyAZ/mF5AY2dkqyZHMLaqpYdayg07zr7vOXG6EcUjPAJpGvmXXnFlWSrvDJW0+a3Pqs+NrObXAkEAz/ojcgtmd6shkRBw4a8xEF7mr/gXERGrOYVhVRLsHURJQP9yFmVVw26QVrTQEQXWprmGCmcN5ykelmrZlXy98wJAc7gIz+3ZmT1PDSd9iWKTSSlL51WUGf8kgdpT8p/VSWQfz/8VPcxQFu6hmWslOiUQa5+sUWjEDadsjFFX82HDJwJADTYDeGQW/zUErdVQhlV9lV+h4b2toWzw5nd9hkzsaLOEv7c6RQfs2bw1OPzFVr97Mh4I0LJZJLzs73scFS3WVwJAc9jA4eYYc7Fs14juRBF79SwFNhwxtgJdoIo4bX9b9zI8rIrLD4xj5pjYQjK1QLdhYSTU7SYTXMgtFy/Q56zTvQ=="


//支付宝公钥，不用改
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"


#endif
