CAMPAIGN_QUEST_TRACKER_MODULE = ObjectiveTracker_GetModuleInfoTable("CAMPAIGN_QUEST_TRACKER_MODULE", QUEST_TRACKER_MODULE);
CAMPAIGN_QUEST_TRACKER_MODULE.updateReasonModule = OBJECTIVE_TRACKER_UPDATE_MODULE_QUEST;
CAMPAIGN_QUEST_TRACKER_MODULE.updateReasonEvents = OBJECTIVE_TRACKER_UPDATE_QUEST + OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED;

CAMPAIGN_QUEST_TRACKER_MODULE:SetHeader(ObjectiveTrackerFrame.BlocksFrame.CampaignQuestHeader, TRACKER_HEADER_CAMPAIGN_QUESTS, OBJECTIVE_TRACKER_UPDATE_QUEST_ADDED);

function CAMPAIGN_QUEST_TRACKER_MODULE:ShouldDisplayQuest(quest)
	return quest:IsCampaign() and not quest:IsDisabledForSession();
end