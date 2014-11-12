//
//  ManagedCompany.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/12/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedCompany : NSManagedObject

@property (nonatomic, retain) NSString * companyID;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSString * name;

@end
