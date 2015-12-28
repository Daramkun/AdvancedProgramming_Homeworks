//
//  WordListTableViewController.m
//  Vocabulous
//
//  Created by 다람군 on 12. 4. 18..
//  Copyright 2012년 __MyCompanyName__. All rights reserved.
//

#import "WordListTableViewController.h"
#import "DefinitionViewController.h"

@interface WordListTableViewController()

@property (nonatomic, readonly) NSMutableDictionary * words;
@property (nonatomic, readonly) NSArray * sections;

@end

@implementation WordListTableViewController

@synthesize words, sections;

- (NSMutableDictionary*) words
{
    if(!words)
    {
        NSString * plistPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"vocawords.txt"];
        words = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] retain];
    }
    return words;
}

- (NSArray*) sections
{
    if(!sections)
    {
        sections = [[[self.words allKeys] sortedArrayUsingSelector:@selector(compare:)] retain];
    }
    return sections;
}

- (void) dealloc
{
    [sections release];
    [words release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray * wordsInSection = [self.words objectForKey:[self.sections objectAtIndex:section]];
    return wordsInSection.count;
}

- (NSString*) wordAtIndexPath:(NSIndexPath*) indexPath
{
    NSArray * wordsInSection = [self.words objectForKey:[self.sections objectAtIndex:indexPath.section]];
    return [wordsInSection objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierDefault = @"WordListTableViewCellDefault";
    static NSString *CellIdentifierSubtitle = @"WordListTableViewCellSubtitle";
    static NSString *CellIdentifierValue1 = @"WordListTableViewCellValue1";
    static NSString *CellIdentifierValue2 = @"WordListTableViewCellValue2";
    
    UITableViewCellStyle cellStyle;
    NSString * CellIdentifier;
    switch(indexPath.row % 4)
    {
        case 0:
            cellStyle = UITableViewCellStyleDefault;
            CellIdentifier = CellIdentifierDefault;
            break;
        case 1:
            cellStyle = UITableViewCellStyleSubtitle;
            CellIdentifier = CellIdentifierSubtitle;
            break;
        case 2:
            cellStyle = UITableViewCellStyleValue1;
            CellIdentifier = CellIdentifierValue1;
            break;
        case 3:
            cellStyle = UITableViewCellStyleValue2;
            CellIdentifier = CellIdentifierValue2;
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self wordAtIndexPath:indexPath];
    cell.detailTextLabel.text = @"SubTitle";
    UIImage *image = [UIImage imageNamed:@"0425-prec.jpg"];
    cell.imageView.image = image;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    DefinitionViewController * dvc = [[DefinitionViewController alloc] init];
    dvc.word = [self wordAtIndexPath:indexPath];
    [self.navigationController pushViewController:dvc animated:TRUE];
    [dvc release];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Footer for %@", [self.sections objectAtIndex:section]];
}

@end
