page 50100 PageName
{
    PageType = UserControlHost;


    layout
    {
        area(content)
        {
            usercontrol(bla; WebPageViewer)
            {
                ApplicationArea = All;

                trigger ControlAddInReady(CallbackUrl: Text)
                begin
                    CurrPage.bla.Navigate('https://example.com/');
                    Message('hallo');
                end;

            }
        }
    }
}