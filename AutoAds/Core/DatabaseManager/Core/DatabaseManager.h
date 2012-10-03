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
#import "VehicleBrand.h"
#import "VehicleModel.h"
#import "VehicleModification.h"
#import "Option.h"
#import "OptionsCategory.h"

#import "CachedData.h"
#import "OptionsCategories.h"
#import "Options.h"
#import "Brand.h"
#import "Model.h"
#import "Modification.h"

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

- (void)addBrands:(NSMutableArray *)brands forRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (void)addOptionsCategory:(NSMutableArray *)optionsCategory forRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (NSMutableArray *)brandsByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;
- (NSMutableArray *)optionCategoriesByRubric:(NSString *)rubric subrubric:(NSString *)subrubric;

@end