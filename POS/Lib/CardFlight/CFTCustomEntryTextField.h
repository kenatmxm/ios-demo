//
//  CustomEntryTextField.h
//  CardFlightLibrary
//
//  Created by Paul Tower on 11/4/13.
//  Copyright (c) 2013 CardFlight Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomEntryTextFieldDelegate <NSObject>

@required
- (void)textFieldFrame:(CGRect)newFrame;

@optional
- (void)textFieldText:(NSString *)newText;
- (void)textFieldTag:(NSInteger)newTag;
- (void)textFieldBackgroundImage:(UIImage *)newBackgroundImage;
- (void)textFieldFont:(UIFont *)newFont;
- (void)textFieldTextColor:(UIColor *)newColor;
- (void)textFieldPlaceholderText:(NSString *)newText;
- (void)textFieldAttributedPlaceholder:(NSAttributedString *)newAttributedPlaceholder;
- (void)textFieldTextAlignment:(NSTextAlignment)newAlignment;
- (void)textFieldBorderStyle:(UITextBorderStyle)newBorder;
- (void)textFieldKeyboardStyle:(UIKeyboardType)newKeyboard;
- (void)textFieldKeyboardAppearance:(UIKeyboardAppearance)newKeyboardAppearance;
- (void)textFieldReturnKeyType:(UIReturnKeyType)newReturnKeyType;
- (void)textFieldResignFirstResponder;

@end

@interface CFTCustomEntryTextField : UIView

@property (nonatomic, weak) id <CustomEntryTextFieldDelegate> delegate;

- (void)customFieldFrame:(CGRect)newFrame;
- (void)customFieldText:(NSString *)newText;
- (void)customFieldTag:(NSInteger)newTag;
- (void)customFieldBackground:(UIImage *)newBackground;
- (void)customFieldFont:(UIFont *)newFont;
- (void)customFieldTextColor:(UIColor *)newColor;
- (void)customFieldPlaceholder:(NSString *)newPlaceholder;
- (void)customFieldAttributedPlaceholder:(NSAttributedString *)newAttributedPlaceholder;
- (void)customFieldTextAlignment:(NSTextAlignment)newAlignment;
- (void)customFieldBorderStyle:(UITextBorderStyle)newBorder;
- (void)customFieldKeyboardType:(UIKeyboardType)newKeyboard;
- (void)customFieldKeyboardAppearance:(UIKeyboardAppearance)newKeyboardAppearance;
- (void)customFieldReturnKeyType:(UIReturnKeyType)newReturnKeyType;
- (void)customFieldResignFirstResponder;

@end
