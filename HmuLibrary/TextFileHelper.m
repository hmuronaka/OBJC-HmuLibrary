//
//  TextFileHelper.m
//  HmuLibrary
//
//  Created by MURONAKA HIROAKI on 2014/05/03.
//  Copyright (c) 2014年 hmu. All rights reserved.
//

#import "TextFileHelper.h"

@implementation TextFileHelper


// CSVファイルを読み、１行毎にblockを呼び出す.
// blockの引数は、１行をカンマで分割した配列.
// 例: @"ab,cd,efg" なら@[@"ab,@"cd",@"efg"]を返す.
+(BOOL)readCsv:(NSString*)filePath block:(void (^)(NSArray*))block {
    return [TextFileHelper readCsv:filePath withCommentStr:nil block:block];
}

// CSVファイルを読み、１行毎にblockを呼び出す.
// blockの引数は、１行をカンマで分割した配列.
// 例: @"ab,cd,efg" なら@[@"ab,@"cd",@"efg"]を返す.
//
// @param comment 行頭にcommentがある場合は、その行を読み飛ばす. コメント不要の場合はnil.
+(BOOL)readCsv:(NSString*)filePath withCommentStr:(NSString*)comment block:(void (^)(NSArray*))block {
    // TestのためにmainBundleではなくbundleForClassを利用している。
    if( filePath == nil ) {
        return NO;
    }
    
    NSString* text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if( text == nil ) {
        return NO;
    }
    NSArray* lines = [text componentsSeparatedByString:@"\n"];
    
    for(NSString* line in lines) {
        // 行頭にコメント文字列を含む場合は、その行を読み飛ばす.
        if( line.length == 0 ||
           (comment != nil && [line hasPrefix:comment])) {
            continue;
        }
        
        NSArray* item = [line componentsSeparatedByString:@","];
        block(item);
    }
    return YES;
}

@end
