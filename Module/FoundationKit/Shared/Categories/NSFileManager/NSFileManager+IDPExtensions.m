//
//  NSFileManager+DocumentsDirectory.m
//  YouGotListings
//
//  Created by trimm on 16.08.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import "NSFileManager+IDPExtensions.h"

#import "NSPathUtilities+IDPExtensions.h"

static NSString * const kIDPUniqueFileNameFormat    = @"XXXXXX";
static NSString * const kIDPApplicationData         = @"IDPApplicationData";

@implementation NSFileManager (IDPExtensions)

+ (NSString *)directoryPathWithType:(IDPDirectoryType)type {
    switch (type) {
        case IDPApplicationsDataType:
            return [self applicationDataPath];
            
        case IDPDocumentsDirectoryType:
            return [self documentsDirectoryPath];
            
        case IDPLibraryDirectoryType:
            return [self libraryDirectoryPath];
            
        case IDPBundleDirectoryType:
            return [self bundleDirectoryPath];
            
        default:
            break;
    }
    
    return nil;
}

+ (NSString *)pathForDirectoryName:(NSString *)name
                     directoryType:(IDPDirectoryType)type
{
    NSString *result = [self directoryPathWithType:type];
    
    return [result stringByAppendingPathComponent:name];
}

#define IDPCacheAndReturnPath(var, directory) \
    do { \
        static __strong NSString *var = nil; \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            var = NSSearchPathForDirectory(directory); \
        }); \
        return var; \
    } \
    while (0);

+ (NSString *)documentsDirectoryPath {
    IDPCacheAndReturnPath(__docsDirectory, NSDocumentDirectory);
}

+ (NSString *)libraryDirectoryPath {
    IDPCacheAndReturnPath(__libraryDirectory, NSLibraryDirectory);
}

+ (NSString *)bundleDirectoryPath {
	return [[NSBundle mainBundle] bundlePath];
}

+ (NSString *)applicationDataPath {
    static __strong NSString *__applicationDataDirectory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __applicationDataDirectory = [self pathForDirectoryName:kIDPApplicationData
                                                  directoryType:IDPLibraryDirectoryType];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:__applicationDataDirectory];
    });
    
    return __applicationDataDirectory;
}

#undef IDPCacheAndReturnPath

+ (BOOL)fileName:(NSString *)fileName existsInDirectoryOfType:(IDPDirectoryType)type {
    NSString *path = [self directoryPathWithType:type];
    
	return [self fileName:fileName existsInPath:path];
}

+ (BOOL)fileName:(NSString *)fileName existsInPath:(NSString *)path {
    path = [path stringByAppendingPathComponent:fileName];
    
	return [[self defaultManager] fileExistsAtPath:path];
}

- (NSString *)uniqueDirectoryInPath:(NSString *)path {
    path = [path stringByAppendingPathComponent:kIDPUniqueFileNameFormat];
    
    const char *pathCString = [path fileSystemRepresentation];
    
    char *resultCString = (char *)malloc(strlen(pathCString) + 1);
    strcpy(resultCString, pathCString);
    
    if (mkdtemp(resultCString)) {
        NSString *result = [self stringWithFileSystemRepresentation:resultCString
                                                             length:strlen(resultCString)];
        
        free(resultCString);
        
        return result;
    }
    
    return nil;
}

- (BOOL)createDirectoryAtPath:(NSString *)path {
    NSFileManager *manager = self;
    
    if (![manager fileExistsAtPath:path]) {
        NSError *error = nil;
        
        BOOL success = [manager createDirectoryAtPath:path
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
        
        if (error || !success) {
            return NO;
        }
    }
    
    return YES;
}

@end
