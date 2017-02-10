/**
 * Created by skvarma on 2017-01-31.
 */

public class GetSomeAccounts {
    @InvocableMethod(label='Get Some Accounts ')
    public static List<Account> getSomeAccounts() {
        //List<String> accountNames = new List<String>();

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE name like 'Account LLC 111' Limit 1];

        return accounts;
    }

}