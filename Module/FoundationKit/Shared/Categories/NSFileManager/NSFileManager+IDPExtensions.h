//
//  NSFileManager+DocumentsDirectory.h
//  YouGotListings
//
//  Created by trimm on 16.08.11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IDPDocumentsDirectoryPath,
    IDPLibraryDirectoryPath,
    IDPBundleDirectoryPath,
    IDPApplicationsDataPath,
    IDPUndefinedDataPath
} IDPDirectoryPath;


@interface NSFileManager (IDPExtensions)

+ (NSString *)directoryPathForPath:(IDPDirectoryPath)thePath;

+ (NSString *)documentsDirectoryPath;
+ (NSString *)libraryDirectoryPath;
+ (NSString *)bundleDirectoryPath;
+ (NSString *)applicationDataPath;

+ (BOOL)fileNameExistsInDocumentsDirectory:(NSString *)fileName;
+ (BOOL)fileNameExistsInLibraryDirectory:(NSString *)fileName;
+ (BOOL)fileNameExistsInBundleDirectory:(NSString *)fileName;
+ (BOOL)fileNameExistsInApplicationDataPath:(NSString *)fileName;

+ (BOOL)fileName:(NSString *)fileName existsInDirectory:(NSString *)directoryPath;

//Return uniquely named temporary directory from template
+ (NSString *)temporaryFolderInDirectory:(NSString *)directoryPath forTemplate:(NSString *)templateString;

@end
