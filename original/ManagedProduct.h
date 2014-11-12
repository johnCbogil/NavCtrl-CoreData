//
//  ManagedProduct.h
//  NavCtrl
//
//  Created by Aditya Narayan on 11/12/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedProduct : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * productID;
@property (nonatomic, retain) NSString * url;

@end
