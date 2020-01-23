Module NewModARVMSXChange


    Sub Main()

        'Console.WriteLine("Running API XML program")

        Try


        Console.WriteLine("Running API XML program")

        ' Establish connection to ARDATA
        ' Call stored procedure to retrieve - Clientpkey, UserID, Password
        ' Create array of clients..
        ' Retreive ClientpKey, UserID, Password
			Dim AccessDB As New AccessARDATA
			
			
			Clientlist As Array = 
			Dim ReturnData As String
			Dim RecInBit As Long = 256
			Dim UserID As String = "assnready"
         
			'' Value 
            Dim PartnerKey As String = "1"
            Dim PropertyCompanyKey As String = ""
            Dim VendorID As String = "assnready"
            Dim VendorPassword As String = "r34dee4me"
            Dim PropertyResident As String = ""
            Dim PropertyResidentContactKey As String = ""
            Dim dtpTransactionAsOf As Date = "01/01/1950"
			
			While 1  < RetrieveCount
		 
				Dim ARVMSAPI As New ARVMSXChangeAPI
				ReturnData = ARVMSAPI.DownloadProperty(PartnerKey, VendorID, VendorPassword, PropertyCompanyKey, PropertyResident, PropertyResidentContactKey, iInformationBit, dtpTransactionAsOf)
				sFile = ARVMSAPI.CreateXMLFile(ReturnData, False)
				' Call stored procedure to Update or Insert records - passing Clientpkey and XML file
			End While
			
        Catch e As DivideByZeroException
            Console.WriteLine("Exception caught: {0}", e)
        End Try


    End Sub

End Module