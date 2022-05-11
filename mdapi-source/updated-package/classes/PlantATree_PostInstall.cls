global class PlantATree_PostInstall implements InstallHandler
{
    //email template: Plant A Tree Installation 
    global void onInstall(InstallContext context)
    {
    System.debug('PlantATree_PostInstallv');
        if(true || context.previousVersion() == null)
        {
            //Account a = new Account(name='Newco');
            //insert(a);

            //Survey__c obj = new Survey__c(name='Client Satisfaction Survey');
            //insert obj;

            User u = [Select Id, Email from User where Id =: context.installerID()];
            String toAddress= u.Email;
            
            System.debug('PlantATree_PostInstall: ' + toAddress);
            String[] toAddresses = new String[]
            {toAddress};
            Messaging.SingleEmailMessage mail =
                new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@package.dev');
            mail.setSenderDisplayName('Plant a tree Support');
            mail.setSubject('Package install successful');
            mail.setPlainTextBody('Thanks for installing the package.');
            Messaging.sendEmail(new Messaging.Email[] { mail });
        }
        else
        if(context.previousVersion().compareTo(new Version(1,0)) == 0)
        {
            //Survey__c obj = new Survey__c(name='Upgrading from Version 1.0');
            //insert(obj);
        }
        if(context.isUpgrade())
        {
            //Survey__c obj = new Survey__c(name='Sample Survey during Upgrade');
            //insert obj;
        }
        if(context.isPush())
        {
            //Survey__c obj = new Survey__c(name='Sample Survey during Push');
            //insert obj;
        }
    }
}