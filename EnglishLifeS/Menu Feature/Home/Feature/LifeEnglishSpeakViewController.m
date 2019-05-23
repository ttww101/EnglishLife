//
//  LifeEnglishSpeakViewController.m
//  EnglishLife
//
//  Created by Apple on 2019/5/20.
//  Copyright © 2019 YI XIN CHEN. All rights reserved.
//

#import "LifeEnglishSpeakViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LifeEnglishSpeakViewController ()
@property (weak, nonatomic) IBOutlet UIButton *speakBtn;
@property (weak, nonatomic) IBOutlet UITextField *InputText;

@end

@implementation LifeEnglishSpeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self.speakBtn addTarget:self action:@selector(onClickButton:)forControlEvents:UIControlEventTouchDown];
    
}

- (IBAction)onClickButton:(UIButton*)sender {
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:_InputText.text];
    utterance.pitchMultiplier=1.4;
    utterance.volume = 1;
    utterance.postUtteranceDelay = 1;
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.voice = voice;
    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc]init];
    synth.delegate = self;
    [synth speakUtterance:utterance];
}

@end
