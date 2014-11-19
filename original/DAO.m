//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/7/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

// Grab the managedObjectContext
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)checkForCoreData {
    
    NSFetchRequest *productRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"ManagedProduct"inManagedObjectContext:self.managedObjectContext];
    [productRequest setEntity:productEntity];
    NSPredicate *productPredicate = [NSPredicate predicateWithFormat:@"name != ''"];
    [productRequest setPredicate:productPredicate];
    NSError *error = nil;
    NSUInteger count = [self.managedObjectContext countForFetchRequest:productRequest error:&error];

    
    if(count==0) {
        [self createManagedObjects];
    } else {
        [self fetchManagedObjects];
    }
}

-(void)fetchManagedObjects{
        // Fetch Companies
        NSFetchRequest *companiesFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *companiesEntity = [NSEntityDescription entityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
        [companiesFetchRequest setEntity:companiesEntity];
        NSError *error;
        NSArray *fetchedCompaniesObjects = [self.managedObjectContext executeFetchRequest:companiesFetchRequest error:&error];
        if(fetchedCompaniesObjects != nil)
        {
            // Convert managedProducts to products
            self.companyList = [[NSMutableArray alloc]init];
            for(int i=0; i<fetchedCompaniesObjects.count; i++)
            {
                // Initialize a new company for each managedProduct
                Company *company = [[Company alloc]init];
                
                // name is a get method sent to managedCompanyObject[i]
                company.name = [fetchedCompaniesObjects[i] name];
                id compID = [fetchedCompaniesObjects[i] valueForKey:@"companyID"];
                company.companyID = [compID intValue];
                company.logo = [fetchedCompaniesObjects[i] logo];
                
                // Add products to productsList
                [self.companyList addObject:company];
                //NSLog(@"%@", self.companyList[i]);

            }
        
        // Fetch Products
        NSFetchRequest *productsFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *productsEntity = [NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
        [productsFetchRequest setEntity:productsEntity];
        NSError *error;
        NSArray *fetchedProductsObjects = [self.managedObjectContext executeFetchRequest:productsFetchRequest error:&error];
        if(fetchedProductsObjects != nil)
        {
            // Convert managedProducts to products
            self.productsList = [[NSMutableArray alloc]init];
            for(int i=0; i<fetchedProductsObjects.count; i++)
            {
                // Initialize a new product for each managedProduct
                Product *product = [[Product alloc]init];
                
                // name is a get method sent to managedCompanyObject[i]
                product.name = [fetchedProductsObjects[i] name];
                id prodID = [fetchedProductsObjects[i] valueForKey:@"productID"];
                product.productID = [prodID intValue];
                product.url = [fetchedProductsObjects[i] url];
                product.image = [fetchedProductsObjects[i] image];
                
                
                // Add products to productsList
                [self.productsList addObject:product];
                NSLog(@"%@", self.productsList[i]);
                //[product release];

            }
            
            [self addProductsToCompanies];
        }
    }
}

-(void)createManagedObjects{

    // APPLE
    NSManagedObject *apple = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    [apple setValue:@"Apple" forKey:@"name"];
    [apple setValue:@"1" forKey:@"companyID"];
    [apple setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/logos/apple.png" forKey:@"logo"];
    
    NSManagedObject *iPodTouch = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [iPodTouch setValue:@"iPodTouch" forKey:@"name"];
    [iPodTouch setValue:@"1" forKey:@"productID"];
    [iPodTouch setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/ipodtouch.jpg" forKey:@"image"];
    [iPodTouch setValue:@"http://www.apple.com/ipod-touch" forKey:@"url"];
    
    NSManagedObject *iPad = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [iPad setValue:@"iPad" forKey:@"name"];
    [iPad setValue:@"1" forKey:@"productID"];
    [iPad setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/IPad_3.png" forKey:@"image"];
    [iPad setValue:@"http://www.apple.com/ipad" forKey:@"url"];
    
    NSManagedObject *iPhone = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [iPhone setValue:@"iPhone" forKey:@"name"];
    [iPhone setValue:@"1" forKey:@"productID"];
    [iPhone setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/iphone-6.jpg" forKey:@"image"];
    [iPhone setValue:@"http://www.apple.com/iphone" forKey:@"url"];

    
    // SAMSUNG
    NSManagedObject *samsung = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    [samsung setValue:@"Samsung" forKey:@"name"];
    [samsung setValue:@"2" forKey:@"companyID"];
    [samsung setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/logos/samsung.jpg" forKey:@"logo"];
    
    NSManagedObject *galaxyS4 = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [galaxyS4 setValue:@"galaxyS4" forKey:@"name"];
    [galaxyS4 setValue:@"2" forKey:@"productID"];
    [galaxyS4 setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/GalaxyS4.jpg" forKey:@"image"];
    [galaxyS4 setValue:@"http://www.samsung.com/global/microsite/galaxys4/" forKey:@"url"];
    
    NSManagedObject *galaxyNote = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [galaxyNote setValue:@"galaxyNote" forKey:@"name"];
    [galaxyNote setValue:@"2" forKey:@"productID"];
    [galaxyNote setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/galnote.jpg" forKey:@"image"];
    [galaxyNote setValue:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" forKey:@"url"];
    
    NSManagedObject *galaxyTab = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [galaxyTab setValue:@"galaxyTab" forKey:@"name"];
    [galaxyTab setValue:@"2" forKey:@"productID"];
    [galaxyTab setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/galtab.jpg" forKey:@"image"];
    [galaxyTab setValue:@"http://www.samsung.com/us/mobile/galaxy-tab/" forKey:@"url"];
    
    
    // AMAZON
    NSManagedObject *amazon = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    [amazon setValue:@"Amazon" forKey:@"name"];
    [amazon setValue:@"3" forKey:@"companyID"];
    [amazon setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/logos/amazon.jpg" forKey:@"logo"];
    
    NSManagedObject *kindle = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [kindle setValue:@"kindle" forKey:@"name"];
    [kindle setValue:@"3" forKey:@"productID"];
    [kindle setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/kindle.jpg" forKey:@"image"];
    [kindle setValue:@"http://www.amazon.com/gp/product/B007HCCNJU/ref=amb_link_367867082_6?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=left-1&pf_rd_r=1T0F71A1VHN6XN4HNJGD&pf_rd_t=101&pf_rd_p=1865255342&pf_rd_i=133141011" forKey:@"url"];
    
    NSManagedObject *fire = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [fire setValue:@"fire" forKey:@"name"];
    [fire setValue:@"3" forKey:@"productID"];
    [fire setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/fire.jpg" forKey:@"image"];
    [fire setValue:@"http://www.amazon.com/dp/B00HCNHDN0/ref=fs_fs" forKey:@"url"];
    
    NSManagedObject *firePhone = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [firePhone setValue:@"firePhone" forKey:@"name"];
    [firePhone setValue:@"3" forKey:@"productID"];
    [firePhone setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/fire phone.jpg" forKey:@"image"];
    [firePhone setValue:@"http://www.amazon.com/gp/product/B00EOE0WKQ/ref=s9_simh_gw_p493_d0_i1?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=center-4&pf_rd_r=03X1BBVTKGK0TXYXAKM8&pf_rd_t=101&pf_rd_p=1688200482&pf_rd_i=507846" forKey:@"url"];
    
    
    // GOOGLE
    NSManagedObject *google = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:[self managedObjectContext]];
    [google setValue:@"Google" forKey:@"name"];
    [google setValue:@"4" forKey:@"companyID"];
    [google setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/logos/google.jpg" forKey:@"logo"];
    
    NSManagedObject *nexus7 = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [nexus7 setValue:@"nexus7" forKey:@"name"];
    [nexus7 setValue:@"4" forKey:@"productID"];
    [nexus7 setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/Nexus_7.png" forKey:@"image"];
    [nexus7 setValue:@"http://www.google.com/nexus/7/" forKey:@"url"];
    
    NSManagedObject *nexus10 = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [nexus10 setValue:@"nexus10" forKey:@"name"];
    [nexus10 setValue:@"4" forKey:@"productID"];
    [nexus10 setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/Nexus_10.png" forKey:@"image"];
    [nexus10 setValue:@"http://www.google.com/nexus/10/" forKey:@"url"];
    
    NSManagedObject *chromecast = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:[self managedObjectContext]];
    [chromecast setValue:@"chromecast" forKey:@"name"];
    [chromecast setValue:@"4" forKey:@"productID"];
    [chromecast setValue:@"/Users/adityanarayan/Dropbox/JohnB/Week 3 - NavCtrl/devices/chromecast.jpg" forKey:@"image"];
    [chromecast setValue:@"http://www.google.com/chrome/devices/chromecast/" forKey:@"url"];

    
    [self fetchManagedObjects];
    [self addProductsToCompanies];
    NSError * error;
    [self.managedObjectContext save:&error];
}

-(void)addProductsToCompanies{
        
        // Iterate through each company
        for(int i=0; i<[self.companyList count]; i++)
        {
            // Assign each company to its own company object
            Company *company = self.companyList[i];
            
            // Allocate productsList property
            company.productsList = [[NSMutableArray alloc]init];
            
            // Iterate through each product
            for(int j=0; j<[self.productsList count]; j++)
            {
                // Assign each product to its own product object
                Product * product = self.productsList[j];
                
                // If the companyID's match
                if(company.companyID == product.productID){
                    
                    // Add the product to the appropriate company's productList
                    [company.productsList addObject: product];
                    
                }
            }
        }
    //[self.productsList removeAllObjects];
}

-(void)deleteManagedObject:(NSString*)product{
    
    NSEntityDescription *productEntity=[NSEntityDescription entityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:productEntity];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"name == %@", product];
    [fetch setPredicate:p];

    NSError *fetchError;
    NSArray *fetchedProducts=[self.managedObjectContext executeFetchRequest:fetch error:&fetchError];
    
    for (NSManagedObject *product in fetchedProducts) {
        [self.managedObjectContext deleteObject:product];
    }

    NSLog(@"%lu",(unsigned long)self.productsList.count);
    for (int i = 0; i < self.productsList.count; i++) {
        if (product == [self.productsList[i] name]) {
            [self.productsList removeObjectAtIndex:i];
            [self.productsList[i] release];
            break;
        }
    }
    NSLog(@"%lu",(unsigned long)self.productsList.count);
    
    
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
}
}

@end
