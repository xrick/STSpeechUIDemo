//
//  FileOps.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 16/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "FileOps.h"

@implementation FileOps
@synthesize fileMgr;
@synthesize homeDir;
@synthesize filename;
@synthesize filepath;


-(NSString *) setFilename
{
    filename = @"Nan_Set";
    return filename;
}

/*
 Get a handle on the directory where to write and read our files. If
 it doesn't exist, it will be created.
 */

-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return homeDir;
}


/*Create a new file*/
-(void)WriteToStringFile:(NSMutableString *)textToWrite{
    filepath = [[NSString alloc] init];
    NSError *err;
    
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    BOOL ok = [textToWrite writeToFile:filepath atomically:YES encoding:NSUnicodeStringEncoding error:&err];
    
    if (!ok) {
        NSLog(@"Error writing file at %@\n%@",
              filepath, [err localizedFailureReason]);
    }
    
}
/*
 Read the contents from file
 */
-(NSString *) readFromFile
{
    filepath = [[NSString alloc] init];
    NSError *error;
    NSString *title;
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    NSString *txtInFile = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUnicodeStringEncoding error:&error];
    
    if(!txtInFile)
    {
        UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:title message:@"Unable to get text from file." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [tellErr show];
    }
    return txtInFile;
}
@end

/************* How to Use **********/
/*
#import "kcbViewController.h"
#import "FileOps.h"

@implementation kcbViewController
@synthesize displayTxtFromFile;
@synthesize writeSomethingField;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setWriteSomethingField:nil];
    [self setDisplayTxtFromFile:nil];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)saveTextToFile:(id)sender {
    
    FileOps *files = [[FileOps alloc] init];
    
    [files WriteToStringFile:[self.writeSomethingField.text mutableCopy]];
    
    
}
-(BOOL) textFieldShouldReturn:(UITextField *) aTxtFld{
    if(aTxtFld==self.writeSomethingField)
    {
        [aTxtFld resignFirstResponder];
    }
    
    return YES;
}
- (IBAction)getFromFile:(id)sender {
    FileOps *readFile = [[FileOps alloc] init];
    self.displayTxtFromFile.text = [readFile readFromFile];
}

*/
/***********************************************/
