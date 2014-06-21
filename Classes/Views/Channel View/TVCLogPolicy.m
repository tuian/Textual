/* ********************************************************************* 
       _____        _               _    ___ ____   ____
      |_   _|___  _| |_ _   _  __ _| |  |_ _|  _ \ / ___|
       | |/ _ \ \/ / __| | | |/ _` | |   | || |_) | |
       | |  __/>  <| |_| |_| | (_| | |   | ||  _ <| |___
       |_|\___/_/\_\\__|\__,_|\__,_|_|  |___|_| \_\\____|

 Copyright (c) 2008 - 2010 Satoshi Nakagawa <psychs AT limechat DOT net>
 Copyright (c) 2010 — 2014 Codeux Software & respective contributors.
     Please see Acknowledgements.pdf for additional information.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Textual IRC Client & Codeux Software nor the
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

#import "TextualApplication.h"

/* The actual tag value for the Inspect Element item is in a private
 enum in WebKit so we have to define it based on whatever version of
 WebKit is on the OS. */
#define _WebMenuItemTagInspectElementLion			2024
#define _WebMenuItemTagInspectElementMountainLion	2025

#define _WebMenuItemTagIRCopServices	42354

@implementation TVCLogPolicy

- (void)webView:(TVCLogView *)sender mouseDidMoveOverElement:(NSDictionary *)elementInformation modifierFlags:(NSUInteger)modifierFlags
{
	NSAssertReturn([TPCPreferences copyOnSelect]);
	
	NSEvent *currentEvent = [NSApp currentEvent];
	
	if (([currentEvent modifierFlags] & NSCommandKeyMask) == NSCommandKeyMask) {
		return;
	}
	
	if ([currentEvent type] == NSLeftMouseUp) {
		if ([sender hasSelection]) {
			[NSApp sendAction:@selector(copy:) to:[[NSApp mainWindow] firstResponder] from:self];
		
			[sender clearSelection];
		}
	}
}

- (NSUInteger)webView:(WebView *)sender dragDestinationActionMaskForDraggingInfo:(id)draggingInfo
{
	return WebDragDestinationActionNone;
}

- (void)channelDoubleClicked
{
	[menuController() setPointedChannelName:_channelName];

	_channelName = nil;
	
	[menuController() joinClickedChannel:nil];
}

- (void)nicknameDoubleClicked
{
	[menuController() setPointedNickname:_nickname];

	_nickname = nil;
	
	[menuController() memberInChannelViewDoubleClicked:nil];
}

- (void)topicDoubleClicked
{
    [menuController() showChannelTopicDialog:nil];
}

- (NSArray *)webView:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element defaultMenuItems:(NSArray *)defaultMenuItems
{
	TVCMainWindowNegateActionWithAttachedSheetR(@[]);
	
	NSMutableArray *ary = [NSMutableArray array];

	/* Invalidate passed information if we are in console. */
	TVCLogController *controller = [worldController() selectedViewController];
	
	if ([controller associatedChannel] == nil) {
		_nickname = nil;
	}
	
	if (_anchorURL)
	{
		[menuController() setPointedUrl:_anchorURL];
		
		_anchorURL = nil;

		NSMenu *urlMenu = [menuController() tcopyURLMenu];
		
		for (NSMenuItem *item in [urlMenu itemArray]) {
			[ary addObject:[item copy]];
		}
		
		return ary;
	}
	else if (_nickname)
	{
		[menuController() setPointedNickname:_nickname];

		_nickname = nil;

		BOOL isIRCop = [[worldController() selectedClient] hasIRCopAccess];

		NSMenu *memberMenu = [menuController() userControlMenu];
		
		for (NSMenuItem *item in [memberMenu itemArray]) {
			if ([item tag] == _WebMenuItemTagIRCopServices && isIRCop == NO) {
				continue;
			}
			
			[ary addObject:[item copy]];
		}
		
		return ary;
	}
	else if (_channelName)
	{
		[menuController() setPointedChannelName:_channelName];
		
		_channelName = nil;

		NSMenu *chanMenu = [menuController() joinChannelMenu];
		
		for (NSMenuItem *item in [chanMenu itemArray]) {
			[ary addObject:[item copy]];
		}
		
		return ary;
	}
	else
	{
		NSMenu *menu = [menuController() channelViewMenu];
		
		NSMenuItem *inspectElementItem		= nil;
		NSMenuItem *lookupInDictionaryItem	= nil;
		
		for (NSMenuItem *item in defaultMenuItems) {
			if ([item tag] == WebMenuItemTagLookUpInDictionary) {
				lookupInDictionaryItem = item;
			} else if ([item tag] == _WebMenuItemTagInspectElementLion ||
					   [item tag] == _WebMenuItemTagInspectElementMountainLion)
			{
				inspectElementItem = item;
			}
		}
		
		for (NSMenuItem *item in [menu itemArray]) {
			if ([item tag] == _WebMenuItemTagInspectElementLion ||
				[item tag] == _WebMenuItemTagInspectElementMountainLion)
			{
				if (lookupInDictionaryItem) {
					[ary addObject:[lookupInDictionaryItem copy]];
				}
			} else {
				[ary addObject:[item copy]];
			}
		}
		
		if ([RZUserDefaults() boolForKey:TXDeveloperEnvironmentToken]) {
			[ary addObject:[NSMenuItem separatorItem]];
			
			if (inspectElementItem) {
				[ary addObject:[inspectElementItem copy]];
			}

			NSMenuItem *newItem1 = [NSMenuItem menuItemWithTitle:BLS(1018) target:menuController() action:@selector(copyLogAsHtml:)];
			NSMenuItem *newItem2 = [NSMenuItem menuItemWithTitle:BLS(1019) target:menuController() action:@selector(forceReloadTheme:)];

			[ary addObject:newItem1];
			[ary addObject:newItem2];
		}
		
		return ary;
	}
	
	return defaultMenuItems;
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id <WebPolicyDecisionListener>)listener
{
	NSInteger action = [actionInformation integerForKey:WebActionNavigationTypeKey];

	if (action == WebNavigationTypeLinkClicked) {
		[listener ignore];

		[TLOpenLink open:actionInformation[WebActionOriginalURLKey]];
	} else if (action == WebNavigationTypeOther) {
		[listener use];
	} else {
		[listener use];
	}
}

@end
