//
//  LabelSwitchTableViewCell.m
//  PPSSPP
//
//  Created by WinsonWu on 20/3/2018.
//

#import "FileManagerTableViewCell.h"


@interface FileManagerTableViewCell ()

@property (strong, nonatomic) UISwitch *switchButton;
@property (strong, nonatomic) UITextField *textBox;

@property void (^valueSetter)(NSObject*);
@property id (^valueGetter)(void);
@property id (^labelValueGetter)(void);

- (IBAction)onChanged:(id)sender;

@end

@implementation FileManagerTableViewCell
@synthesize switchButton,textBox;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.switchButton=[[UISwitch alloc] init];
    self.textBox=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    float appWidth = CGRectGetWidth([UIScreen mainScreen].applicationFrame);
    
    UIToolbar *accessoryView = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0, 0, appWidth, 40)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                              target:nil
                              action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                             target:self
                             action:@selector(selectDoneButton:)];
    
    accessoryView.items = @[space, space, done];
    self.textBox.inputAccessoryView = accessoryView;
    [self.textBox setDelegate:self];
    //[self.textBox setInputDelegate:self];
    [self.textBox setTextAlignment:NSTextAlignmentRight];
    [self.textBox setKeyboardType:UIKeyboardTypeNumberPad];
    [self.textBox setReturnKeyType:UIReturnKeyDone];
    [self.textBox setEnablesReturnKeyAutomatically:YES];
    //[self.inputAccessoryView]
    [self.detailTextLabel setHidden:YES];
    [self.switchButton addTarget:self action:@selector(onChanged:) forControlEvents:UIControlEventValueChanged];
    //[self setAccessoryType: UITableViewCellAccessoryNone];
    //[self.contentView addSubview:self.switchButton];
    //[self.contentView addSubview:self.textBox];
    return self;
}

- (void)selectDoneButton:(id)sender {
    [self.textBox resignFirstResponder];
    [self onChanged:self.textBox];
}
-(void) setData:(NSDictionary *) data{
    /******
     @"valueType":[NSNumber numberWithInteger:BOOLEAN],
     @"label":^(){return @"Auto Start";},
     @"getValue":^(){return @true;},
     @"setValue":^(NSObject *value){}
     *****/
   
//    [self.switchButton setHidden:true];
//    [self.textBox setHidden:true];
    
    int value=[(NSNumber*)data[@"valueType"] intValue];
    
    self.labelValueGetter=data[@"label"];
    self.valueGetter=data[@"getValue"];
    self.valueSetter=data[@"setValue"];
    NSString *lbl=self.labelValueGetter();
    [self.textLabel setText:lbl];
    switch((FileManagerTableViewCellValueType)value){
        case NONE:
            break;
        case BOOLEAN:{
            self.accessoryView=self.switchButton;
            //[self.switchButton setHidden:false];
            NSNumber *valObj=(NSNumber*)self.valueGetter();
            NSLog(@"BOOL, %@:%@",lbl,valObj);
            [self.switchButton setOn:[valObj boolValue]];
        }
            break;
        case TEXT:
        case NUMBER:
        {
            self.accessoryView=self.textBox;
            //[self.textBox becomeFirstResponder];
            //[self.textBox setHidden:false];
            NSNumber *valObj=(NSNumber*)self.valueGetter();
            NSLog(@"NUMBER, %@:%@",lbl,valObj);
            [self.textBox setText:[NSString stringWithFormat:@"%@",valObj]];
        }
            break;
            
    }
}

- (void)onChanged:(id)sender
{
    if(sender==self.switchButton){
        NSNumber *newValue=[NSNumber numberWithBool:switchButton.isOn];
        self.valueSetter(newValue);
        NSNumber *realValue=(NSNumber*)self.valueGetter();
        if(newValue!=realValue){
            [self.switchButton setOn:[realValue boolValue] animated:YES];
        }else{
            [self.textLabel setText:self.labelValueGetter()];
        }
    }else if (sender==self.textBox){
        NSNumber *newValue=[NSNumber numberWithInteger:[self.textBox.text integerValue]];
        self.valueSetter(newValue);
    }
}

@end
