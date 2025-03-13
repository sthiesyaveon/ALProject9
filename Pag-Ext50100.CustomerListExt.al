pageextension 50100 "Customer List Ext" extends "Customer List"
{

    CardPageId = "My Customer Card";

    actions
    {
        addafter(Email_Promoted)
        {
            actionref(blaPromoted; actBla) { }
            actionref(multiTextPromoted; actMultiText) { }
            actionref(continuePromoted; actContinue) { }
            actionref(continue2Promoted; actContinue2) { }
            actionref(continue3Promoted; actContinue3) { }
            actionref(previewPromoted; actPreview) { }
            actionref(actSessionInformationPromoted; actSessionInformation) { }
            actionref(actOrginalCardPromoted; actOrginalCard) { }
        }

        addafter(CustomerLedgerEntries)
        {

            action(actBla)
            {
                ApplicationArea = All;
                Caption = 'Bla';
                trigger OnAction()
                var
                    lJsonObject: JsonObject;
                    lJsonToken: JsonToken;
                    lJsonArray: JsonArray;
                    lInStream: InStream;
                    lOutStream: OutStream;
                    lToFile: Text;
                    lTempBLOB: codeunit "Temp Blob";
                    i: Integer;
                begin
                    lTempBLOB.CreateInStream(lInStream);
                    UploadIntoStream('(*.yml)|*.yml', lInStream);
                    lJsonObject.ReadFromYaml(lInStream);
                    lJsonArray := lJsonObject.GetArray('variables');
                    for i := 0 to lJsonArray.Count - 1 do begin
                        lJsonArray.Get(i, lJsonToken);
                        if lJsonToken.AsObject().Contains('name') then
                            if lJsonToken.AsObject().GetText('name') = 'bcversion' then
                                Message('BCVersion: %1', lJsonToken.AsObject().GetText('value'));
                    end;
                    // lTempBLOB.CreateOutStream(lOutStream);
                    // lJsonObject.WriteTo(lOutStream);
                    // lTempBLOB.CreateInStream(lInStream);
                    // lToFile := 'Output.json';
                    // DownloadFromStream(lInStream, 'Download json', '', '*.json', lToFile);

                    for i := 0 to lJsonArray.Count - 1 do begin
                        lJsonArray.Get(i, lJsonToken);
                        if lJsonToken.AsObject().Contains('name') then
                            if lJsonToken.AsObject().GetText('name') = 'bcversion' then begin
                                lJsonToken.AsObject().Replace('value', '26.0');
                            end;
                    end;

                    lTempBLOB.CreateOutStream(lOutStream);
                    lJsonObject.WriteToYaml(lOutStream);
                    lTempBLOB.CreateInStream(lInStream);
                    lToFile := 'Output.yml';
                    DownloadFromStream(lInStream, 'Download yml', '', '*.yml', lToFile);
                end;
            }

            action(actMultiText)
            {
                ApplicationArea = All;
                Caption = 'Multi Text';

                trigger OnAction()
                begin
                    Message(gctxMultiLineCnstant);
                end;
            }

            action(actContinue)
            {
                ApplicationArea = All;
                Caption = 'Continue';
                trigger OnAction()
                var
                    lCustomer: Record Customer;
                    lFilterText: Text;
                    i: Integer;
                begin
                    for i := 0 to 7 do begin
                        lFilterText := StrSubstNo('%1*', i);
                        Message('Filtering customers for ''%1''', lFilterText);
                        if i = 5 then
                            continue;
                        lCustomer.SetFilter("No.", lFilterText);
                        Message('%1 Customers found for %2', lCustomer.Count, i);
                    end;
                end;
            }
            action(actContinue2)
            {
                ApplicationArea = All;
                Caption = 'Continue2';
                trigger OnAction()
                var
                    lCustomer: Record Customer;
                    lFilterText: Text;
                    i: Integer;
                begin
                    for i := 0 to 7 do begin
                        lFilterText := StrSubstNo('%1*', i);
                        Message('Filtering customers for ''%1''', lFilterText);
                        if i <> 5 then begin
                            lCustomer.SetFilter("No.", lFilterText);
                            Message('%1 Customers found for %2', lCustomer.Count, i);
                        end;
                    end;
                end;
            }
            action(actContinue3)
            {
                ApplicationArea = All;
                Caption = 'Continue3';
                trigger OnAction()
                var
                    lCustomer: Record Customer;
                    lFilterText: Text;
                    i: Integer;
                begin
                    lCustomer.FindSet();
                    repeat
                        if lCustomer."No." = '10000' then
                            continue;
                        Message('Customer %1 %2', lCustomer."No.", lCustomer.Name);
                    until lCustomer.Next() = 0;
                end;
            }
            action(actPreview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                trigger OnAction()
                var
                    ltempBlob: Codeunit "Temp Blob";
                    lInStream: InStream;
                    lOutStream: OutStream;
                begin
                    ltempBlob.CreateInStream(lInStream);
                    UploadIntoStream('(*.pdf)|*.pdf', lInStream);
                    ViewFromStream(lInStream, 'bla.pdf', true);

                end;
            }

            action(actIncStr)
            {
                ApplicationArea = All;
                Caption = 'IncStr';
                trigger OnAction()
                var
                    lMyText: Text;
                begin
                    lMyText := 'Credit of 15';
                    lMyText := IncStr(lMyText, 15);
                end;
            }



            action(actHttpClient)
            {
                ApplicationArea = All;
                Caption = 'HttpClient';
                trigger OnAction()
                var
                    lHttpClient: HttpClient;
                begin
                    // lHttpClient.
                end;
            }


            action(actHovering)
            {
                ApplicationArea = All;
                Caption = 'Hovering';
                trigger OnAction()
                var
                    ltempBlob: Codeunit "Temp Blob";
                    lMyCodeunit2: Codeunit "MyCodeunit2";
                    lMyEnum: Enum CarTypes;
                begin
                    Message(gctxMultiLineCnstant);
                    lMyEnum := CarTypes::CompactCar;
                end;
            }


            action(actToText)
            {
                ApplicationArea = All;
                Caption = 'ToText';
                trigger OnAction()
                var
                    lMyInt: Integer;
                begin
                    lMyInt := 15;


                    Message(Format(lMyInt));
                    // or
                    Message('%1', lMyInt);

                    // vs

                    Message(lMyInt.ToText());

                end;
            }

            action(actSessionInformation)
            {
                ApplicationArea = All;
                Caption = 'Session Information';
                trigger OnAction()
                var
                    lMyCodeunit: Codeunit "MyCodeunit";
                begin
                    lMyCodeunit.ShowCallStack();
                end;
            }

            action(actOrginalCard)
            {
                ApplicationArea = All;
                RunObject = Page "Customer Card";
            }
        }

    }

    var
        gctxMultiLineCnstant: Label @'this 
        is 
        a 
        multiline 
        constant', Locked = true;


}