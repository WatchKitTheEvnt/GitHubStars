//
//  GHSFileStorageCordinator.m
//  GitHubStars
//
//  Created by Eduardo Gonzalez on 22/2/15.
//  Copyright (c) 2015 Tuenti. All rights reserved.
//

#import "GHSFileStorageCordinator.h"
#import "GitHubStarsCoreKitConfiguration.h"


static NSString *const GHSFileStorageFileExtensionKey = @"list";


@interface GHSFileStorageCordinator ()

@property (nonatomic) NSFileManager *defaultManager;
@property (nonatomic) NSOperationQueue *fileStorageQueue;

@end

@implementation GHSFileStorageCordinator

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _defaultManager = [NSFileManager defaultManager];
        _fileStorageQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (NSURL *)localDocumentsDirectory
{
    NSURL *documentsURL = [[self.defaultManager containerURLForSecurityApplicationGroupIdentifier:GitHubStarsCoreKitAppGroupName]
                           URLByAppendingPathComponent:@"Documents" isDirectory:YES];

    NSError *error;
    // This will return `YES` for success if the directory is successfully created, or already exists.
    BOOL success = [self.defaultManager createDirectoryAtURL:documentsURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (success)
    {
        return documentsURL;
    }
    else
    {
        NSLog(@"The shared application group documents directory doesn't exist and could not be created. Error: %@", error.localizedDescription);
        abort();
    }
}


- (void)saveSerializableModel:(GHSSerializableModel *)model forKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler
{
    NSURL *documentURLForName = [[[self localDocumentsDirectory] URLByAppendingPathComponent:key] URLByAppendingPathExtension:GHSFileStorageFileExtensionKey];
    
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    
    NSFileAccessIntent *writingIntent = [NSFileAccessIntent writingIntentWithURL:documentURLForName options:NSFileCoordinatorWritingForReplacing];
    [fileCoordinator coordinateAccessWithIntents:@[writingIntent] queue:self.fileStorageQueue byAccessor:^(NSError *accessError) {
        
        if (accessError)
        {
            if (completionHandler)
            {
                completionHandler(accessError);
            }
            return;
        }
        
        NSError *error;
        
        NSData *serializedData = [model serialize];
        BOOL success = [serializedData writeToURL:writingIntent.URL options:NSDataWritingAtomic error:&error];
        
        if (success)
        {
            NSDictionary *fileAttributes = @{NSFileExtensionHidden: @YES};
            [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:writingIntent.URL.path error:nil];
        }
        
        if (completionHandler)
        {
            completionHandler(error);
        }
    }];

}

- (void)loadSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(GHSSerializableModel *model, NSError *error))completionHandler
{
    NSURL *documentURLForName = [[[self localDocumentsDirectory] URLByAppendingPathComponent:key] URLByAppendingPathExtension:GHSFileStorageFileExtensionKey];
    
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    
    // `url` may be a security scoped resource.
    BOOL successfulSecurityScopedResourceAccess = [documentURLForName startAccessingSecurityScopedResource];
    
    NSFileAccessIntent *readingIntent = [NSFileAccessIntent readingIntentWithURL:documentURLForName options:NSFileCoordinatorReadingWithoutChanges];
    [fileCoordinator coordinateAccessWithIntents:@[readingIntent] queue:self.fileStorageQueue  byAccessor:^(NSError *accessError) {
        if (accessError)
        {
            if (successfulSecurityScopedResourceAccess)
            {
                [documentURLForName stopAccessingSecurityScopedResource];
            }
            
            if (completionHandler)
            {
                completionHandler(nil, accessError);
            }
            
            return;
        }
        
        NSError *readError;
        NSData *contents = [NSData dataWithContentsOfURL:readingIntent.URL options:NSDataReadingUncached error:&readError];

        if (successfulSecurityScopedResourceAccess)
        {
            [documentURLForName stopAccessingSecurityScopedResource];
        }
        
        if (completionHandler)
        {
            completionHandler([GHSSerializableModel deserialize:contents], readError);
        }
    }];

}

- (void)clearSerializableModelForKey:(NSString *)key withCompletionHandler:(void (^)(NSError *error))completionHandler
{
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    
    // `url` may be a security scoped resource.
    NSURL *url = [NSURL URLWithString:key];
    BOOL successfulSecurityScopedResourceAccess = [url startAccessingSecurityScopedResource];
    
    NSFileAccessIntent *writingIntent = [NSFileAccessIntent writingIntentWithURL:url options:NSFileCoordinatorWritingForDeleting];
    [fileCoordinator coordinateAccessWithIntents:@[writingIntent] queue:self.fileStorageQueue byAccessor:^(NSError *accessError) {
        if (accessError)
        {
            if (completionHandler)
            {
                completionHandler(accessError);
            }
            return;
        }
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error;
        
        [fileManager removeItemAtURL:writingIntent.URL error:&error];
        
        if (successfulSecurityScopedResourceAccess)
        {
            [url stopAccessingSecurityScopedResource];
        }
        
        if (completionHandler)
        {
            completionHandler(error);
        }
    }];
}

@end
