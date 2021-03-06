﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.42000
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict Off
Option Explicit On

Imports System
Imports System.ComponentModel
Imports System.Data
Imports System.Diagnostics
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml.Serialization

'
'This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.42000.
'
Namespace com.villagemanagementsoftware.VMSCollectionXChange
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code"),  _
     System.Web.Services.WebServiceBindingAttribute(Name:="VMSCollectionXChangeSoap", [Namespace]:="http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd")>  _
    Partial Public Class VMSCollectionXChange
        Inherits System.Web.Services.Protocols.SoapHttpClientProtocol
        
        Private CollectionSynchronizationOperationCompleted As System.Threading.SendOrPostCallback
        
        Private CollectionSynchronizationDSOperationCompleted As System.Threading.SendOrPostCallback
        
        Private useDefaultCredentialsSetExplicitly As Boolean
        
        '''<remarks/>
        Public Sub New()
            MyBase.New
            Me.Url = Global.ARVMSXChangeAPI.My.MySettings.Default.VMSXChangeClientv4_com_villagemanagementsoftware_VMSCollectionXChange_VMSCollectionXChange
            If (Me.IsLocalFileSystemWebService(Me.Url) = true) Then
                Me.UseDefaultCredentials = true
                Me.useDefaultCredentialsSetExplicitly = false
            Else
                Me.useDefaultCredentialsSetExplicitly = true
            End If
        End Sub
        
        Public Shadows Property Url() As String
            Get
                Return MyBase.Url
            End Get
            Set
                If (((Me.IsLocalFileSystemWebService(MyBase.Url) = true)  _
                            AndAlso (Me.useDefaultCredentialsSetExplicitly = false))  _
                            AndAlso (Me.IsLocalFileSystemWebService(value) = false)) Then
                    MyBase.UseDefaultCredentials = false
                End If
                MyBase.Url = value
            End Set
        End Property
        
        Public Shadows Property UseDefaultCredentials() As Boolean
            Get
                Return MyBase.UseDefaultCredentials
            End Get
            Set
                MyBase.UseDefaultCredentials = value
                Me.useDefaultCredentialsSetExplicitly = true
            End Set
        End Property
        
        '''<remarks/>
        Public Event CollectionSynchronizationCompleted As CollectionSynchronizationCompletedEventHandler
        
        '''<remarks/>
        Public Event CollectionSynchronizationDSCompleted As CollectionSynchronizationDSCompletedEventHandler
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd/Col"& _ 
            "lectionSynchronization", RequestNamespace:="http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd", ResponseNamespace:="http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function CollectionSynchronization(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean) As String
            Dim results() As Object = Me.Invoke("CollectionSynchronization", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll})
            Return CType(results(0),String)
        End Function
        
        '''<remarks/>
        Public Function BeginCollectionSynchronization(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean, ByVal callback As System.AsyncCallback, ByVal asyncState As Object) As System.IAsyncResult
            Return Me.BeginInvoke("CollectionSynchronization", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll}, callback, asyncState)
        End Function
        
        '''<remarks/>
        Public Function EndCollectionSynchronization(ByVal asyncResult As System.IAsyncResult) As String
            Dim results() As Object = Me.EndInvoke(asyncResult)
            Return CType(results(0),String)
        End Function
        
        '''<remarks/>
        Public Overloads Sub CollectionSynchronizationAsync(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean)
            Me.CollectionSynchronizationAsync(PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll, Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub CollectionSynchronizationAsync(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean, ByVal userState As Object)
            If (Me.CollectionSynchronizationOperationCompleted Is Nothing) Then
                Me.CollectionSynchronizationOperationCompleted = AddressOf Me.OnCollectionSynchronizationOperationCompleted
            End If
            Me.InvokeAsync("CollectionSynchronization", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll}, Me.CollectionSynchronizationOperationCompleted, userState)
        End Sub
        
        Private Sub OnCollectionSynchronizationOperationCompleted(ByVal arg As Object)
            If (Not (Me.CollectionSynchronizationCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent CollectionSynchronizationCompleted(Me, New CollectionSynchronizationCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd/Col"& _ 
            "lectionSynchronizationDS", RequestNamespace:="http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd", ResponseNamespace:="http://document.villagemanagementsoftware.com/xmlvalidation/vmscollection.xsd", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function CollectionSynchronizationDS(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean) As System.Data.DataSet
            Dim results() As Object = Me.Invoke("CollectionSynchronizationDS", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll})
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '''<remarks/>
        Public Function BeginCollectionSynchronizationDS(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean, ByVal callback As System.AsyncCallback, ByVal asyncState As Object) As System.IAsyncResult
            Return Me.BeginInvoke("CollectionSynchronizationDS", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll}, callback, asyncState)
        End Function
        
        '''<remarks/>
        Public Function EndCollectionSynchronizationDS(ByVal asyncResult As System.IAsyncResult) As System.Data.DataSet
            Dim results() As Object = Me.EndInvoke(asyncResult)
            Return CType(results(0),System.Data.DataSet)
        End Function
        
        '''<remarks/>
        Public Overloads Sub CollectionSynchronizationDSAsync(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean)
            Me.CollectionSynchronizationDSAsync(PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll, Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub CollectionSynchronizationDSAsync(ByVal PartnerKey As String, ByVal VendorID As String, ByVal VendorPassword As String, ByVal CompanyID As Integer, ByVal LastSyncDate As Date, ByVal SendAll As Boolean, ByVal userState As Object)
            If (Me.CollectionSynchronizationDSOperationCompleted Is Nothing) Then
                Me.CollectionSynchronizationDSOperationCompleted = AddressOf Me.OnCollectionSynchronizationDSOperationCompleted
            End If
            Me.InvokeAsync("CollectionSynchronizationDS", New Object() {PartnerKey, VendorID, VendorPassword, CompanyID, LastSyncDate, SendAll}, Me.CollectionSynchronizationDSOperationCompleted, userState)
        End Sub
        
        Private Sub OnCollectionSynchronizationDSOperationCompleted(ByVal arg As Object)
            If (Not (Me.CollectionSynchronizationDSCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent CollectionSynchronizationDSCompleted(Me, New CollectionSynchronizationDSCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        Public Shadows Sub CancelAsync(ByVal userState As Object)
            MyBase.CancelAsync(userState)
        End Sub
        
        Private Function IsLocalFileSystemWebService(ByVal url As String) As Boolean
            If ((url Is Nothing)  _
                        OrElse (url Is String.Empty)) Then
                Return false
            End If
            Dim wsUri As System.Uri = New System.Uri(url)
            If ((wsUri.Port >= 1024)  _
                        AndAlso (String.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) = 0)) Then
                Return true
            End If
            Return false
        End Function
    End Class
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub CollectionSynchronizationCompletedEventHandler(ByVal sender As Object, ByVal e As CollectionSynchronizationCompletedEventArgs)
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code")>  _
    Partial Public Class CollectionSynchronizationCompletedEventArgs
        Inherits System.ComponentModel.AsyncCompletedEventArgs
        
        Private results() As Object
        
        Friend Sub New(ByVal results() As Object, ByVal exception As System.Exception, ByVal cancelled As Boolean, ByVal userState As Object)
            MyBase.New(exception, cancelled, userState)
            Me.results = results
        End Sub
        
        '''<remarks/>
        Public ReadOnly Property Result() As String
            Get
                Me.RaiseExceptionIfNecessary
                Return CType(Me.results(0),String)
            End Get
        End Property
    End Class
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub CollectionSynchronizationDSCompletedEventHandler(ByVal sender As Object, ByVal e As CollectionSynchronizationDSCompletedEventArgs)
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code")>  _
    Partial Public Class CollectionSynchronizationDSCompletedEventArgs
        Inherits System.ComponentModel.AsyncCompletedEventArgs
        
        Private results() As Object
        
        Friend Sub New(ByVal results() As Object, ByVal exception As System.Exception, ByVal cancelled As Boolean, ByVal userState As Object)
            MyBase.New(exception, cancelled, userState)
            Me.results = results
        End Sub
        
        '''<remarks/>
        Public ReadOnly Property Result() As System.Data.DataSet
            Get
                Me.RaiseExceptionIfNecessary
                Return CType(Me.results(0),System.Data.DataSet)
            End Get
        End Property
    End Class
End Namespace
