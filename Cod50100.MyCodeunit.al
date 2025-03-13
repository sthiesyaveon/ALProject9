codeunit 50100 MyCodeunit
{
    procedure MethodWithHttpRequest()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        Client.Get('http://example.com/', Response);
    end;

    procedure ShowCallStack()
    begin
        Message(SessionInformation.Callstack());
    end;

}