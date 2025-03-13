codeunit 50101 MyCodeunitTests
{
    Subtype = Test;
    TestHttpRequestPolicy = AllowOutboundFromHandler;

    // [Test]
    // [HandlerFunctions('HttpClientHandler')]
    // procedure TestUnauthorizedResponseHandled()
    // var
    //     MyCodeunit: Codeunit "MyCodeunit";
    // begin
    //     MyCodeunit.MethodWithHttpRequest();
    // end;

    // [HttpClientHandler]
    // procedure HttpClientHandler(request: TestHttpRequestMessage; var response: TestHttpResponseMessage): Boolean
    // begin
    //     // Mock a '401 Unauthorized' response for the 'GET http://example.com/' request
    //     if (request.RequestType = HttpRequestType::Get) and (request.Path = 'http://example.com/') then begin
    //         response.HttpStatusCode := 401;
    //         response.ReasonPhrase := 'Unauthorized';
    //         exit(false); // Use the mocked response
    //     end;

    //     // Fall through and issue the original request in case of other requests
    //     exit(true);
    // end;
}