class Company
{
    id = -1;
    hq_town = -1;

    constructor (id)
    {
        this.id = id;
    }

    /**
     * Getter for the company ID.
     * @return The company ID.
     */
    function GetID()
    {
        return id;
    }

    /**
     * Check if this company has an HQ.
     * @return true if the company has an HQ, else false.
     */
    function HasHQ()
    {
        local hq_tile = GSCompany.GetCompanyHQ(this.id);
        return hq_tile != GSMap.TILE_INVALID;
    }

    /**
     * Find the town where the company has placed its HQ.
     */
    function FindHometown()
    {
        local hq_tile = GSCompany.GetCompanyHQ(this.id);
        if (hq_tile == GSMap.TILE_INVALID) return;
        this.hq_town = GSTile.GetClosestTown(hq_tile);
    }

   /**
    * Getter function for hq_town.
    * @return The ID of hq_town.
    */
   function GetHometown()
   {
       this.FindHometown();
       return hq_town;
   }
}