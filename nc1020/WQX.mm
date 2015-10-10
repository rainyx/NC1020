//
//  WQX.m
//  NC1020
//
//  Created by eric on 15/8/25.
//  Copyright (c) 2015年 rainyx. All rights reserved.
//

#import "WQX.hpp"
#import "WQXToolbox.h"

@interface WQXArchive()
{
    
}
@end
@implementation WQXArchive
@synthesize name = _name, directory = _directory;

- (id)initWithName:(NSString *)name andDirectory:(NSString *)directory {
    if ([super init]) {
        self.name = name;
        _directory = directory;
        return self;
    } else {
        return Nil;
    }
}

- (NSString *)norFlashPath {
    return [_directory stringByAppendingPathComponent:kWQXNORFlashName];
}

- (NSString *)statesPath {
    return [_directory stringByAppendingPathComponent:kWQXStatesName];
}

- (id)initWithCoder:(NSCoder *)coder {
    if ([super init]) {
        _name = [coder decodeObjectForKey:@"name"];
        _directory = [coder decodeObjectForKey:@"directory"];
        return self;
    } else {
        return Nil;
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.directory forKey:@"directory"];
}


@end

@interface WQX()
{
    NSMutableDictionary *_archives;
    NSString *_defaultArchiveName;
    NSInteger _defaultLayoutClassIndex;
}
@end

static WQX *_instance = Nil;
static NSArray *_layoutClassNames = Nil;

@implementation WQX

+ (WQX *)sharedInstance {
    if (_instance == Nil) {
        
        _layoutClassNames = [[NSArray alloc] initWithObjects:@"WQXDefaultScreenLayout", @"WQXGMUDScreenLayout", nil];
        
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        NSData *data = [preferences objectForKey:@"perferences"];
        
        _instance = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (_instance == Nil) {
            _instance = [[WQX alloc] init];
        }
        [_instance checkVars];
        return _instance;
    }
    return _instance;
}

+ (WQXArchive *)archiveWithName:(NSString *)name {
    return [WQX archiveCopyFrom:Nil withNewName:name];
}

+ (WQXArchive *)archiveCopyFrom:(WQXArchive *)archive withNewName:(NSString *)name {
   
    NSString *newArchiveDirectoryName = [WQXToolbox calcMD5Hash:name];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *basePath = [WQX archiveDirectoryPath];
    NSString *newArchiveDirectoryPath = [basePath stringByAppendingPathComponent:newArchiveDirectoryName];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:newArchiveDirectoryPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:newArchiveDirectoryPath withIntermediateDirectories:YES attributes:Nil error:Nil];
    }

    WQXArchive *newArchive = [[WQXArchive alloc] initWithName:name andDirectory:newArchiveDirectoryName];
    
    NSString *srcNorFlashPath;
    NSString *srcStatesPath;
    NSString *destNorFlashPath;
    NSString *destStatesPath;
    NSString *destRomLinkPath;
    NSString *romDirectoryPath = [self romDirectoryPath];
    
    if (archive != Nil) {
        srcNorFlashPath = [basePath stringByAppendingPathComponent:archive.norFlashPath];
        srcStatesPath = [basePath stringByAppendingPathComponent:archive.statesPath];
    } else {
        srcNorFlashPath = [romDirectoryPath stringByAppendingPathComponent:kWQXNORFlashName];
        srcStatesPath = [romDirectoryPath stringByAppendingPathComponent:kWQXStatesName];
    }
    
    destNorFlashPath = [newArchiveDirectoryPath stringByAppendingPathComponent:kWQXNORFlashName];
    destStatesPath = [newArchiveDirectoryPath stringByAppendingPathComponent:kWQXStatesName];
    destRomLinkPath = [newArchiveDirectoryPath stringByAppendingPathComponent:kWQXROMName];
    
    NSError *error;
    [fileManager copyItemAtPath:srcNorFlashPath toPath:destNorFlashPath error:&error];
    NSLog(@"%@", error);
    [fileManager copyItemAtPath:srcStatesPath toPath:destStatesPath error:&error];
    NSLog(@"%@", error);
    
    return newArchive;
}

+ (wqx::WqxRom)wqxRomWithArchive:(WQXArchive *)archive {
    wqx::WqxRom rom;
    NSString *basePath = [WQX archiveDirectoryPath];
    rom.romPath = [[WQX romDirectoryPath] stringByAppendingPathComponent:kWQXROMName].UTF8String;
    rom.norFlashPath = [basePath stringByAppendingPathComponent:archive.norFlashPath].UTF8String;
    rom.statesPath = [basePath stringByAppendingPathComponent:archive.statesPath].UTF8String;
    return rom;
}

+ (NSString *)romDirectoryPath {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [resourcePath stringByAppendingPathComponent:@"rom"];
    return path;
}

+ (NSString *)archiveDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    return [basePath stringByAppendingPathComponent:@"archives"];
}

- (void)removeAllArchives {
    [_archives removeAllObjects];
    _defaultArchiveName = Nil;
}
- (void)addArchive:(WQXArchive *)archive {
    if ([_archives objectForKey:archive.name] == Nil) {
        [_archives setObject:archive forKey:archive.name];
    }
}

- (void)removeArchiveWithName:(NSString *)name {
    
}

- (BOOL)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"perferences"];
    return [defaults synchronize];
}

- (void)checkVars {
    if (_archives == Nil) {
        _archives = [[NSMutableDictionary alloc] init];
    }
}

- (id)init {
    if ([super init]) {
        return self;
    } else {
        return Nil;
    }
}

- (id)initWithCoder:(NSCoder *)coder {
    if ([super init]) {
        _archives = [coder decodeObjectForKey:@"archives"];
        _defaultArchiveName = [coder decodeObjectForKey:@"defaultArchiveName"];
        _defaultLayoutClassIndex = [coder decodeIntegerForKey:@"defaultLayoutClassIndex"];
        return self;
    } else {
        return Nil;
    }
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_archives forKey:@"archives"];
    [coder encodeObject:_defaultArchiveName forKey:@"defaultArchiveName"];
    [coder encodeInteger:_defaultLayoutClassIndex forKey:@"defaultLayoutClassIndex"];
}

- (NSDictionary *)archives {
    return _archives;
}

- (void)setDefaultArchive:(WQXArchive *)archive {
    _defaultArchiveName = archive.name;
}

- (WQXArchive *)defaultArchive {
    return [_archives objectForKey:_defaultArchiveName];
}

- (NSString *)defaultLayoutClassName {
    return [_layoutClassNames objectAtIndex:_defaultLayoutClassIndex];
}

- (NSString *)switchLayout {
    _defaultLayoutClassIndex = (_defaultLayoutClassIndex + 1) % _layoutClassNames.count;
    return [self defaultLayoutClassName];
}

@end
