//
//  LabelSwitchTableViewCell.h
//  PPSSPP
//
//  Created by WinsonWu on 20/3/2018.
//

#import <UIKit/UIKit.h>

typedef enum FileManagerTableViewCellValueType : int {
    NONE=0,
    BOOLEAN=1,
    TEXT=2,
    NUMBER=3
} FileManagerTableViewCellValueType;

@interface FileManagerTableViewCell : UITableViewCell
-(void) setValueType: (FileManagerTableViewCellValueType)valueType;
-(void) setLabelValueGetter:(NSObject* (^)(void))getter;
-(void) setValueSetter:(void (^)(NSObject*))setter;
-(void) setValueGetter:(NSObject* (^)(void))getter;

@end
