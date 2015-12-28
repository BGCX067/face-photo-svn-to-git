//
//  MyAlbumFolders.m
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/6/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import "MyAlbumFolders.h"
#import "MyAlbums.h"
#import "AppDelegate.h"


@implementation MyAlbumFolders

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    [super dealloc];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell.
	//NSString *timeZoneName = [timeZoneNames objectAtIndex:indexPath.row];
	cell.textLabel.text = @"Nguyen Hiep Quoc";
    cell.imageView.image = [UIImage imageNamed:@"leopard-folder.png"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 1;
    
    cell.detailTextLabel.text = @"Detail hear hfjhj gjh hjgj jjg";
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    cell.detailTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    cell.detailTextLabel.numberOfLines = 1;
	
	return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        UITextView *headerTextView = [[[UITextView alloc]
//                                       initWithFrame:CGRectMake(10, 10, tableView.bounds.size.width, 60.0)] autorelease];
//        headerTextView.textAlignment = UITextAlignmentLeft;
//        headerTextView.backgroundColor = [UIColor colorWithRed:0.9
//                                                         green:0.9
//                                                          blue:0.9 alpha:1];
//        headerTextView.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//        headerTextView.text = @"Nhung";
//        return headerTextView;
//    } else {
//        UITextView *headerTextView = [[[UITextView alloc]
//                                       initWithFrame:CGRectMake(10, 10, tableView.bounds.size.width, 60.0)] autorelease];
//        headerTextView.textAlignment = UITextAlignmentLeft;
//        headerTextView.backgroundColor = [UIColor colorWithRed:0.9
//                                                         green:0.9
//                                                          blue:0.9 alpha:1];
//        headerTextView.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//        headerTextView.text = @"Vo";
//        return headerTextView;
//    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Folder 1";
    }
    else {
        return @"Folder2";
    }
}

@end
