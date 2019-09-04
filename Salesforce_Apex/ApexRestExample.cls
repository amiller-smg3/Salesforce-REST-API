/**
* ApexRestExample
*
* Simple class to provide a REST endpoint
* for a given client
*/
@RestResource(urlMapping='/AccountCountExample/*')
global class ApexRestExample {

    /**
    * getAccountCount
    *
    * Function which takes the param 'contactCount'
    * and figures out how many Accounts in the 
    * system have that number of Contacts
    *
    * @param contactCount - number of Contacts an Account should have for it to be returned
    * @return List<Account> - list of Accounts, if any, which match the number of Contacts required
    */
    @HttpPost
    global static List<Account> getAccountCount(Integer contactCount) 
    {
        // List which will contain the final result
        List<Account> listOfAccountsToReturn = new List<Account>();

        // Query to get all Accounts with at least one Contact
        List<Account> listOfAccounts = ([SELECT Id, 
                                            Name,
                                            (SELECT Id
                                             FROM Contacts)
                                        FROM Account
                                        WHERE Id IN (SELECT AccountId FROM Contact)]);
        
        // Cycle through all the Accounts and make sure the Contact
        // Count matches the actual number of Contacts
        for(Account tempAccount : listOfAccounts)
        {
            Integer count = 0;
            
            for(Contact tempContact : tempAccount.Contacts)
            {
                count++;
            }

            if(count == contactCount)
            {
                listOfAccountsToReturn.add(tempAccount);
            }
        }

        return listOfAccountsToReturn;
    }
}