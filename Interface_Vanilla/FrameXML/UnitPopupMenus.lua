---------------------------- Main Menus ----------------------------------------------
function UnitPopupMenuSelf:GetMenuButtons()
	return {
		UnitPopupRaidTargetButtonMixin, 
		UnitPopupSetFocusButtonMixin,
		UnitPopupPvpFlagButtonMixin,
		UnitPopupLootSubsectionTitle,
		UnitPopupLootMethodButtonMixin,
		UnitPopupLootThresholdButtonMixin,
		UnitPopupOptOutLootTitleMixin,
		UnitPopupLootPromoteButtonMixin,
		UnitPopupInstanceSubsectionTitle,
		UnitPopupConvertToRaidButtonMixin,
		UnitPopupConvertToPartyButtonMixin,
		UnitPopupDungeonDifficultyButtonMixin,
		UnitPopupRaidDifficultyButtonMixin, 
		UnitPopupResetInstancesButtonMixin,
		UnitPopupOtherSubsectionTitle,
		UnitPopupVoiceChatButtonMixin, 
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupPartyInstanceLeaveButtonMixin,
		UnitPopupPartyLeaveButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end

UnitPopupMenuFriendlyPlayerInteract = CreateFromMixins(UnitPopupTopLevelMenuMixin);
function UnitPopupMenuFriendlyPlayerInteract:GetMenuButtons()
	return {
		UnitPopupWhisperButtonMixin,
		UnitPopupInspectButtonMixin, 
		UnitPopupAchievementButtonMixin,
		UnitPopupTradeButtonMixin, 
		UnitPopupFollowButtonMixin,
		UnitPopupDuelButtonMixin,
		UnitPopupDuelToTheDeathButtonMixin,
		UnitPopupPetBattleDuelButtonMixin,
	}
end 

function UnitPopupMenuParty:GetMenuButtons()
	return {
		UnitPopupMenuFriendlyPlayer, --This is a submenu
		UnitPopupRafSummonButtonMixin,
		UnitPopupRafGrantLevelButtonMixin,
		UnitPopupPromoteButtonMixin,
		UnitPopupPromoteGuideButtonMixin,
		UnitPopupLootPromoteButtonMixin,
		UnitPopupMenuFriendlyPlayerInteract, --This is a submenu
		UnitPopupOtherSubsectionTitle,
		UnitPopupVoiceChatButtonMixin, 
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupReportGroupMemberButtonMixin,
		UnitPopupPvpReportGroupMemberButtonMixin,
		UnitPopupCopyCharacterNameButtonMixin,
		UnitPopupPvpReportAfkButtonMixin,
		UnitPopupVoteToKickButtonMixin,
		UnitPopupUninviteButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end

function UnitPopupMenuEnemyPlayer:GetMenuButtons()
	return {
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupReportInWorldButtonMixin,
		UnitPopupCopyCharacterNameButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end

function UnitPopupMenuRaidPlayer:GetMenuButtons()
	return {
		UnitPopupMenuFriendlyPlayer, --This is a subMenu
		UnitPopupRafSummonButtonMixin,
		UnitPopupRafGrantLevelButtonMixin,
		UnitPopupSetRaidLeaderButtonMixin,
		UnitPopupSetRaidAssistButtonMixin, 
		UnitPopupSetRaidDemoteButtonMixin,
		UnitPopupLootPromoteButtonMixin,
		UnitPopupMenuFriendlyPlayerInteract, --This is a subMenu
		UnitPopupOtherSubsectionTitle,
		UnitPopupVoiceChatButtonMixin, 
		UnitPopupMovePlayerFrameButtonMixin,
		UnitPopupMoveTargetFrameButtonMixin,
		UnitPopupReportGroupMemberButtonMixin,
		UnitPopupPvpReportGroupMemberButtonMixin,
		UnitPopupCopyCharacterNameButtonMixin,
		UnitPopupPvpReportAfkButtonMixin,
		UnitPopupVoteToKickButtonMixin,
		UnitPopupSetRaidRemoveButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end

function UnitPopupMenuBnFriend:GetMenuButtons()
	return { 
		UnitPopupPopoutChatButtonMixin,
		UnitPopupBnetTargetButtonMixin,
		UnitPopupSetBNetNoteButtonMixin, 
		UnitPopupViewBnetFriendsButtonMixin,
		UnitPopupInteractSubsectionTitle,
		UnitPopupBnetInviteButtonMixin,
		UnitPopupBnetSuggestInviteButtonMixin,
		UnitPopupBnetRequestInviteButtonMixin,
		UnitPopupWhisperButtonMixin,
		UnitPopupOtherSubsectionTitle,
		UnitPopupDeleteCommunityMessageButtonMixin,
		UnitPopupRemoveBnetFriendButtonMixin,
		UnitPopupReportFriendButtonMixin,
		UnitPopupReportChatButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end 

function UnitPopupMenuBnFriendOffline:GetMenuButtons()
	return { 
		UnitPopupSetBNetNoteButtonMixin, 
		UnitPopupViewBnetFriendsButtonMixin,
		UnitPopupOtherSubsectionTitle,
		UnitPopupRemoveBnetFriendButtonMixin,
		UnitPopupReportFriendButtonMixin,
		UnitPopupCancelButtonMixin,
	}
end

function UnitPopupMenuCommunitiesWowMember:GetMenuButtons()
	return {
		UnitPopupAddFriendMenuButtonMixin, 
		UnitPopupSubsectionSeperatorMixin, 
		UnitPopupVoiceChatMicrophoneVolumeButtonMixin, 
		UnitPopupVoiceChatSpeakerVolumeButtonMixin,
		UnitPopupVoiceChatUserVolumeButtonMixin,
		UnitPopupMenuFriendlyPlayerInviteOptions, --Submenu
		UnitPopupWhisperButtonMixin,
		UnitPopupIgnoreButtonMixin,
		UnitPopupCommunitiesLeaveButtonMixin,
		UnitPopupCommunitiesKickFriendButtonMixin,
		UnitPopupCommunitiesMemberNoteButtonMixin,
		UnitPopupCommunitiesRoleButtonMixin,
		UnitPopupOtherSubsectionTitle,
		UnitPopupReportClubMemberButtonMixin,
		UnitPopupCopyCharacterNameButtonMixin,
		UnitPopupCancelButtonMixin, 
	}
end

function UnitPopupMenuCommunitiesGuildMember:GetMenuButtons()
	return {
		UnitPopupVoiceChatMicrophoneVolumeButtonMixin, 
		UnitPopupVoiceChatSpeakerVolumeButtonMixin,
		UnitPopupVoiceChatUserVolumeButtonMixin,
		UnitPopupSubsectionSeperatorMixin, 
		UnitPopupMenuFriendlyPlayerInviteOptions, --Submenu
		UnitPopupWhisperButtonMixin,
		UnitPopupIgnoreButtonMixin,
		UnitPopupOtherSubsectionTitle,
		UnitPopupGuildPromoteButtonMixin,
		UnitPopupGuildLeaveButtonMixin,
		UnitPopupReportClubMemberButtonMixin,
		UnitPopupCopyCharacterNameButtonMixin,
		UnitPopupCancelButtonMixin, 
	}
end