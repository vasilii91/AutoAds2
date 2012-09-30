//
//  DatabaseManager.h
//  AutoAds
//
//  Created by Vasilii Kasnitski on 9/30/12.
//  Copyright (c) 2012 Kyr Dunenkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteAdv.h"
#import "Query.h"

@interface DatabaseManager : NSObject
{
    NSManagedObjectContext *currentManagedObjectContext;
}

+ (DatabaseManager *)sharedMySingleton;

- (NSManagedObject *)createEntityByClass:(Class)klass;
- (BOOL)deleteEntity:(NSManagedObject *)managedObject;
- (void)saveAll;

- (NSArray *)getQueries:(BOOL)isSaved;
- (Query *)findQueryByQueryString:(NSString *)queryString isSaved:(BOOL)isSaved;

@end