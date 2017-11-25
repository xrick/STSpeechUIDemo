//
//  CIJsonProcessor.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 22/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "CIJsonProcessor.h"

@implementation CIJsonProcessor


+(NSString*)callListSeatAvailableAPI:(NSString*)argData
{
    return nil;
}

+(NSDictionary*)performAPICall:(NSData*)paraData
{

    NSDictionary * _retDict = [self parseRawJsonData:[[self __callWebAPI:paraData] dataUsingEncoding:NSUTF16StringEncoding]];
//
//    NSLog(@"the parsed first level data is _retDict : %@",_retDict);
//    NSArray* arguments = (NSArray*)[_retDict objectForKey:@"Argument"];
//    //do data process
//    for(int idx  = 0 ; idx < arguments.count ; idx++){
//        if([[arguments[idx] objectForKey:@"Type"] isEqualToString:@"DynamicObject"]){
//            NSLog(@"The payloadinfo is %@",[arguments[idx] objectForKey:@"PayloadInfo"]);
//            return [self __processDynamicObject:[arguments[idx] objectForKey:@"Payload"] withPayloadInfo:[arguments[idx] objectForKey:@"PayloadInfo"]];
//        }
//        else if([[arguments[idx] objectForKey:@"Type"] isEqualToString:@"Text"]){
//            retMutDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Text",@"Type",[arguments[idx] objectForKey:@"Payload"],@"Payload", nil];
//            return retMutDict;
//        }
//    }
    return _retDict;
}

#pragma mark ---process dynamic object ---
+(NSMutableDictionary*)__processDynamicObject:(NSDictionary*)payload withPayloadInfo:(NSString*)info
{
    if([info isEqualToString:@"ListSeatAvailableArray"]){
        return [self __processListSeatAvailableArrayInfo:payload];
    }
    else if([info isEqualToString:@"TicketsTemplate"]){
        return [self __processTicketsTemplateInfo:payload];
    }
    else if([info isEqualToString:@"TicketChangeConfirm"]){
        return [self __processTicketChangeConfirmInfo:payload];
    }
    else if([info isEqualToString:@"BoardingTerminal"]){
        return [self __processBoardingTerminalInfo:payload];
    }
    else if([info isEqualToString:@"QuickReply"]){
        return [self __processQuickReplyInfo:payload];
    }
    else
    {
        return nil;
    }
    return nil;
}

+(NSMutableDictionary*)__processListSeatAvailableArrayInfo:(NSDictionary*)payload
{
    return nil;
}

+(NSMutableDictionary*)__processTicketsTemplateInfo:(NSDictionary*)payload
{
    return nil;
}

+(NSMutableDictionary*)__processTicketChangeConfirmInfo:(NSDictionary*)payload
{
    return nil;
}

+(NSMutableDictionary*)__processBoardingTerminalInfo:(NSDictionary*)payload
{
    return nil;
}

+(NSMutableDictionary*)__processQuickReplyInfo:(NSDictionary*)payload
{
    return nil;
}

#pragma mark ---process dynamic object ---

+(NSString*)__callWebAPI:(NSData*)argData
{
    NSError * error = nil;
    NSURLResponse *response;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:WebApiURL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:argData];
    // Send the request and get the response
    NSData* retData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error != nil){
        return [NSString stringWithFormat:@"The error description is : %@ and fail reason is : %@",error.localizedDescription,error.localizedFailureReason];
    }
    NSString *result = [[NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
    result = [result stringByReplacingOccurrencesOfString:@"\\\\" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
    result = [result stringByReplacingOccurrencesOfString:@":\"{" withString:@":{"];
    result = [result stringByReplacingOccurrencesOfString:@"]\"," withString:@"],"];
    result = [result stringByReplacingOccurrencesOfString:@"}\"," withString:@"},"];
    return result;
}

+(NSData*)generatCallApiJSON : (NSDictionary*)userInput withFlag:(CI_Command_Type)flowFlag
{
    /*
     SaveDataToRedisAndQuery    = 1,
     Query,
     GetUserInfo,
     NameList
     */
    NSString * processedStr;
//    if(flowFlag == 2)
//    {
        processedStr = [NSString stringWithFormat:CALL_API_TEMPLATE,[userInput objectForKey:@"Command"],[userInput objectForKey:@"Question"],[userInput objectForKey:@"SourceLanguage"],[userInput objectForKey:@"UserId"],[userInput objectForKey:@"Password"],[userInput objectForKey:@"OfficeId"],[userInput objectForKey:@"RedisDataKey"],[userInput objectForKey:@"RedisDataValue"]];
        NSLog(@"The processedStr is : %@",processedStr);
        NSData* data = [processedStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *jsonAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"jsonAsString is %@",jsonAsString);
        return data;
//    }
//    return nil;
}

#pragma mark -- parse return data

+(NSDictionary*)parseRawJsonData:(NSData*)rawJsonData
{
    //NSData* jsonData = [rawJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id parsedObj = [NSJSONSerialization
                    JSONObjectWithData:rawJsonData
                    options:0
                    error:&error];
    NSLog(@"parseObject is class %@",[parsedObj class]);
    NSDictionary * resJsonDict = parsedObj;
    NSLog(@"dict is %@",resJsonDict);
    return resJsonDict;
}

#pragma mark ----- Test Data -----
+(NSString*)testBookingInfoAPI
{
    NSError * error = nil;
    NSMutableDictionary * requestArguments = [[NSMutableDictionary alloc]init];
    [requestArguments setObject:@"ios" forKey:@"Platform"];
    [requestArguments setObject:@"查訂位" forKey:@"Question"];
    //NSArray * ary = [[NSArray alloc]initWithObjects:@1, nil];
    [requestArguments setObject:[[NSArray alloc]initWithObjects:@1, nil] forKey:@"SupportedContentType"];
    [requestArguments setObject:@"0" forKey:@"SourceLanguage"];
    
    NSMutableDictionary * userArguments = [[NSMutableDictionary alloc]init];
    [userArguments setObject:@"999999" forKey:@"UserId"];
    [userArguments setObject:@"999999" forKey:@"Password"];
    [userArguments setObject:@"TPECI08CF" forKey:@"OfficeId"];
    
    NSMutableDictionary * redisArguments = [[NSMutableDictionary alloc]init];
    [requestArguments setObject:@"testKey" forKey:@"RedisDataKey"];
    [requestArguments setObject:@"testValue" forKey:@"RedisDataValue"];
    
    //set root dictionary
    NSMutableDictionary * rootDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      @"SaveDataToRedisAndQuery", @"Command",
                                      requestArguments, @"RequestArgument",
                                      userArguments,@"UserArgument",
                                      redisArguments,@"RedisArgument",
                                      nil];
    //2. Convert postDict to NSData and create your request
    //NSError *error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:rootDict options:kNilOptions error:&error];
    //NSString* sendString;
    NSString *sendString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"Ths jsonData to send is %@",sendString);
    NSURLResponse *response;
    NSData *localData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:WebApiURL]];
    [request setHTTPMethod:@"POST"];
    //3. And finally, send your request to the server:
    //    if (error == nil)
    //    {
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    // Send the request and get the response
    localData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //    }else{
    //        NSLog(@"Error occured : %@",error);
    //    }
    NSString *result = [[NSString alloc] initWithData:localData encoding:NSUTF8StringEncoding];
    return result;
}

#pragma mark ----- End of Test Data -------

@end
