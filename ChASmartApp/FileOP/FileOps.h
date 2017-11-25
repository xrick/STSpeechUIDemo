//
//  FileOps.h
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 16/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FileOps : NSObject{
    NSFileManager *fileMgr;
    NSString *homeDir;
    NSString *filename;
    NSString *filepath;
}


@property(nonatomic,retain) NSFileManager *fileMgr;
@property(nonatomic,retain) NSString *homeDir;
@property(nonatomic,retain) NSString *filename;
@property(nonatomic,retain) NSString *filepath;

-(NSString *) GetDocumentDirectory;
-(void)WriteToStringFile:(NSMutableString *)textToWrite;
-(NSString *) readFromFile;
-(NSString *) setFilename;




@end
