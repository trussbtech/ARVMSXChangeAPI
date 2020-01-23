Imports System.Data
Imports System.Data.SqlClient

Module TestConnectDB
    Sub Main()

        Console.WriteLine("Open call to coonet to Sql db")
        Dim ClientpKey As String
        Dim queryString As String = "Select ClientpKey, UserID, Password from CompanyxRef Where CampanyName='VMS' and Active=1;"
        Using connection As New SqlConnection("Server=BTECH-01,Database=CompanyxRef,Integrated Securety=True")
            Dim Sqlcommand As New SqlCommand(queryString, connection)
            connection.Open()
            '' Call ExecuteReader
            Dim reader As SqlDataReader = Sqlcommand.ExecuteReader()

            '' Call GetOrdinal and assign value to variable.
            Dim ClientKey As Integer = reader.GetOrdinal("ClientpKey")
            reader.Read()
            ClientpKey = reader.GetString(ClientKey)

        End Using
        Console.WriteLine(ClientpKey)
        Console.ReadKey()

    End Sub
End Module
