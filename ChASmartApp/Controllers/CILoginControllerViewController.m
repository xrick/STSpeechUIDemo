//
//  CILoginControllerViewController.m
//  ChASmartApp
//
//  Created by Liao Jiue-Ren on 20/11/2017.
//  Copyright © 2017 Liao Jiue-Ren. All rights reserved.
//

#import "CILoginControllerViewController.h"
#import "CI_Shared_Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "CIJsonProcessor.h"
@interface CILoginControllerViewController ()

@end

@implementation CILoginControllerViewController
@synthesize confirmBtn;
@synthesize birthTxtField;
@synthesize picker;
@synthesize pickerContainer;
@synthesize innerLbl;
@synthesize memStirng;
@synthesize uidTxtField;
@synthesize pwdTxtField;
- (id)initWithFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.view.frame = frame;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.memStirng = @"現職員工";
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc]initWithFrame:CGRectMake(100, 200, 80, 120)];
    confirmBtn.frame = CGRectMake(16, 298, 343, 40); //16 338 | 16,298
    //[confirmBtn setImage:[UIImage imageNamed:@"chat_send_message"] forState:UIControlStateNormal];
    confirmBtn.layer.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1/1.0].CGColor;
    //[confirmBtn setImage:[UIImage imageNamed:@"downside_triangle"] forState:UIControlStateNormal];
    confirmBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [confirmBtn addTarget:self action:@selector(dismissController:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"登入" forState:UIControlStateNormal];
    [confirmBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:confirmBtn];
    
    UIView * memTxtView = [[UIView alloc]initWithFrame:CGRectMake(16, 110, 343, 44)];
    memTxtView.backgroundColor = NavBarBKColor;
    memTxtView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    memTxtView.layer.borderWidth = 1.0f;
    innerLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 80, 40)];
    innerLbl.text = @"現職員工";
    UIButton * innerBtn = [[UIButton alloc]initWithFrame:CGRectMake(308, 12,20, 20)];
    [innerBtn addTarget:self action:@selector(selectMem:) forControlEvents:UIControlEventTouchUpInside];
    innerBtn.backgroundColor = [UIColor clearColor];
    [innerBtn setImage:[UIImage imageNamed:@"downside_triangle"] forState:UIControlStateNormal];
    [memTxtView addSubview:innerLbl];
    [memTxtView addSubview:innerBtn];
    [self.view addSubview:memTxtView];
    
    
    uidTxtField = [[UITextField alloc]initWithFrame:CGRectMake(16, 166, 343, 44)];
    uidTxtField.backgroundColor = NavBarBKColor;
    uidTxtField.placeholder = @"帳號";
    uidTxtField.borderStyle = UITextBorderStyleNone;
    uidTxtField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    uidTxtField.layer.borderWidth= 1.0f;
    [self.view addSubview:uidTxtField];
    
    pwdTxtField = [[UITextField alloc]initWithFrame:CGRectMake(16, 222, 343, 44)];
    pwdTxtField.backgroundColor = NavBarBKColor;
    pwdTxtField.placeholder = @"密碼";
    pwdTxtField.borderStyle = UITextBorderStyleNone;
    pwdTxtField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pwdTxtField.layer.borderWidth= 1.0f;
    
    [self.view addSubview:pwdTxtField];
    
    UIView* barView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 375, 44)];
    barView.backgroundColor = NavBarBKColor;
    UIImageView * navImgView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 5, 164.8, 28)];
    [navImgView setImage:[UIImage imageNamed:@"China_Airlines"]];
    [barView addSubview:navImgView];
    [self.view addSubview:barView];
    
    birthTxtField = [[UITextField alloc]initWithFrame:CGRectMake(16, 278, 343, 44)];
    birthTxtField.backgroundColor = NavBarBKColor;
    birthTxtField.placeholder = @"出生年月日(YYMMDD)";
    birthTxtField.borderStyle = UITextBorderStyleNone;
    birthTxtField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    birthTxtField.layer.borderWidth= 1.0f;
    birthTxtField.hidden = true;
    [self.view addSubview:birthTxtField];
    
    pickerData = @[@"現職員工", @"兼職員工", @"退休員工", @"華信員工"];
    pickerContainer = [[UIView alloc]init];
    pickerContainer.frame = CGRectMake(0, 820, 375, 200);
    
    
//    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]initWithTitle:@"確定" style:UIBarButtonItemStylePlain target:self action:@selector(doneSelection)];
//    NSArray *itemsArray = [NSArray arrayWithObjects:doneButton, nil];
    UIButton * toolBarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    toolBarBtn.layer.backgroundColor = [UIColor clearColor].CGColor;
    [toolBarBtn setTintColor:[UIColor blueColor]];
    toolBarBtn.frame = CGRectMake(310, 3, 40, 30);
    [toolBarBtn setTitle:@"確定" forState:UIControlStateNormal];
    [toolBarBtn addTarget:self action:@selector(doneSelection:) forControlEvents:UIControlEventTouchUpInside];
    UIView * toolbar = [[UIView alloc]init];
    toolbar.backgroundColor = NavBarBKColor;
    toolbar.frame = CGRectMake(0, 5, ApplicationScreenFrame.size.width, 40);
    [toolbar addSubview:toolBarBtn];
//    [toolbar setItems:itemsArray];
    [pickerContainer addSubview:toolbar];
    
    
    
    self.picker = [[UIPickerView alloc]init];
    self.picker.frame = CGRectMake(0, 30, 375, 150); //450 |
    [pickerContainer addSubview:picker];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self.picker reloadAllComponents];
    [self.view addSubview:pickerContainer];
    // Do any additional setup after loading the view.
}

-(void)doneSelection : (UIButton*)sender
{
    NSLog(@"memstring is : %@",self.memStirng);
    //[self.innerLbl setText:memStirng];
    float centerX = self.confirmBtn.center.x;
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerContainer.center = CGPointMake(self.pickerContainer.center.x, 820);
        if([memStirng isEqualToString:@"退休員工"]){
            self.confirmBtn.center = CGPointMake(centerX, 358); //318 | 358
            self.birthTxtField.hidden = false;
        }else{
            self.confirmBtn.center = CGPointMake(centerX, 318); //318 | 358
            self.birthTxtField.hidden = true;
        }
    } completion:^(BOOL finished){
        [self.innerLbl setText:memStirng];
    }];
}

-(void)dismissController:(UIButton*)sender
{
    NSDictionary * argDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"GetUserInfo",@"Command",@"",@"Question",@"TraditionalChinese",@"SourceLanguage",self.uidTxtField.text,@"UserId",self.pwdTxtField.text,@"Password",@"TPEC567",@"OfficeId",@"Datakey",@"RedisDataKey",@"datavalue",@"RedisDataValue",nil];
    NSData * argData = [CIJsonProcessor generatCallApiJSON:argDict withFlag:GetUserInfo];
    NSString * argStr = [[NSString alloc]initWithData:argData encoding:NSUTF8StringEncoding];
    NSLog(@"The call para is %@",argStr);
    NSDictionary * parsedData = [CIJsonProcessor performAPICall:argData];
    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parsedData
                                                       options:0
                                                         error:&error];
    
    NSString * tmpstr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSLog(@"The call result is %@",tmpstr);
    //save data to nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.uidTxtField.text forKey:@"uid"];
    [defaults setObject:self.pwdTxtField.text forKey:@"pwd"];
    [defaults setObject:@"" forKey:@"officeid"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:false];
}

-(void)selectMem:(UIButton*)sender
{
    //if (picker) picker.hidden = !picker.hidden;
    float centerX = self.pickerContainer.center.x;
    NSLog(@"current centerY is %f",self.pickerContainer.center.y);
    [UIView animateWithDuration:0.5 animations:^{
        
        if (pickerContainer.center.y > 650){
            self.pickerContainer.center = CGPointMake(centerX, 590);
        }
        else{
            self.pickerContainer.center = CGPointMake(centerX, 820);
        }
        
//        float centerX = self.confirmBtn.center.x;
//        self.confirmBtn.center = CGPointMake(centerX, 358); //318 | 358
        
    } completion:^(BOOL finished){
//        self.birthTxtField.hidden = false;
//        NSLog(@"x is %f, y is %f",self.confirmBtn.frame.origin.x,confirmBtn.frame.origin.y);
    }];
    /*
    NSLog(@"view is clicked");
    [UIView animateWithDuration:0.5 animations:^{
        
        float centerX = self.confirmBtn.center.x;
        self.confirmBtn.center = CGPointMake(centerX, 358); //318 | 358
        
    } completion:^(BOOL finished){
        self.birthTxtField.hidden = false;
        NSLog(@"x is %f, y is %f",self.confirmBtn.frame.origin.x,confirmBtn.frame.origin.y);
    }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.memStirng = pickerData[row];
    NSLog(@"selected item is %@",memStirng);
    //self.memStirng = pickerView
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
}

@end
