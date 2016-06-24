/* ********************************************************************* 
                  _____         _               _
                 |_   _|____  _| |_ _   _  __ _| |
                   | |/ _ \ \/ / __| | | |/ _` | |
                   | |  __/>  <| |_| |_| | (_| | |
                   |_|\___/_/\_\\__|\__,_|\__,_|_|

 Copyright (c) 2010 - 2016 Codeux Software, LLC & respective contributors.
        Please see Acknowledgements.pdf for additional information.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Textual and/or "Codeux Software, LLC", nor the 
      names of its contributors may be used to endorse or promote products 
      derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.

 *********************************************************************** */

@class TVCLogControllerOperationQueue;
@class TVCMemberListMavericksDarkUserInterface;
@class TVCMemberListMavericksLightUserInterface;
@class TVCMemberListUserInfoPopover;

#import "TextualApplication.h"

#import "BuildConfig.h"
#import "GCDAsyncSocketCipherNames.h"
#import "GCDAsyncSocketExtensions.h"
#import "IRCConnectionPrivate.h"
#import "IRCHighlightLogEntryPrivate.h"
#import "IRCTreeItemPrivate.h"
#import "IRCUserPrivate.h"
#import "IRCWorldPrivate.h"
#import "IRCWorldPrivateCloudExtension.h"
#import "NSObjectHelperPrivate.h"
#import "NSTableVIewHelperPrivate.h"
#import "NSViewHelperPrivate.h"
#import "THOPluginDispatcherPrivate.h"
#import "THOPluginItemPrivate.h"
#import "THOPluginManagerPrivate.h"
#import "THOPluginProtocolPrivate.h"
#import "TLOLicenseManager.h"
#import "TPCApplicationInfoPrivate.h"
#import "TPCPathInfoPrivate.h"
#import "TPCPreferencesCloudSyncPrivate.h"
#import "TPCPreferencesImportExportPrivate.h"
#import "TPCPreferencesPrivate.h"
#import "TPCPreferencesUserDefaultsMigratePrivate.h"
#import "TPCPreferencesUserDefaultsPrivate.h"
#import "TPCResourceManagerPrivate.h"
#import "TPCThemeControllerPrivate.h"
#import "TPCThemeSettingsPrivate.h"
#import "TVCImageURLoaderPrivate.h"
#import "TVCLogControllerHistoricLogFilePrivate.h"
#import "TVCLogControllerOperationQueuePrivate.h"
#import "TVCLogControllerPrivate.h"
#import "TVCLogLinePrivate.h"
#import "TVCLogPolicyPrivate.h"
#import "TVCLogScriptEventSinkPrivate.h"
#import "TVCLogViewInternalWK1.h"
#import "TVCLogViewInternalWK2.h"
#import "TVCLogViewPrivate.h"
#import "TVCMainWindowPrivate.h"
#import "TVCMainWindowSidebarSmoothTextFieldPrivate.h"
#import "TVCMainWindowTextViewMavericksUserInteracePrivate.h"
#import "TVCMainWindowTextViewYosemiteUserInteracePrivate.h"
#import "TVCMemberListCellPrivate.h"
#import "TVCMemberListMavericksUserInterfacePrivate.h"
#import "TVCMemberListPrivate.h"
#import "TVCMemberListSharedUserInterfacePrivate.h"
#import "TVCMemberListUserInfoPopoverPrivate.h"
#import "TVCMemberListYosemiteUserInterfacePrivate.h"
#import "TVCServerListCellPrivate.h"
#import "TVCServerListMavericksUserInterfacePrivate.h"
#import "TVCServerListPrivate.h"
#import "TVCServerListSharedUserInterfacePrivate.h"
#import "TVCServerListYosemiteUserInterfacePrivate.h"
#import "TVCTextFormatterMenuPrivate.h"
#import "TVCTextViewWithIRCFormatterPrivate.h"
#import "TXGlobalModelsPrivate.h"
#import "TXSharedApplicationPrivate.h"
#import "TextualApplication.h"
#import "WebScriptObjectHelperPrivate.h"