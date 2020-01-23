Imports System.Data
Imports System.Data.SqlClient

Public Class AccessARDATA

    Public Function ConnectARDATA() As Integer

        Dim queryString As String = "Select ClientpKey, UserID, Password from CompanyxRef Where CampanyName='VMS' and Active=1;"
        Using connection As New SqlConnection("Server=BTECH-01,Authentication=Windows Authentication, Database=CompanyxRef, Trusted_Connection=True")
            Dim command As New SqlCommand(queryString, connection)
            connection.Open()
            '' Call ExecuteReader
            Dim reader As SqlDataReader = command.ExecuteReader()

            '' Call GetOrdinal and assign value to variable.
            Dim ClientKey As Integer = reader.GetOrdinal("ClientpKey")

            '' Dim ArrayOfClientpkeys New As ArrayList
            '' Use variable with GetString inside of loop.
            Do While reader.Read()
                ClientKey = reader.GetString(ClientKey)
                Console.WriteLine(ClientKey)
                Console.ReadKey()
                ' build array of Clientpkeys

            Loop

        End Using

        Return 1  ' Return ArrayOfClientpkeys

    End Function
End Class

