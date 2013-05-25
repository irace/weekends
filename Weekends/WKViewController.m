//
//  WKViewController.m
//  Weekends
//
//  Created by Bryan Irace on 5/24/13.
//  Copyright (c) 2013 Bryan Irace. All rights reserved.
//

#import "WKViewController.h"

#import <EventKit/EventKit.h>

@interface WKViewController ()

@property (nonatomic, strong) EKEventStore *store;
@property (nonatomic, strong) NSArray *weekendDates;

@end

@implementation WKViewController

#pragma mark - NSObject

- (id)init {
    if (self = [super initWithStyle:UITableViewStylePlain]) {

    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    
//    self.store = [[EKEventStore alloc] init];
//    
//    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        // TODO: :(
//    }];
    
    NSMutableArray *weekends = [[NSMutableArray alloc] init];
    
    NSDate *weekend = nextWeekendDate([NSDate date]);
    
    for (int i = 0; i < 10; i++) {
        [weekends addObject:weekend];
        weekend = addDaysToDate(weekend, 7);
    }
    
    self.weekendDates = weekends;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

#pragma mark - UITableViewControllerDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.weekendDates[indexPath.row]];
    return cell;
}

#pragma mark - Private

// http://stackoverflow.com/questions/8320213/how-do-i-subtract-a-duration-from-an-nsdate-but-not-include-the-weekends/8366301#8366301

NSDate *addDaysToDate(NSDate *date, NSInteger numberOfDays) {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = numberOfDays;
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:date options:0];
}

NSDate *nextWeekendDate(NSDate *date) {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSInteger daysTillWeekend = ((7 - [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit
                                                         forDate:date]) % 7);
    
    NSDate *weekendDate = addDaysToDate(date, daysTillWeekend);
    
    // Move to the beginning of the day
    
    unsigned int flags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|
            NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *dateComponents = [calendar components:flags fromDate:weekendDate];
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;

    return [calendar dateFromComponents:dateComponents];
}

// TODO: Does this use system timezone by default?

@end
