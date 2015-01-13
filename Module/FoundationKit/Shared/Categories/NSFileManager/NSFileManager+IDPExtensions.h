//
//  NSFileManager+DocumentsDirectory.h
//  YouGotListings
//
//  Created by trimm on 16.08.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IDPDocumentsDirectoryType,
    IDPLibraryDirectoryType,
    IDPBundleDirectoryType,
    IDPApplicationsDataType,
    IDPUndefinedDataType
} IDPDirectoryType;


@interface NSFileManager (IDPExtensions)

+ (NSString *)directoryPathWithType:(IDPDirectoryType)type;

+ (NSString *)documentsDirectoryPath;
+ (NSString *)libraryDirectoryPath;
+ (NSString *)bundleDirectoryPath;
+ (NSString *)applicationDataPath;

+ (BOOL)fileName:(NSString *)fileName existsInDirectoryOfType:(IDPDirectoryType)type;
+ (BOOL)fileName:(NSString *)fileName existsInPath:(NSString *)path;

//Return uniquely named temporary directory from template
- (NSString *)uniqueDirectoryInPath:(NSString *)path;

- (BOOL)createDirectoryAtPath:(NSString *)path;

@end
