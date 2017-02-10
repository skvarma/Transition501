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


### Topic#2 - Describe the different capabilities of and use cases for the various Salesforce development platforms (Heroku, Fuel, Force.com).

####Heroku - PaaS - https://trailhead.salesforce.com/heroku_enterprise_baiscs/hello_heroku
####Fuel - Marketing Cloud platform - https://www.marketingcloud.com/uk/products/platform/fuel-platform/
#### Foce.com

### Topic#3 - Describe how to design code that accommodates multi-language, multi-currency, multi-locale considerations

#### multi-language -
```
Translation Workbench - http://amitsalesforce.blogspot.ca/2015/01/translation-workbench-salesforce.html
If you want to use the translation workbench, you need to enable it. Enabling the workbench makes some changes to your Salesforce.com  organization:
  - Picklist values must be edited individually. This means you can’t mass edit picklist values, though you can still mass add new values.
  - When picklist values are sorted alphabetically, the values are alphabetical by the organization's default language.
  - Reports have a language drop down on the filter criteria page when any filter criteria uses the "starts with", "contains" or "does not contain" operators.
  - Import files have a language drop down and all records and values within the import file must be in that language.
  - Web-to-Lead and Web-to-Case have a language drop down before you generate the HTML.
  - All rules and setup data must be entered in the organization's default language - Global administrators must work together in the organization's default language.
```
```
The language used to display labels that have associated translations in Salesforce. This value overrides the language of the user viewing the page.
<apex page language="en">
<apex page language="en-US">
```


#### multi-currency
* [Manage Multiple Currencies](https://help.salesforce.com/articleView?id=admin_currency.htm&type=0&language=en_US&release=206.6)
* [Implications of Enabling Multi Currency](https://help.salesforce.com/articleView?id=admin_enable_multicurrency_implications.htm&type=0)
* [Enable Multiple Currencies](https://help.salesforce.com/articleView?id=admin_enable_multicurrency.htm&language=en_US&type=0)
* [About Advanced Currency Management](https://help.salesforce.com/articleView?id=administration_about_advanced_currency_management.htm&type=0&language=en_US)
* [Querying Currency Fields in Multi-Currency Orgs](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_querying_currency_fields.htm)
* [CurrencyType](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_currencytype.htm)
* [DatedConversionRate](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_objects_datedconversionrate.htm?search_text=currency)

#### multi-locale
* [Select Your Language, Locale, and Currency](https://help.salesforce.com/articleView?id=admin_language_locale_currency.htm&language=zh_CN_3&type=0)
  The Salesforce locale settings determine the display formats for date and time, users’ names, addresses, and commas and periods in numbers. For single-currency organizations, locales also set the default currency for the organization when you select them in the Currency Locale picklist on the Company Information page.

### Tpoic 4 - Describe the implications of compound data types in Apex programming.
* [Compound Field Considerations and Limitations](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/compound_fields_limitations.htm)
* Compound fields group together multiple elements of primitive data types, such as numbers or strings, to represent complex data types, such as a location or an address. Compound fields are accessible as a single, structured field, or as individual component fields.

* Address - Address, a structured data type that combines the following fields.
  - Accuracy,City,Country,CountryCode,Latitude,Longitude,PostalCode,State,StateCode,Street

    ```
    SELECT Name, *MailingAddress* FROM Contact *OR*

    SELECT Name, BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry, BillingLatitude, BillingLongitude
      FROM Account

    //Access the compound address field *MailingAddress*
    Address addr = (Address) con.getMailingAddress();
    String streetAddr = "";
    if (null != addr) streetAddr = *addr.getStreet()*;
    ```

- Compound address fields include latitude and longitude fields.

    ```
    SELECT Id, Name, BillingAddress
    FROM Account
    WHERE DISTANCE(BillingAddress, GEOLOCATION(37.775,-122.418), 'mi') < 20
    ORDER BY DISTANCE(BillingAddress, GEOLOCATION(37.775,-122.418), 'mi')
    LIMIT 10
    ```

* Geolocation fields are accessible in the SOAP and REST APIs as a Location—a structured compound data type—or as individual latitude and longitude elements.
  - SELECT clauses can reference geolocations directly, instead of the individual component fields.
  ```
  SELECT location__c FROM Warehouse__c
  ```

* Compound Field Considerations and Limitations
  - Read Only
  - Only accessible by SOAP & REST APIs
  - Can be queried with the Location and Address Apex classes but they’re editable only as components of the actual field
    ```
    /*
     *  Read and set geolocation field components by appending “__latitude__s”
     *  or “__longitude__s” to the field name, instead of the usual “__c.”
     */
    Double theLatitude = myObject__c.aLocation__latitude__s;
    myObject__c.aLocation__longitude__s = theLongitude;
    ```
  - You can’t use compound fields in
      - *Visualforce* —for example, in an <apex:outputField>. To access or update field values, use the individual field components.
      - Data Loader
      - Custom geolocation and location fields on standard addresses aren’t supported with email templates.
      - You can’t use compound fields in lookup filters, except to filter distances that are within or not within given ranges
      - The only formula functions that you can use with compound fields are ISBLANK, ISCHANGED, and ISNULL
  - Address fields can’t be used in WHERE statements in SOQL. Address fields aren’t filterable, but the isFilterable() method of the DescribeFieldResult Apex class erroneously returns true for address fields.
  - Geolocation fields are supported in SOQL with the following limitations.
    - DISTANCE and GEOLOCATION are supported in WHERE and ORDER BY clauses in SOQL, but not in GROUP BY. DISTANCE is supported in SELECT clauses.
    - DISTANCE supports only the logical operators > and <, returning values within (<) or beyond (>) a specified radius.
    - When using the GEOLOCATION function in SOQL queries, the geolocation field must precede the latitude and longitude coordinates. For example,
    ```
    DISTANCE(warehouse_location__c, GEOLOCATION(37.775,-122.418), 'km') works
    but
    DISTANCE (GEOLOCATION(37.775,-122.418), warehouse_location__c, 'km') doesn’t work.
    ```
    - Apex bind variables aren’t supported for the units parameter in DISTANCE or GEOLOCATION functions. This query doesn’t work.
    ```
    String units = 'mi';
    List<Account> accountList =
    [SELECT ID, Name, BillingLatitude, BillingLongitude
     FROM Account
     WHERE DISTANCE(My_Location_Field__c, GEOLOCATION(10,10), :units) < 10];
    ```

### Topic 5 - Describe the interactions between Visualforce/Apex with Flow/Lightning Process Builder.
* [InvocableMethod Annotation](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_annotation_InvocableMethod.htm)
  ```
  public class AccountInsertAction {
    @InvocableMethod(label='Insert Accounts' description='Inserts the accounts specified and returns the IDs of the new accounts.')
    public static List<ID> insertAccounts(List<Account> accounts) {
      Database.SaveResult[] results = Database.insert(accounts);
      List<ID> accountIds = new List<ID>();
      for (Database.SaveResult result : results) {
        if (result.isSuccess()) {
          accountIds.add(result.getId());
        }
      }
      return accountIds;
    }
  }
  ```
* [InvocableVariable Annotation](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_annotation_InvocableVariable.htm)


* [Visual Workflow in Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_forcecom_visualworkflow.htm)

* [Render Flows with Visualforce](https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_flows_intro.htm)
  ```
  <apex:page standardController="Case" tabStyle="Case" >
      <flow:interview name="ModemTroubleShooting">
          <apex:param name="vaCaseNumber" value="{!Case.CaseNumber}"/>
      </flow:interview>
  </apex:page>  
  ```

  ```
  public class MyCustomController {
    public Account apexVar {get; set;}

    public MyCustomController() {
        apexVar = [
            SELECT Id, Name FROM Account
            WHERE Name = ‘Acme’ LIMIT 1];
    }
  }

  <apex:page controller="MyCustomController">
    <flow:interview name="flowname">
        <apex:param name="myVariable" value="{!apexVar}"/>
    </flow:interview>
  </apex:page>
  ```

  ```
  public class MyCustomController {
    public Account[] myAccount {
        get {
            return [
                SELECT Id, Name FROM account
                WHERE Name = 'Acme'
                ORDER BY Id
            ] ;
        }
        set {
            myAccount = value;
        }
    }
    public MyCustomController () {
    }
  }

  <apex:page id="p" controller="MyCustomController">
    <flow:interview id="i" name="flowname">
        <apex:param name="accountColl" value="{!myAccount}"/>
    </flow:interview>
  </apex:page>
  ```

  ```
  public class MyCustomController {
    public Flow.Interview.flowname MyInterview { get; set; }

    public MyCustomController() {
        String[] value1 = new String[]{'First', 'Second'};
        Double[] value2 = new Double[]{999.123456789, 666.123456789};
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('stringCollVar', value1);
        myMap.put('numberCollVar', value2);
        MyInterview = new Flow.Interview.flowname(myMap);
    }
  }

  <apex:page controller="MyCustomController">
    <flow:interview name="flowname" interview="{!MyInterview}" />
  </apex:page>
  ```

### Topic 6 - Given a scenario, describe when and how to use Apex managed sharing

* [Understanding Apex Managed Sharing](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_bulk_sharing.htm)


### Topic 7 - Describe the use cases for the various authentication techniques

* [Understanding Authentication - oAuth](https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_authentication.htm)

* [SOAP API Login](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_login.htm)

* [How to Implement Single Sign-On with Force.com](https://developer.salesforce.com/page/How_to_Implement_Single_Sign-On_with_Force.com)

* [Single Sign-On with SAML on Force.com](https://developer.salesforce.com/page/Single_Sign-On_with_SAML_on_Force.com)

* [The Elements of User Authentication](https://help.salesforce.com/articleView?id=security_overview_user.htm&language=en_US&type=0)


### Topic 8 - Given a set of requirements, describe the process for designing Lightning components.

* [Getting started with Lightning components](https://trailhead.salesforce.com/lex_dev/lex_dev_lc_basics/lex_dev_lc_basics_intro)
* [Handle Actions with controllers](https://trailhead.salesforce.com/lex_dev_lc_basics/lex_dev_lc_basics_controllers)

### Topic XXX - Using Developer Console to debug an app (especially checkpoints)

* [Developer Console Basics](https://trailhead.salesforce.com/en/modules/developer_console)



### How to register certificates


### Topic XXX - Querying the PermissionSet
* [Using SOQL to Determine Your Force.com User’s Permissions](https://developer.salesforce.com/blogs/engineering/2012/06/using-soql-to-determine-your-users-permissions-2.html)
* PermissionSet Objects
  - PermissionSet  (Object that defines the PermissionSet, has a boolean flag *IsOwnedByProfile*)
  - ObjectPermissions (Master Detail with Permission Set. Stoes Object permission for each permission set)
  - PermissionSetAssignment (Junction obj b/w PermissionSet & User)

```
  SELECT Id,IsOwnedByProfile,Label
  FROM PermissionSet
```

```
  // which users have Read on Accounts and why
  SELECT Assignee.Name, PermissionSet.Id, PermissionSet.isOwnedByProfile, PermissionSet.Profile.Name, PermissionSet.Label
    FROM PermissionSetAssignment
    WHERE PermissionSetId
      IN (SELECT ParentId
          FROM ObjectPermissions
          WHERE SObjectType = 'Account' AND
          PermissionsRead = true)
```
```
  // Why a specific user has read access to account
  Select ID, PermissionSet.Name, PermissionSet.Label, PermissionSet.IsOwnedByProfile, PermissionSet.Profile.name
  from PermissionSetAssignment
  Where Assignee.Name = 'User Name'
  and PermissionSetId in (Select ParentId from ObjectPermissions Where SobjectType = 'Account' and PermissionsRead = true)
```






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


Compound fields – Learn the different types of compound fields and understand the considerations and limitations. Pay atention to DISTANCE and GEOLOCATION formulas.
Advanced Currency Management – review this topic and also pay attention to how you would approach this in SOQL or SOSL.
How would you manage exchange rates when multi-currency is enabled?
Understand Continuation Calls and why they are needed.
Review best practices for test classes and why the new @testsetup annotation is used. Understand its considerations.
Review how to query for permission sets in SOQL. Pay close attention to the various aspects of this namely the relationship between the user and permission set and the user licence.
Understand the @invocablemethod annotation and how it differs from Process.plugin and the @invocablevariable annotation.
Understand the basics of lightning components. Best to skim through the Lightning components developer guide and understand the first few chapters.
Pay attention to how you would mock classes for http callouts v/s web service callouts?
Review the web service class and understand what kind of arguments it can accept and return.
Visualforce best practices
APEX best practices
Order of Execution
Understand how to use the developer console and its components. How can you debug your code using this? (Spend some time on this. I missed some questions on this and they are easy to get!!!!)
Apex charts – Pay attention to the various options and attributes.
Efficient ways of querying parent-child object SOQL or performing parent-child object DML.
Rollup summary considerations.
Know when to pick the best automation tool for a given scenario.
Review the VF apex:action… tags and understand their usage.
Finally skim through the apex and vf developer guides. Note: I was not able to do this in detail due to lack of time but if you have time then go for it.
