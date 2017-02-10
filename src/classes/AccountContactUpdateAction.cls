/**
 * Created by skvarma on 2017-01-30.
 */

public class AccountContactUpdateAction {
    @InvocableMethod(label='Create Default Contact for LLC Accounts')
    public static void LLCAccountCreateDefautContactAction(List<Account> accounts){
        List<contact> contacts = new List<Contact>();
        for(Account account:Accounts){
            Contact contact = new Contact();
            contact.firstname = account.name + ' - contact';
            contact.lastname = 'lastname';
            contact.accountid = account.id;
            contacts.add(contact);
        }

        insert contacts;
    }


}