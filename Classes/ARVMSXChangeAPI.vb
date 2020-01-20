Imports System
Imports System.IO
Imports System.IO.File

#Region "Modifications"
'
' Project: AR - VMS integration
' Arthor: Tyrone Russ
' Last date modified: 01/14/2020
'
'
#End Region

Public Class ARVMSXChangeAPI
    ''' <summary>
    ''' Function manages the bit map 
    ''' </summary>
    ''' 

    Public Function CreateXMLFile(inString As String, Optional inLoadFile As Boolean = True) As String

        'Console.WriteLine("Running CreateXMLFile program")

        Try

            Dim sFile As String = System.IO.Path.GetTempPath & "VMS"
            If Not IO.Directory.Exists(sFile) Then IO.Directory.CreateDirectory(sFile)
            System.Threading.Thread.Sleep(700)
            sFile &= "\temp" & Now.Ticks / System.TimeSpan.TicksPerMillisecond & ".xml"
            Dim ss As New System.IO.StreamWriter(sFile)
            ss.WriteLine(inString)
            ss.Close()
            If inLoadFile Then System.Diagnostics.Process.Start(sFile)
            Return sFile

        Catch ex As Exception
            Console.WriteLine("Exception caught: {0}", ex)
        End Try


    End Function

    Public Function DownloadProperty(partnerKey As String, VendorID As String, VendorPassword As String, propertyCompanyKey As String, propertyResident As String, PropertyResidentContactKey As String, iInformationBit As Long, dtpTransactionAsOf As Date) As String

        Try
            ' Function downloads property data, using the Property Tab and Information Bit flag, 
            ' calling VMSDataXChange.DownloadProperty
            '
            ' Console.WriteLine("Inside DownloadProperty function")
            Dim sXML As String
            Dim vmsXChangeRequest As New com.villagemanagementsoftware.VMSDataXChange.VMSDataXChange
            Dim ReturnDataProperty As String

            vmsXChangeRequest.Url = "http://vmsxchange.tssvendor.com/VMSDataXChange.asmx"

            sXML = vmsXChangeRequest.DownloadProperty(partnerKey, VendorID, VendorPassword, Val(propertyCompanyKey), Val(propertyResident), Val(PropertyResidentContactKey), iInformationBit, dtpTransactionAsOf)
            ReturnDataProperty = sXML

            Return ReturnDataProperty
        Catch ex As Exception
            Console.WriteLine("Exception caught: {0}", ex)
        End Try


    End Function


End Class




