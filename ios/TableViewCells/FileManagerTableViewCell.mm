//
//  LabelSwitchTableViewCell.m
//  PPSSPP
//
//  Created by WinsonWu on 20/3/2018.
//

#import "FileManagerTableViewCell.h"


@interface FileManagerTableViewCell ()

@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UITextField *textBox;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (IBAction)onChanged:(id)sender;

@end

@implementation FileManagerTableViewCell
//@synthesize switchButton,textBox,label;
FileManagerTableViewCellValueType _valueType;

-(void) setValueType: (FileManagerTableViewCellValueType)valueType{
    _valueType=valueType;
    [[self switchButton] setHidden:true];
    [[self textBox] setHidden:true];
    switch(_valueType){
        case NONE:
            break;
        case BOOLEAN:
            [[self switchButton] setHidden:false];
            break;
        case TEXT:
        case NUMBER:
            [[self textBox] setHidden:false];
            break;
            
    }
}

NSObject* (^labelValueGetter)(void);

-(void) setLabelValueGetter:(NSObject* (^)(void))getter{
    labelValueGetter=getter;
    [[self textLabel] setText:labelValueGetter()];
}

void (^valueSetter)(NSObject*);
-(void) setValueSetter:(void (^)(NSObject*))setter{
    valueSetter=setter;
}

NSObject* (^valueGetter)(void);
-(void) setValueGetter:(NSObject* (^)(void))getter{
    valueGetter=getter;
}

- (IBAction)onChanged:(id)sender
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchChanged:(id)sender {
}

@end
