public class RestAPI-Callout {
    public static String execute(Map<String, String> requestHeaders, Map<String, String> requestBody, String method, String endpoint) {
        String stringBody = '';
        
        Httprequest req = new HttpRequest();
        
        // set request headers
        if(requestHeaders.size() > 0) {
            for (String key : requestHeaders.keySet()) {
                req.setHeader(key,  requestHeaders.get(key));
                
                //System.debug('headers: ' + key + ', ' + requestHeaders.get(key));
            }
        }
        
        if(requestBody.size() > 0) {
            // build the request body
            for (String key : requestBody.keySet()) {
                 stringBody +=  key + '=' + requestBody.get(key) + '&';
            }
            
            stringBody = stringBody.removeEnd('&');
            req.setBody(stringBody);
            //System.debug(stringBody);
        }
        
        req.setMethod(method);
        req.setEndpoint(endpoint);

        // send the request and get the access token
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                System.debug('Callout Successful: Endpoint - ' + endpoint);
                return res.getBody();
            }
            else {
                System.debug('Callout Failed');
                System.debug('Error Code: ' + res.getStatusCode() + ' ' + res.getStatus());
                return 'Callout Failed';
            }
        } catch(CallOutException e) {
            System.debug('An exception occurred: ' + e.getMessage());
            return 'Callout Failed';
        }
    }
}