@RestResource(urlMapping='/user_defined_type_example/*')
global with sharing class MyOwnTypeRestResource {

    @HttpPost
    global static MyUserDefinedClass echoMyType(MyUserDefinedClass ic) {
        return ic;
    }

    global class MyUserDefinedClass {

        global String string1;
        global String string2 { get; set; }
        private String privateString;
        global transient String transientString;
        //global static String staticString;

    }

    /*@HttpPost
    global static String createNewCase(String companyName, String caseType) {
        System.debug('COMPANY: '+companyName);
        System.debug('CASE TYPE: '+caseType);
        return 'Done';
    }*/


    /*
    {
    "ic" : {
                "string1" : "value for string1",
                "string2" : "value for string2",
                "privateString" : "value for privateString"
            }
}
     */
}