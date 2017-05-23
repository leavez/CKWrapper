//
//  CSChangeSet+Build.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSChangeSet+Build.h"

@implementation CSChangeSet(build)
- (CKTransactionalComponentDataSourceChangeset *)build {
    return [[CKTransactionalComponentDataSourceChangeset alloc]
            initWithUpdatedItems:self.updatedItems
            removedItems:self.removedItems
            removedSections:self.removedSections
            movedItems:self.movedItems
            insertedSections:self.insertedSections
            insertedItems:self.insertedItems];
}
@end
