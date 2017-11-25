//
//  TestData.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 18/10/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "TestData.h"


@implementation TestData
//static NSMutableArray* _TestDataItems;

+(ContentItem*)GenTestData
{
    ContentItem * testContentItem = [[ContentItem alloc]init];
    NSMutableDictionary * _parsedDict = [self doParseJson];
    NSString * objType = [_parsedDict objectForKey:@"Type"];
    NSString * departureType = [_parsedDict objectForKey:@"DeaprtureOrReturn"];
    NSArray * listAvailableAry = [_parsedDict objectForKey:@"ListSeatAvailable"];
    testContentItem.message.attachment.type = Message_Type_Template;
    testContentItem.recipient.from = Message_From_Other;
    testContentItem.message.attachment.payload.template_type = Template_Type_CI_Query_Seat;
    [testContentItem.message.attachment.payload.elements addObjectsFromArray:listAvailableAry];
    return testContentItem;
}


+(CIResponseDataItem*)genResponsDataItem
{
    CIResponseDataItem * resItem = [[CIResponseDataItem alloc]init];
    resItem.Major = @"Major1234567";
    resItem.Minor = @"Minor345678d";
    resItem.AuthKey = @"#$%^FGjkhgshii*()";
    resItem.Command = @"TestCmd";
    resItem.IsSuccess = true;
    return resItem;
}

+(CIResponseArgumentCollection *)getnArgumentObjects
{
    CIResponseArgumentCollection *resObjects = [[CIResponseArgumentCollection alloc]init];
    return resObjects;
}

+(NSDictionary*)parseCIJsonListSeatAvailable : (NSDictionary*)rawJsonString2
{
    NSLog(@"The first element is %@",[rawJsonString2 objectForKey:@"DeaprtureOrReturn"]);
    NSString * departuorreturn = [rawJsonString2 objectForKey:@"DeaprtureOrReturn"];
    NSDictionary * listSeatAvailableDict = [rawJsonString2 objectForKey:@"ListSeatAvailable"];
    NSLog(@"the content of ListSeatAvailable is %@",listSeatAvailableDict);
    NSLog(@"the number of ListSeatAvailable is %i",(int)listSeatAvailableDict.count);
    NSLog(@"the type of listSeatAvailableDict is %@",[listSeatAvailableDict class]);
    
    return rawJsonString2;
}

+(NSDictionary*)parseCIJson : (NSString*)rawJsonString
{
//    NSArray * tmpAry = [rawJsonString componentsSeparatedByString:@":"];
//    NSLog(@"The json string is %@,",rawJsonString);
//    for(int i=0 ; i < tmpAry.count ; i++)
//    {
//        NSLog(@"Current is element %d and the content is %@",i,tmpAry[i]);
//    }
    NSData* jsonData = [rawJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id parsedObj = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    NSLog(@"parseObject is class %@",[parsedObj class]);
    
    NSDictionary * resJsonDict = parsedObj;
    NSLog(@"dict is %@",resJsonDict);
    
    NSMutableDictionary * finalDict = [[NSMutableDictionary alloc]initWithDictionary:resJsonDict];
    
    
//    for(int idx = 0 ; idx < resJsonAry.count ; idx++){
//        NSLog(@"This is element %i , content is %@",idx,resJsonAry[idx]);
//    }
    // assuming jsonString is your JSON string...
    //NSData* jsonData = [rawJsonString dataUsingEncoding:NSUTF8StringEncoding];
//    SBJson5ValueBlock block = ^(id v, BOOL *stop) {
//        BOOL isArray = [v isKindOfClass:[NSArray class]];
//        NSLog(@"Found: %@", isArray ? @"Array" : @"Object");
//        NSLog(@"Ths element number of the array is %i", (int)((NSArray*)v).count);
//    };
//
//    SBJson5ErrorBlock eh = ^(NSError* err) {
//        NSLog(@"OOPS: %@", err);
//        exit(1);
//    };
//
//    id parser = [SBJson5Parser parserWithBlock:block
//                                  errorHandler:eh];
//    //[parser parse:jsonData];
//     NSLog(@"The parse result is %u",[parser parse:jsonData]); // returns SBJson5ParserWaitingForData
    //id data = [rawJsonString dataWithEncoding:NSUTF8StringEncoding];
//    NSLog(@"the rawJsonString is %@",rawJsonString);
//    NSData * jsonData = [rawJsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//    NSLog(@"the jsonArray number is %i", (int)jsonArray.count);
//    NSLog(@"the jsonArray number 1 is %@", jsonArray[0]);
//    NSError *error = nil;
//    if(!jsonData)
//    {
//        NSLog(@"jsonData is nil");
//        return nil;
//
//    }
//    id object = [NSJSONSerialization
//                 JSONObjectWithData:jsonData
//                 options:0
//                 error:&error];
   // NSLog(@"Ths object is class %@",[object class]);
//    if([object isKindOfClass:[NSDictionary class]])
//    {
//        NSDictionary *results = object;
//        NSLog(@"parse succeed!");
//        /* proceed with results as you like; the assignment to
//         an explicit NSDictionary * is artificial step to get
//         compile-time checking from here on down (and better autocompletion
//         when editing). You could have just made object an NSDictionary *
//         in the first place but stylistically you might prefer to keep
//         the question of type open until it's confirmed */
//    }
//    else
//    {
//        NSLog(@"parse failed");
//    }
   
    
    //NSDictionary* myDict =

    
    return finalDict;
}

+(NSString*)readTestFil
{
    @try
    {
        NSString * jsonFile = [[NSBundle mainBundle] pathForResource:@"rawjson" ofType:@"json"];
        //NSString * docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/rawjson.json"];
        NSString * jsonContent = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:NULL];
        NSString * tmpstrjson1 = [jsonContent stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSLog(@"The tmpstrjson1 file is %@",tmpstrjson1);
        NSString *jsonContent2 = [tmpstrjson1 substringWithRange:NSMakeRange(1, jsonContent.length-2)];
        NSLog(@"Ths jsonContent2 is %@",jsonContent2);
        
        
        return tmpstrjson1;
    }
    @catch(NSException * e)
    {
        NSLog(@"The exception is %@",e.reason);
    }
    return @"";
}

+(NSMutableDictionary*)doParseJson
{
    [self readTestFil];
    NSMutableDictionary * retParsedDict = [[NSMutableDictionary alloc]init];
    NSDictionary * firstLevelParsedDict = [self parseCIJson:[self readTestFil]];
    [retParsedDict setValue:@"DynamicObject" forKey:@"Type"];
    //[retParsedDict add]
    NSDictionary * listAvailableDict = [self parseCIJsonListSeatAvailable:[firstLevelParsedDict objectForKey:@"Payload"]];
    [retParsedDict addEntriesFromDictionary:listAvailableDict];
    NSLog(@"The content of retParsedDict is %@",retParsedDict);
    return retParsedDict;
}

@end
