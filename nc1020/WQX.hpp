//
//  WQX.m
//  NC1020
//
//  Created by rainyx on 15/8/23.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQXToolbox.h"
#import "nc1020.h"

//#define kWQXLCDBackgroundColor [WQXToolbox colorWithRGB:0x80B080]
#define kWQXLCDBackgroundColor [WQXToolbox colorWithRGB:0xC1C1C1]
#define kWQXROMName @"obj_lu.bin"
#define kWQXNORFlashName @"nc1020.fls"
#define kWQXStatesName @"nc1020.sts"

typedef struct WQXArchiveData WQXArchiveData;

@interface WQXArchive : NSObject
{
    NSString *_name;
    NSString *_directory;
}
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic, readonly) NSString *directory;
- (id)initWithName:(NSString *)name andDirectory:(NSString *)directory;
- (NSString *)norFlashPath;
- (NSString *)statesPath;

@end

@interface WQX : NSObject


+ (WQX *)sharedInstance;
+ (WQXArchive *)archiveWithName:(NSString *)name;
+ (WQXArchive *)archiveCopyFrom:(WQXArchive *)archive withNewName:(NSString *)name;
+ (NSString *)archiveDirectoryPath;
+ (wqx::WqxRom)wqxRomWithArchive:(WQXArchive *)archive;

- (void)removeAllArchives;
- (NSDictionary *)archives;
- (void)removeArchiveWithName:(NSString *)name;
- (void)addArchive:(WQXArchive *)archive;
- (void)setDefaultArchive:(WQXArchive *)archive;
- (WQXArchive *)defaultArchive;
- (NSString *)defaultLayoutClassName;
- (NSString *)switchLayout;
- (BOOL)save;
@end

