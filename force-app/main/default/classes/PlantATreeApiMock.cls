@isTest
global class PlantATreeApiMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"uuid":"eef9f369-9ae0-45b8-ab07-10650f53a71e","created":"2019-05-17T00:36:25.797Z","treeCount":2,"enterpriseId":"11111111","projectId":"93333333","user":"email@test.com"}');
        response.setStatusCode(200);
        return response; 
    }
}