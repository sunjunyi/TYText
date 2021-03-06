//
//  AttributedDemoViewController.m
//  TYTextKitDemo
//
//  Created by tany on 2017/9/25.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "AttributedDemoViewController.h"
#import "TYLabel.h"

@interface AttributedDemoViewController ()<TYLabelDelegate>

@property (nonatomic, strong) TYLabel *label;
@property (nonatomic, strong) TYLabel *label1;
@property (nonatomic, assign) BOOL layouted;

@end

@implementation AttributedDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"change" style:UIBarButtonItemStyleDone target:self action:@selector(changeAction)];
    [self addLabel];
    [self addLabel1];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_layouted) {
        return;
    }
    CGFloat originY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    _label.frame = CGRectMake(0, originY, CGRectGetWidth(self.view.frame), 200);
    _label1.frame = CGRectMake(0, CGRectGetMaxY(_label.frame)+80, CGRectGetWidth(self.view.frame), 400);
    if (originY > 0) {
        _layouted = YES;
    }
}

- (void)addLabel {
    TYLabel *label = [[TYLabel alloc]init];
    label.displaysAsynchronously = NO;
    label.delegate = self;
    label.backgroundColor = [UIColor lightGrayColor];
    label.attributedText = [self addAttribuetedString];
    label.numberOfLines = 2;
    label.truncationToken = [self truncationToken];
    [self.view addSubview:label];
    _label = label;
}

- (void)addLabel1 {
    TYLabel *label = [[TYLabel alloc]init];
    
    [self.view addSubview:label];
    _label1 = label;
}

- (NSAttributedString *)addAttribuetedString {
    NSString *str = @"async display http://www.baidu.com ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐🚋🎊😡🚖🚌💖💗💛💙🏨✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊😡🚖🚌💖💗💛💙🏨";
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    text.ty_lineSpacing = 2;
    //text.ty_strokeWidth = -2;
    //text.ty_strokeColor = [UIColor redColor];
    //text.ty_lineHeightMultiple = 1.0;
    //text.ty_maximumLineHeight = 12;
    //text.ty_minimumLineHeight = 12;
    TYTextAttribute *textAttribute = [[TYTextAttribute alloc]init];
    textAttribute.color = [UIColor blueColor];
    [text addTextAttribute:textAttribute range:[str rangeOfString:@"http://www.baidu.com"]];
    TYTextHighlight *textHighlight = [[TYTextHighlight alloc]init];
    textHighlight.color = [UIColor orangeColor];
    textHighlight.backgroundColor = [UIColor redColor];
    [text addTextHighlightAttribute:textHighlight range:[str rangeOfString:@"http://www.baidu.com"]];
    
    TYTextAttachment *attachment = [[TYTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"avatar"];
    attachment.bounds = CGRectMake(0, 0, 60, 60);
    //attachment.verticalAlignment = TYAttachmentAlignmentCenter;
    [text insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:text.length/2];
    attachment = [[TYTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"avatar"];
    attachment.size = CGSizeMake(20, 20);
    attachment.verticalAlignment = TYAttachmentAlignmentCenter;
    [text appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    TYTextAttachment *attachmentView = [[TYTextAttachment alloc]init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"button" forState:UIControlStateNormal];
    attachmentView.view = button;
    attachmentView.view.backgroundColor = [UIColor redColor];
    attachmentView.size = CGSizeMake(60, 20);
    attachmentView.verticalAlignment = TYAttachmentAlignmentCenter;
    [text appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachmentView]];
    text.ty_font = [UIFont systemFontOfSize:15];
    text.ty_characterSpacing = 2;
    return text;
}

- (NSAttributedString *)truncationToken {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...全文"];
    text.ty_font = [UIFont systemFontOfSize:16];
    [text ty_addColor:[UIColor redColor] range:[text.string rangeOfString:@"全文"]];
    TYTextHighlight *textHighlight = [[TYTextHighlight alloc]init];
    textHighlight.color = [UIColor blueColor];
    textHighlight.tag = 1000;
    [text addTextHighlightAttribute:textHighlight range:[text.string rangeOfString:@"全文"]];
    text.ty_characterSpacing = 2;
    return text;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeAction {
    _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y+ 10, _label.frame.size.width - 20, _label.frame.size.height);
}

- (void)label:(TYLabel *)label didTappedTextHighlight:(TYTextHighlight *)textHighlight {
    NSLog(@"didTappedTextHighlight");
    if (textHighlight.tag == 1000) {
        _label.numberOfLines = 0;
    }
}

- (void)label:(TYLabel *)label didLongPressedTextHighlight:(TYTextHighlight *)textHighlight {
    NSLog(@"didLongPressedTextHighlight");
}


@end
