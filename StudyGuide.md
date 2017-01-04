# SFDC ADV Developer Transition Exam - Study Notes

### Topic#1 - Describe the capabilities of base-system objects such as sharing objects, history objects, metadata objects, multi-currency, and Chatter objects.

#### Sharing Objects
Apex managed sharing is a type of "Programatic Sharing" which allows you to define a custom sharing reason to associate with your programatic share. Standard Salesforce objects support "Programatic Sharing" while custom objects support Apex managed sharing. More specifically, object shares can be written to both standard and custom objects, however custom sharing reasons can only be defined for shares written to custom objects.

All objects that have a default sharing setting of the either "Private" or "Public Read Only" also have a related "Share" object that is similar to an access control list (ACL) found in other platforms. All share objects for custom objects are named as MyCustomObject__Share

A share object includes records supporting all three types of sharing: Force.com managed sharing, user managed sharing, and Apex managed sharing.

A custom object’s share object allows four pieces of information to be defined:
  - The record being shared.
  - The User or Group with whom the object is being shared.
  - The permission level being granted to the User or Group.
  - The reason why the User or Group has been granted sharing access.

Reasons to implement Apex Sharing
  - Sharing records created by Apex managed sharing are maintained across record owner changes.
  - The only users that can add, edit or delete sharing records created by Apex managed sharing are users with the "Modify All Data" permission.
  - A record can be shared multiple times with a user or group using different Apex sharing reasons.

Sample Use Case
  - Automatically share a record to a User based on a User-lookup field.
    e.g. Share a record based on a user lookup that is on the object.


#### History objects
The naming convention for these objects is:
__[standardObjectName]History e.g. AccountHistory, ContactHistory__
__[customObjectName]__History e.g. Car__History, Brand__History__

```
SELECT OldValue, NewValue, Parent.Id, Parent.name, Parent.customfield__c
FROM foo__history

SELECT Name, customfield__c, (SELECT OldValue, NewValue FROM foo__history)
FROM foo__c
```


#### Metadata objects
[EMPTY]

#### multi-currency
[EMPTY]

#### Chatter objects
[Awesome Chatter Documentation](https://developer.salesforce.com/page/An_Introduction_to_Salesforce_Chatter)

[Chatter data Model](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/RelationshipsOfChatterObjects.htm)


  - A feed item is an entry in the feed, such as a change to a record that's being followed, an updated post, or a user status change.
  - All feed items have a ParentId, which is either:
    - a record
    - a user
    - a group  







Describe the different capabilities of and use cases for the various Salesforce development platforms (Heroku, Fuel, Force.com).
Describe how to design code that accommodates multi-language, multi-currency, multi-locale considerations.
Describe the implications of compound data types in Apex programming.
Describe the interactions between Visualforce/Apex with Flow/Lightning Process Builder.
Given a scenario, describe when and how to use Apex managed sharing. Describe the use cases for the various authentication techniques.
Given a set of requirements, describe the process for designing Lightning components.
Describe the common performance issues for user interfaces and the techniques to mitigate them.
Describe how to expose Apex classes as SOAP and REST web services.
Describe how to use system classes to integrate with SOAP- or REST-based web services.
Describe when and how to use metadata, streaming, and Analytics API to enhance Apex and Visualforce solutions.
Given a scenario, identify the appropriate tool to analyze application performance profiles and troubleshoot data and performance issues.
@InvocableMethod and @InvocableVariable versus ProcessPlugin interface
Querying the PermissionSet
Using Developer Console to debug an app (especially checkpoints)
Using Webservice keyword and considerations
Querying based on the Currency field
How to register certificates
Apex Managed Sharing considerations
