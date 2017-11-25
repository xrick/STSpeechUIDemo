//
//  CIJsonProcessor.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 22/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CI_ENUM.h"
#import "ContentItem.h"
@interface CIJsonProcessor : NSObject
{
    
}

//+(NSMutableDictionary*)parseListAvailableJSON:(NSString*)rawJsonString;
+(NSString*)callListSeatAvailableAPI:(NSData*)argData;
//+(NSData*)prepareArgForListSeatAvailableAPI:(NSString*)rawArgString;
//
//+(NSData*)prepareArgForLoginAPI:(NSString*)rawArgString;
//+(NSString*)callLoginAPI:(NSData*)argData;
//+(NSMutableDictionary*)parseLoginJSON:(NSString*)rawJsonString;

+(NSData*)generatCallApiJSON : (NSDictionary*)userInput withFlag:(CI_Command_Type)flowFlag;//(NSDictionary*)realValueDict;
+(NSDictionary*)performAPICall:(NSData*)paraData;
+(NSDictionary*)parseRawJsonData:(NSData*)rawJsonData;
@end

#define WebApiURL @"http://192.168.1.184:8081/api/query"

#define CALL_API_TEMPLATE @"{\"Command\":\"%@\",\"RequestArgument\":{\"Platform\":\"ios\",\"Question\":\"%@\",\"SupportedContentType\":[0],\"SourceLanguage\":\"%@\"},\"UserArgument\":{\"UserId\":\"%@\",\"Password\":\"%@\",\"OfficeId\":\"%@\"},\"RedisArgument\":{\"RedisDataKey\":\"%@\",\"RedisDataValue\":\"%@\"}}" // 8 %@
/*
 @"{\"Command\":\"@command\",\"RequestArgument\":{\"Platform\":\"iOS\",\"Question\":\"@question\",\"SupportedContentType\":[0],\"SourceLanguage\":\"@language\"},\"UserArgument\":{\"UserId\":\"@uid\",\"Password\":\"@pwd\",\"OfficeId\":\"@officeid\"},\"RedisArgument\":{\"RedisDataKey\":\"##rediskey##\",\"RedisDataValue\":\"##redisvalue##\"}}"
 */
#define ArgDict_String_Template @"@\"%@\",@\"Command\",@\"%@\",@\"Question\",@\"%@\",@\"SourceLanguage\",@\"%@\",@\"UserId\",@\"%@\",@\"Password\",@\"%@\",@\"OfficeId\",@\"%@\",@\"RedisDataKey\",@\"%@\",@\"RedisDataValue\""
