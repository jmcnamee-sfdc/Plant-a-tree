global class PlantATreeManager
{
    @InvocableMethod(label = 'Call Plant-a-tree-API 2'description = 'Call RaaS (Reforestation as a Service) - A platform which easily integrates with your products to reforest the planet')
    public static List<PlantTreeResponse> CallPlantATreeAPI(List<PlantTreeRequest> requests)
    {
        List<PlantTreeResponse> output = new List<PlantTreeResponse>();
        for (PlantTreeRequest request : requests)
        {
            PlantTreeResponse response = CallPlantATreeAPI(request);
            output.add(response);
        }
        //Wednesday CommentXX
        return output;
    }

    public static PlantTreeResponse CallPlantATreeAPI(PlantTreeRequest input)
    {
        PlantTreeResponse output = new PlantTreeResponse();

        Plant_A_Tree_Settings__mdt settings = GetSettings();

        if (settings != null)
        {
            Http http = new Http();
            HttpRequest request = new HttpRequest();

            request.setEndpoint(settings.Plant_a_tree_API_url__c);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('X-Api-Key', settings.X_Api_Key__c);

            String body = '{';
            body += '"treeCount": ' + input.TotalTrees + ',';
            body += '"enterpriseId": "' + settings.Enterprise_ID__c + '",';
            body += '"projectId": "' + settings.Project_ID__c + '",';
            body += '"user": "' + input.User + '"';
            body += '}';

            request.setBody(body);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if (response.getStatusCode() == 200)
            {
                output.RawResponse = response.getBody();
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(output.RawResponse);
                output.uuid = (String) results.get('uuid');
                output.createdString = (String) results.get('created');
                output.createdDate = date.valueOf(output.createdString);
                output.treeCount = (Integer) results.get('treeCount');
                output.enterpriseId = (String) results.get('enterpriseId');
                output.projectId = (String) results.get('projectId');
                output.user = (String) results.get('user');

                System.debug(output);
            }
            else
            {
                output.Message = 'Error processing request ';
                //output.Message += body + 'response.getStatusCode()='+ response.getStatusCode() + ' - Message: ' + response.getBody();
            }
        }




        return output;
    }

    global static Integer GetThreshold()
    {   Plant_A_Tree_Settings__mdt item = GetSettings();
        return (Integer)item.Opportunity_Minimum_Amount__c;
    }

    public static Plant_A_Tree_Settings__mdt GetSettings()
    {
        string key = 'Default_Settings';
        Plant_A_Tree_Settings__mdt item = Plant_A_Tree_Settings__mdt.getInstance(key);
        if(item != null)
        {
            System.debug(key + ' found!');
            System.debug(item.QualifiedApiName);
            System.debug(item.Enterprise_ID__c);
            System.debug(item.Project_ID__c);
            System.debug(item.Plant_a_tree_API_url__c);
            System.debug(item.Opportunity_Minimum_Amount__c);
            System.debug(item.X_Api_Key__c);
            //System.debug(item.Threshold__c);
        }
        else
        {
            System.debug(key + ' NOT found! Supplying Default values for ');
            item = new Plant_A_Tree_Settings__mdt();
        }

        return item;
    }

}