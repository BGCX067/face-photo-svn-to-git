//
//  ResultViewAlbums.m
//  FacePhoto
//
//  Created by Quoc Nguyen on 3/10/12.
//  Copyright (c) 2012 Asnet. All rights reserved.
//

#import "ResultViewAlbums.h"
#import "AppDelegate.h"
#import "ResultViewPhotos.h"

@interface ResultViewAlbums ()

@end

@implementation ResultViewAlbums

@synthesize myData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style title:(NSString *)title data:(NSArray *)data
{
    self = [super initWithStyle:style];
    if (self) {
        if (nil != data) {
            myData = [[NSMutableArray alloc] initWithArray:data copyItems:YES];
            
//            UIBarButtonItem *btnNewAlbum = [[UIBarButtonItem alloc] initWithTitle:@"New Album" style:UIBarButtonItemStylePlain target:self action:@selector(touchUpNewAlbum)];
//            self.navigationItem.rightBarButtonItem = btnNewAlbum;
//            [btnNewAlbum release];
        }
        self.navigationItem.title = [title retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [myData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[myData objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 2;
    
    // The object's image
    cell.imageView.image = [self imageForObject:[[myData objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    // Do not set current API as this is commonly called by other methods
    NSString *requestString = [[NSString alloc]initWithFormat:@"%@/photos", [[myData objectAtIndex:indexPath.row] objectForKey:@"id"]];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:requestString andDelegate:self];
    [requestString release];
    rowIndex = indexPath.row;
    apiIndex = kAPIRequestPhotos;
}


#pragma mark - Private Methods
/*
 * Helper method to return the picture endpoint for a given Facebook
 * object. Useful for displaying user, friend, or location pictures.
 */
- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/308147165871881/picture",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    [url release];
    return image;
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    if (apiIndex == kAPIRequestPhotos) {
        NSMutableArray *albums = [[NSMutableArray alloc] initWithCapacity:1];
        NSArray *resultData = [result objectForKey:@"data"];
        if ([resultData count] > 0) {
            for (NSUInteger i=0; i<[resultData count]; i++) {
                //if ([[resultData objectAtIndex:i] objectForKey:@"count"] ) {
                [albums addObject:[resultData objectAtIndex:i]];
                //}
                
            }
            
            ResultViewPhotos *controller = [[ResultViewPhotos alloc]initWithStyle:UITableViewStylePlain title:[[myData objectAtIndex:rowIndex] objectForKey:@"name"] data:albums];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
            
        }
    }
    else {
        NSLog(@"OK");
    }
    
    
    NSLog(@"%@",result);
}

- (void)touchUpNewAlbum {
    apiIndex = kAPIRequestNewAlbums;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Ba, Me va Kiddy", @"name",
                                   @"Ba, Me va Kiddy", @"description",
                                   nil];
    [[delegate facebook] requestWithGraphPath:@"me/albums"
                                    andParams:params
                                andHttpMethod:@"POST"
                                  andDelegate:self];
}


@end
