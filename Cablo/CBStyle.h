//
//  CBStyle.h
//  Cablo
//
//  Created by iAppStreet on 08/09/15.
//  Copyright (c) 2015 iAppStreet. All rights reserved.
//

#ifndef Cablo_CBStyle_h
#define Cablo_CBStyle_h


// COLORS and FONTS (Generic)

#define RGB(x, y, z) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1.0]
#define RGBA(x, y, z, a) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:a]
#define GRAYA(x, a) [UIColor colorWithWhite:x alpha:a]
#define GRAY(x) [UIColor colorWithWhite:x alpha:1.0]

#define kRedColor RGB(237.0, 28.0, 36.0)
#define kCustomCyanColor RGB(0.0, 160.0, 172.0)

#define kOffWhiteColor GRAY(0.94)
#define kThinOutlineTransparentColor GRAYA(0.0, 0.3)
#define kBlackFontColor GRAY(0.15)
#define kDarkerGrayFontColor GRAY(0.4)
#define kGrayFontColor GRAY(0.5)
#define kLightGrayColor GRAY(0.6)
#define kLoaderGrayColor GRAY(0.3)
#define kLoaderFont REGULAR(17.0)
#define kTFTitleColor RGB(128.0, 128.0, 128.0)
#define kTFTextColor [UIColor blackColor]


#define kTableViewErrorFont LIGHT(17.0)

#define kHomeOverlayColor GRAYA (0.0, 0.7)

#define kLightFontName @"HelveticaNeue-Light"
#define kRegularFontName @"HelveticaNeue"
#define kMediumFontName @"HelveticaNeue-Medium"
#define kBoldFontName @"HelveticaNeue-Bold"

#define LIGHT(x) [UIFont fontWithName:kLightFontName size:x]
#define REGULAR(x) [UIFont fontWithName:kRegularFontName size:x]
#define MEDIUM(x) [UIFont fontWithName:kMediumFontName size:x]
#define BOLD(x) [UIFont fontWithName:kBoldFontName size:x]


#define kTFLeftViewFont REGULAR(14.0)

// global
#define kItemCornerRadius 4.0
#define kKeyboardAccessoryHeight 44.0f
#define kSeperatorHeight 1.0 / [UIScreen mainScreen].scale
#define kGenericNoteFont LIGHT(13.0)
#define kFloatingButtonFont REGULAR(15.0)
#define kBottomSubviewHeight 250.0f

#define kBlueColor RGB(24.0, 132.0, 232.0)
#define kDarkGrayColor GRAY(0.25)
#define kRecordRedColor RGB(192.0, 57.0, 43.0)

#define kAppBackgroundColor GRAY(0.95)
#define kMainBackgroundColor kAppBackgroundColor

#define kTransparentBorderColor GRAYA(0.0, 0.25)

#define kGenericCornerRadius 5.0


// Table View Generic

#define kTableViewCellMainFont REGULAR(16.0)
#define kTableViewCellMargin 15.0

#define kTableViewSidePadding 16.0
#define kTableViewVerticalPadding 16.0
#define kTableViewInternalPadding 16.0
#define kTableViewLongListPadding 12.0

#define kTableViewUserOTPVerificationFontSize BOLD(20.0)

#define kTableViewPGRegFontSize REGULAR(16.0)
#define kTableViewPGFontSize LIGHT(16.0)
#define kTableViewFirstFont LIGHT(15.0)
#define kTableViewSecondFont LIGHT(14.0)
#define kTableViewThirdFont LIGHT(11.0)
#define kTableViewRightFont REGULAR(15.0)
#define kNavBarTitleFont REGULAR(19.0)
#define kTableSectionHeaderFont REGULAR(14.0)

#define kTableViewCenterRightFont REGULAR(15.0)
#define kTableViewCenterLeftFont LIGHT(15.0)
#define kTableViewCenterRightLargeFont MEDIUM(15.0)
#define kTableViewCenterLeftLargeFont REGULAR(15.0)
#define kTableViewBigFont LIGHT(16.0)

#define kTextFieldFont REGULAR(16.0)

#define kTableViewSmallPadding 8.0
#define kTableViewMediumPadding 16.0
#define kTableViewLargePadding 24.0

// Margins and Width
#define kLoaderViewTopPadding 16.0

#define kLOBSeparatorMargin 20.0
#define kLOBBigContentWidth 280.0

// Side menu

#define kSideMenuBgColor GRAYA(1.0, 0.5)
#define kSideMenuSelectionColor GRAY(0.75)
#define kSideMenuWidth 260.0


//textfield font
#define kTFTitleFont LIGHT(14.0)
#define kTFBigTitleFont LIGHT(18.0)
#define kTFTitleTextFieldHeight 40.0
#define kTFTitleAndFieldPadding (kTableViewSmallPadding)

//others
#define kRightButtonIcon @"❭"

// toast
#define kBigContentWidth 280.0

#endif
