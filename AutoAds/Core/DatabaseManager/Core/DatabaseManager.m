//
//  DatabaseManager.m
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager


#pragma mark - Initialization

static DatabaseManager *_sharedMySingleton = nil;

- (id)init
{
    self = [super init];
    if (self) {
        currentManagedObjectContext = [NSManagedObjectContext contextForCurrentThread];
    }
    
    return self;
}

+ (DatabaseManager *)sharedMySingleton
{
    @synchronized(self)
    {
        if (!_sharedMySingleton) {
            _sharedMySingleton = [[DatabaseManager alloc] init];
        }
    }
    
    return _sharedMySingleton;
}


#pragma mark - Public methods

- (void)saveAll
{
    [currentManagedObjectContext save];
}

- (NSManagedObject *)createEntityByClass:(Class)klass
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(klass) inManagedObjectContext:currentManagedObjectContext];
}

- (BOOL)deleteEntity:(NSManagedObject *)managedObject
{
    BOOL result = [managedObject deleteInContext:currentManagedObjectContext];
    [currentManagedObjectContext save];
    
    return result;
}

- (NSArray *)getQueries:(BOOL)isSaved
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isSaved == %@", @(isSaved)];
    return [Query findAllWithPredicate:predicate];
}

- (Query *)findQueryByQueryString:(NSString *)queryString isSaved:(BOOL)isSaved
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(queryString == %@) AND (isSaved == %@)", queryString, @(isSaved)];
    NSArray *result = [Query findAllWithPredicate:predicate];
    
    return [result count] == 0 ? nil : [result objectAtIndex:0];
}

@end
