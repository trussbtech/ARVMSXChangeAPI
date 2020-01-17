

Module modARVMSXChange


    Sub Main()

        'Console.WriteLine("Running API XML program")

        Try


            Dim iInformationBit As Long = 256

            Dim PartnerKey As String = "1"
            Dim PropertyCompanyKey As String = ""
            Dim VendorID As String = "assnready"
            Dim VendorPassword As String = "r34dee4me"
            Dim PropertyResident As String = "65"
            Dim PropertyResidentContactKey As String = ""
            Dim dtpTransactionAsOf As Date = "01/01/1950"
            Dim ReturnData As String
            Dim sFile As String
            Dim ARVMSAPI As New ARVMSXChangeAPI

            ReturnData = ARVMSAPI.DownloadProperty(PartnerKey, VendorID, VendorPassword, PropertyCompanyKey, PropertyResident, PropertyResidentContactKey, iInformationBit, dtpTransactionAsOf)
            sFile = ARVMSAPI.CreateXMLFile(ReturnData, False)

            'Console.WriteLine("End Call DowmloadProperty function")
            'Console.ReadKey()

        Catch e As DivideByZeroException
            Console.WriteLine("Exception caught: {0}", e)
        End Try


    End Sub

End Module
