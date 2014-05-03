//
//  TextFileHelper.h
//  HmuLibrary
//
//  Created by MURONAKA HIROAKI on 2014/05/03.
//  Copyright (c) 2014年 hmu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFileHelper : NSObject

+(BOOL)readCsv:(NSString*)filePath block:(void (^)(NSArray*))block;
+(BOOL)readCsv:(NSString*)filePath withCommentStr:(NSString*)comment block:(void (^)(NSArray*))block;


@end
