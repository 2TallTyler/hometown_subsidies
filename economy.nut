require("company.nut");

class Economy
{
	companies_list = [];
    subsidy_list = [];

    constructor() {
        subsidy_list = GSSubsidyList();
    }

    function AddCompany(id)
    {
        RemoveCompanyIfExists(id);
        AppendCompany(id);
    }

    function RemoveCompanyIfExists(id)
    {
        for(local i = 0; i < this.companies_list.len(); i++) {
            if(this.companies_list[i].GetID() == id) {
                this.companies_list.remove(i);
            }
        }
    }

    function AppendCompany(id)
    {
        if(GSCompany.ResolveCompanyID(id) != GSCompany.COMPANY_INVALID) {
            local mode = GSCompanyMode(id);
            this.companies_list.append(Company(id));
        }
    }

    /**
     * Check if we've chosen an duplicate subsidy for these town pairs.
     * @param town1 The origin town of the subsidy.
     * @param town1 The destination town of the subsidy.
     * @return true if there is already a subsidy here, else false.
     */
    function CheckForDuplicateSubsidy(town1, hq_town)
    {
        local duplicate_subsidy = false;
	    local sublist = GSSubsidyList()
	    for (local s = sublist.Begin (); !sublist.IsEnd (); s = sublist.Next ()) {
		    if (GSSubsidy.GetSourceType(s)==GSSubsidy.SPT_TOWN) {
			    if ((GSSubsidy.GetSourceIndex(s) == town1) || (GSSubsidy.GetSourceIndex(s) == hq_town)) {
				    duplicate_subsidy = true;
		        }
	        }
	    }
	    return duplicate_subsidy;
    }

    /**
     * Attempt to create subsidies between a nearby town and the HQ town.
     * @param hq_town The town with the HQ.
     */
    function CreateSubsidy(hq_town)
    {
        /* Choose a random town for the origin. */
        local town2 = GSBase.RandRange(GSTown.GetTownCount() - 1)
        /* Don't use the same town as the origin and destination. */
        if (town2 == hq_town) return;

        local max_subsidy_distance = GSController.GetSetting("max_subsidy_distance");

        local distance = GSTown.GetDistanceManhattanToTile(hq_town, GSTown.GetLocation(town2));
        if (distance > max_subsidy_distance) {
            GSLog.Info("Attempted subsidy. Distance: " + distance + " tiles.");
            return;
        }

        /* If the chosen route isn't a duplicate, create a subsidy from the origin town to the HQ town. */
        if (!CheckForDuplicateSubsidy(town2, hq_town)) {
            GSSubsidy.Create(0, GSSubsidy.SPT_TOWN, town2, GSSubsidy.SPT_TOWN, hq_town);
            GSLog.Info("Subsidy offered! Distance: " + distance + " tiles.");
        } else {
            GSLog.Info("Duplicate inbound subsidy. Distance: " + distance + " tiles.");
        }
    }
}