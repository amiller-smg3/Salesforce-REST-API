/**
* ApexRestExampleTest
*
* Simple test class to ensure the logic in 
* ApexRestExample is working properly
*/
@isTest
public class ApexRestExampleTest {

    @TestSetup
    static void makeData()
    {
        // One Account with a single Contact
        Account tempAccount1 = new Account();
        tempAccount1.Name = 'ApexRestExampleTest1';
        insert tempAccount1;

        Contact tempContact1 = new Contact();
        tempContact1.AccountId = tempAccount1.Id;
        tempContact1.LastName = 'ApexRestExampleTest1';
        insert tempContact1;

        // One Account with two Contacts
        Account tempAccount2 = new Account();
        tempAccount2.Name = 'ApexRestExampleTest2';
        insert tempAccount2;

        Contact tempContact2 = new Contact();
        tempContact2.AccountId = tempAccount2.Id;
        tempContact2.LastName = 'ApexRestExampleTest2';
        insert tempContact2;

        Contact tempContact3 = new Contact();
        tempContact3.AccountId = tempAccount2.Id;
        tempContact3.LastName = 'ApexRestExampleTest2';
        insert tempContact3;
    }
    
    public static TestMethod void testEndpointSingleAccountOneContact()
    {    
        Test.startTest();

        List<Account> returnedList = ApexRestExample.getAccountCount(1);

        System.assertEquals(1, returnedList.size());

        Account tempAccount = returnedList.get(0);

        System.assertEquals('ApexRestExampleTest1', tempAccount.Name);

        Test.stopTest();
    }

    public static TestMethod void testEndpointSingleAccountTwoContacts()
    {    
        Test.startTest();

        List<Account> returnedList = ApexRestExample.getAccountCount(2);

        System.assertEquals(1, returnedList.size());

        Account tempAccount = returnedList.get(0);

        System.assertEquals('ApexRestExampleTest2', tempAccount.Name);

        Test.stopTest();
    }

    public static TestMethod void testEndpointSingleAccountThreeContactsZeroResults()
    {    
        Test.startTest();

        List<Account> returnedList = ApexRestExample.getAccountCount(3);

        System.assertEquals(0, returnedList.size());

        Test.stopTest();
    }
}