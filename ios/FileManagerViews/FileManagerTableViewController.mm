//
//  FileManagerTableViewController.m
//  PPSSPP
//
//  Created by WinsonWu on 20/3/2018.
//

#import <stdio.h>
#import "FileManagerTableViewController.h"
#import "FileManagerTableViewCell.h"
#import "Util/ShareInfo.h"
#import "ios/GCDWebFileManager.h"

@interface FileManagerTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)doneButtonClick:(id)sender;

@end

@implementation FileManagerTableViewController

- (IBAction)doneButtonClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

NSArray *data;
-(void)viewWillDisappear:(BOOL)animated{
    
    GCDWebFileManager *webFileManager=(GCDWebFileManager*)util::ShareInfo::Instance().GetWebFileManager();
    util::ShareInfo::Instance().UpdateButtonBarLabel( "WebFileManager: " +webFileManager->GetUrl());
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //UINib *nib=[UINib nibWithNibName:@"FileManagerTableViewCell" bundle:nil];
    //[self.tableView registerNib:nib forCellReuseIdentifier:@"all-in-one-cell"];
    
    GCDWebFileManager *webFileManager=(GCDWebFileManager*)util::ShareInfo::Instance().GetWebFileManager();
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    data=@[
           @{
               @"title":@"Web File Server Setting",
               @"data":@[
                       @{
                           @"valueType":[NSNumber numberWithInteger:BOOLEAN],
                           @"label":^(){return @"Auto Start";},
                           @"getValue":^(){return [NSNumber numberWithBool:webFileManager->IsAutoStart()];},
                           @"setValue":^(NSObject *value){
                               webFileManager->SetAutoStart([(NSNumber*)value boolValue]);
                           }
                           },
                       @{
                           @"valueType":[NSNumber numberWithInteger:NUMBER],
                           
                           @"label":^(){return @"Port";},
                           @"getValue":^(){return webFileManager->GetPort();},
                           @"setValue":^(NSObject *value){
                               webFileManager->SetPort((NSNumber*)value);
                           }
                           },
                       ]
               },
           @{
               @"title":@"Running Status",
               @"data":@[
                       @{
                           @"valueType":[NSNumber numberWithInteger:BOOLEAN],
                           @"label":^(){
                               NSString* serverUrl = [NSString stringWithUTF8String:webFileManager->GetUrl().c_str()];
                               return serverUrl;
                           },
                           @"getValue":^(){
                               return [NSNumber numberWithBool:webFileManager->IsRunning()];
                           },
                           @"setValue":^(NSObject *value){
                               if([(NSNumber*)value boolValue]){
                                   webFileManager->Start();
                               }else{
                                   webFileManager->Stop();
                               }
                           }
                           }
                       ]
               
               }
           ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)(data[section][@"data"])).count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return data[section][@"title"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=((NSArray *)(data[indexPath.section][@"data"]))[indexPath.item];
    NSString *rowId=[NSString stringWithFormat: @"%ld_%ld", indexPath.section, indexPath.item];
    rowId=@"all-in-one";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rowId];
    if(cell == nil){
        cell=[[FileManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rowId];
    }
    FileManagerTableViewCell *castedCell=(FileManagerTableViewCell*)cell;
    //FileManagerTableViewCell *castedCell=[[FileManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [castedCell setData:dict];
    return castedCell;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
