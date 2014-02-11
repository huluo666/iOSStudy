//
//  FirstViewController.m
//  iDeal
//
//  Created by igmac0001 on 05/01/2010.
//  Copyright IGIndex 2010. All rights reserved.
//

#import "LoginViewController.h"
#import "Settings.h"
#import "LivePricesViewController.h"
#import "RootTabBarViewController.h"
#import "Properties.h"
#import "Log4Cocoa.h"

#define kHideAlpha 0.0
#define kShowAlpha 1.0
#define kAnimationDuration 2.5

@implementation LoginViewController

@synthesize screenshot;
@synthesize userNameField;
@synthesize passwordField;
@synthesize rememberMeButton;
@synthesize dontRememberMeButton;
@synthesize settings;
//@synthesize authenticationDelegate;
@synthesize authenticationService;
@synthesize loginButton;
@synthesize rotateInfoLabel;

@synthesize fadeInRotateLabelTimer;
@synthesize fadeOutRotateLabelTimer;

#pragma mark -
#pragma mark Finalize 

- (void) dealloc {
	log4Debug(@"Deallocating Login View Controller %i", [authenticationService retainCount]);
	[userNameField release];
	[passwordField release];
	[rememberMeButton release];
	[dontRememberMeButton release];	
	[loginButton release];
	[authenticationService release];
	[rotateInfoLabel release];
	[fadeInRotateLabelTimer release];
	[fadeOutRotateLabelTimer release];
	[progressIndicator release];
    [super dealloc];
}

- (void) didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void) viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.userNameField = nil;
	self.passwordField = nil;
	self.rememberMeButton = nil;
	self.dontRememberMeButton = nil;
	self.loginButton = nil;
	self.rotateInfoLabel = nil;
	self.fadeInRotateLabelTimer = nil;
	self.fadeOutRotateLabelTimer = nil;
	[super viewDidUnload];
}

- (void) viewWillDisappear:(BOOL)animated {
	log4Debug(@"Trying to remove timers");
	[self.fadeInRotateLabelTimer invalidate];
	[self.fadeOutRotateLabelTimer invalidate];	
	[progressIndicator removeFromSuperview];
	self.rotateInfoLabel.alpha = 0.0;
	[super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
	self.rotateInfoLabel.alpha = kHideAlpha;
	[super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Initialisation

- (void) viewDidLoad {
	log4Debug(@"Loading Login Controller");
	//Load Settings 
	self.settings = [Settings sharedInstance];
	
	rememberUserName == NO;
	[dontRememberMeButton setSelected:YES];
	[userNameField setDelegate:self];
	[passwordField setDelegate:self];
	
	//check the saved username
	NSString *savedUserName = [settings getString:kUserName];
	//NSString *savedPassword = [settings getString:kPassword];

	if(savedUserName.length != 0) {
		[userNameField setText:[savedUserName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		//[passwordField setText:[savedPassword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[self doRememberMe];
	}		
	
	//--------------TEST CODE
	//This help me by not having to type in username/password everytime!
	Properties *props = [Properties sharedInstance];
	NSString *value = [props getProperty:@"Environment"];
	if ([value isEqualToString:@"Dev"]) {
		userNameField.text = @"SV295";
		passwordField.text = @"123456";
	}
	
	//--------------TEST CODE
	
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
	
	if ([UIApplication sharedApplication].statusBarHidden == YES) {
		[UIApplication sharedApplication].statusBarHidden = NO;
		self.view.bounds = CGRectMake(0.0, -20.0, 320, 480);
	}
	
	/*
	 Fade in the view
	 */
	self.view.alpha = 0.0;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(animateRotateInfo:finished:context:)];
	self.view.alpha = 1.0;	
	[UIView commitAnimations];
	
	self.screenshot.alpha = 0.0;
	[self.fadeInRotateLabelTimer invalidate];
	[self.fadeOutRotateLabelTimer invalidate];
	
	[super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
	[self beginRotateInfoLabelAnimations];
	[super viewDidAppear:animated];
}

- (void) beginRotateInfoLabelAnimations {
	NSTimer *showRotateInfo = [[NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(fadeInRotateInfoLabel:) userInfo:nil repeats:NO]retain];
	self.fadeInRotateLabelTimer = showRotateInfo;
	[[NSRunLoop currentRunLoop] addTimer:showRotateInfo forMode:NSDefaultRunLoopMode];
	[showRotateInfo release];
}

- (void) fadeInRotateInfoLabel:(NSTimer *)timer {
	//log4Debug(@"Fading info IN");
	//Prepare Animation
	self.screenshot.alpha = kShowAlpha;
	CABasicAnimation *fadeInAnimation = [self fadeAnimation:FADE_IN];
	//fadeInAnimation.removedOnCompletion = NO;
	//fadeInAnimation.fillMode = kCAFillModeForwards;
	
	//Apply animation
	[[self.screenshot layer] addAnimation:fadeInAnimation forKey:@"animateOpacity"];
	
	//Setup a timer to wait before fade out
	NSTimer *hideRotateInfo = [[NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(fadeOutRotateInfoLabel:) userInfo:nil repeats:NO]retain];
	self.fadeOutRotateLabelTimer = hideRotateInfo;
	[[NSRunLoop currentRunLoop] addTimer:hideRotateInfo forMode:NSDefaultRunLoopMode];
	[hideRotateInfo release];
}

- (void) fadeOutRotateInfoLabel:(NSTimer *)timer {
	
	//Rotate

	CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotateAnimation.toValue = [NSNumber numberWithFloat:-0.5*M_PI];
	rotateAnimation.duration = 4.0;
	rotateAnimation.removedOnCompletion = NO;
	rotateAnimation.fillMode = kCAFillModeForwards;
	rotateAnimation.delegate = self;
	[rotateAnimation setValue:@"rotater" forKey:@"name"];
	[self.screenshot.layer addAnimation:rotateAnimation forKey:@"rotateScreenshotAnimation"];
	
	
	//log4Debug(@"Fading info OUT");
	//Prepare Animation
	//CABasicAnimation *fadeOutAnimation = [self fadeAnimation:FADE_OUT];
	
	//Apply Animation
	//[[self.screenshot layer] addAnimation:fadeOutAnimation forKey:@"animateOpacity"];
	
	//Hide completely
	//self.screenshot.alpha = kHideAlpha;	
}

- (void) animationDidStop:(CABasicAnimation *)theAnimation finished:(BOOL)flag {
	if (flag && [[theAnimation valueForKey:@"name"] isEqual:@"rotateScreenshotAnimation"]) {
		[CATransaction begin];
		UIImage *screenshotLandscape = [UIImage imageNamed:@"screenshotLandscape.png"];
		CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
		crossFade.duration = 5.0;
		crossFade.fromValue = screenshot.image.CGImage;
		crossFade.toValue = screenshotLandscape.CGImage;
		[self.screenshot.layer addAnimation:crossFade forKey:@"swapImage"];
		self.screenshot.image = screenshotLandscape;
	}
}

- (CABasicAnimation *) fadeAnimation:(Fade)fade {
	float start;
	float end; 
	switch (fade) {
		case FADE_IN:
			start = kHideAlpha;
			end = kShowAlpha;
			break;
		case FADE_OUT:
			start = kShowAlpha;
			end = kHideAlpha;
			break;
	}
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.duration = kAnimationDuration;
	animation.fromValue = [NSNumber numberWithFloat:start];
	animation.toValue = [NSNumber numberWithFloat:end];
	animation.delegate = self;
	return animation;	
}


//- (void) animateRotateInfo:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:2.0f];
//	self.rotateInfoLabel.alpha = 1.0;
//	//self.rotateInfoLabel.alpha = 0.0;
//	
//	[UIView commitAnimations];
//}


#pragma mark -
#pragma mark UI Actions

- (IBAction) backgroundTap:(id)sender {
	[userNameField resignFirstResponder];
	[passwordField resignFirstResponder];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3f];
	CGAffineTransform slideTransform = CGAffineTransformMakeTranslation(0.0, 0.0);
	self.view.transform = slideTransform;			
	[UIView commitAnimations];
}

- (IBAction) willShowKeyboard:(id)sender {
	log4Debug(@"will show the keyboard");
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3f];
	CGAffineTransform slideTransform = CGAffineTransformMakeTranslation(0.0, -80.0);
	self.view.transform = slideTransform;			
	[UIView commitAnimations];
}


- (IBAction) rememberMe {
	//Need to check that the user really wants this, so display an ActionSheet
	NSString *title = NSLocalizedString(@"login.rememberme.title", @"");
	NSString *yesMsg = NSLocalizedString(@"login.rememberme.yes", @"");
	NSString *noMsg = NSLocalizedString(@"login.rememberme.no", @"");
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
								   initWithTitle:title
								   delegate:self
								   cancelButtonTitle:noMsg
								   destructiveButtonTitle:yesMsg
								   otherButtonTitles:nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (IBAction) dontRememberMe {
	[rememberMeButton setSelected:NO];
	[dontRememberMeButton setSelected:YES];
	rememberUserName = NO;	
	[settings saveString:@"" forKey:kUserName];
	//[settings saveString:@"" forKey:kPassword];
}

- (void) doRememberMe {
	[rememberMeButton setSelected:YES];
	[dontRememberMeButton setSelected:NO];
	rememberUserName = YES;
}



// 	This is called after the user ticks the yes box of the 'remember my username' area, and then the
// 	action sheet 'are you sure' is dismissed
- (void) actionSheet: (UIActionSheet *) actionSheet didDismissWithButtonIndex: (NSInteger) buttonIndex {
	if(buttonIndex != [actionSheet cancelButtonIndex]) {
		[self doRememberMe];
		//TODO - need to add here saving the username to the phone
	}else {
		[self dontRememberMe];
	}

}

- (IBAction) showSecurityWarning {
	NSString *msg = NSLocalizedString(@"login.rememberme.warning", @"");
	NSString *warning = NSLocalizedString(@"warning.title", @"");
	NSString *okMsg	= NSLocalizedString(@"ok.button", @"");
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:warning message:msg delegate:self cancelButtonTitle:okMsg otherButtonTitles:nil];		
	[alert show];
	[alert release];	
}

// 	This enables the interface to move from username to password field without having to reclick
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField == userNameField) {
		[textField resignFirstResponder];
		[passwordField becomeFirstResponder];
	}else if (textField == passwordField) {
		[textField resignFirstResponder];
	}
	return YES;
}

- (IBAction) login:(id) sender {
	

	//Check for blank username
	NSString *usernameText = [userNameField text];	
	
	log4Debug(@"User [%@] is trying to log in", usernameText);
	if ([usernameText length] < 1) {
		[self displayLoginValidationErrorMessage:NSLocalizedString(@"login.failed.nousername", @"")];
		return;
	}
	
	//Check for blank password
	NSString *passwordText = [passwordField text];
	if ([passwordText length] < 1) {
		[self displayLoginValidationErrorMessage:NSLocalizedString(@"login.failed.nopassword", @"")];
		return;
	}
	
	//Remember Me
	if (rememberUserName == YES) {
		[settings saveString:usernameText forKey:kUserName];
		//[settings saveString:passwordText forKey:kPassword];
	}
	
	loginButton.enabled = NO;
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	/*
	 Show connectivity progress
	 */
	// Should be initialized with the windows frame so the HUD disables all user input by covering the entire screen
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
	if (window) { //This would be nil during unit testing
		progressIndicator = [[MBProgressHUD alloc] initWithWindow:window];
		// Add HUD to screen
		[window addSubview:progressIndicator];
		progressIndicator.opacity = 1.0;
		// Show the HUD while the provided method executes in a new thread
		[progressIndicator show:YES];
	}
	
	[authenticationService loginWithUsername:usernameText password:passwordText];		
}

- (void) enableLogin {
	loginButton.enabled = YES;
	[progressIndicator removeFromSuperview];
}

- (void) displayLoginValidationErrorMessage:(NSString *)msg {
	NSString *okMsg	= NSLocalizedString(@"ok.button", @"");
	NSString *title = NSLocalizedString(@"login.failed.title", @"");
	
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:okMsg otherButtonTitles:nil];		
	[alert show];
	[alert release];
}




#pragma mark -
#pragma mark Device Rotation Code

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		return NO;
	}
	
	RootTabBarViewController *tabBarController = (RootTabBarViewController *) [self parentViewController];
	[tabBarController switchModalViewController:SubViewControllerLivePrices];
	return YES;
}



@end
