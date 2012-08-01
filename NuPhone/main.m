//
//  main.m
//  NuPhone
//
//  Created by Ethan Sherbondy on 8/1/12.
//  Copyright (c) 2012 Ethan Sherbondy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nu.h"

int main(int argc, char *argv[]) {
    NuInit();
    @autoreleasepool {
        NSError *error;
        NSString *main_nu = [NSString stringWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:@"main" ofType:@"nu"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
        
        id parser = [Nu parser];
        [parser parseEval:main_nu];
    }
    return UIApplicationMain(argc, argv, nil, @"NPAppDelegate");
}
