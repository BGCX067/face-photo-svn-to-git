//
//  Settings.m
//  FacePhoto
//
//  Created by vinh pham on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

enum {
    SettingSection,
    InAppSection,
    OurAvailableAppSection,
};

@implementation Settings
@synthesize mainTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   if (section == SettingSection)
       return 4;
   else if (section == InAppSection)
       return 3;
   else if (section == OurAvailableAppSection)
       return 2;
   else 
       return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == SettingSection)
        return @"Settings";
    else if (section == InAppSection)
        return @"Our In App Purchase";
    else if (section == OurAvailableAppSection)
        return @"Our Available Apps";
    else 
        return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.section == SettingSection){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Account";
            cell.imageView.image = [UIImage imageNamed:@"icon-facebook.png"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"Appearance";
            cell.imageView.image = [UIImage imageNamed:@"icon-appearance.png"];
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"Contact us";
            cell.imageView.image = [UIImage imageNamed:@"icon-email.png"];
        }
        else if (indexPath.row == 3){
            cell.textLabel.text = @"Give us a chance";
            cell.imageView.image = [UIImage imageNamed:@"icon-giveus.png"];
        }
    }
    else if (indexPath.section == InAppSection) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Appearance Pack";
            cell.imageView.image = [UIImage imageNamed:@"icon-appearance-pack.png"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"Users Pack";
            cell.imageView.image = [UIImage imageNamed:@"icon-user-pack.png"];
        }
        else if (indexPath.row == 2){
            cell.textLabel.text = @"Albums Pack";
            cell.imageView.image = [UIImage imageNamed:@"icon-album-pack.png"];
        }
    }
    else if (indexPath.section == OurAvailableAppSection){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Facts 'n Quotes";
            cell.imageView.image = [UIImage imageNamed:@"icon-facts.png"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"SupR Billy";
            cell.imageView.image = [UIImage imageNamed:@"icon-supR.png"];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SettingSection){
        if (indexPath.row == 0) {
            //Account
        }
        else if (indexPath.row == 1){
            //Appearance
        }
        else if (indexPath.row == 2) {
            //Contact us
        }
        else if (indexPath.row == 3){
            //Give us a chance
        }
    }
    else if (indexPath.section == InAppSection) {
        
    }
}

- (void) dealloc {
    [mainTableView release];
    [super dealloc];
}

@end
