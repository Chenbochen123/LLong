//------------------------------------------------------------------------------
// <auto-generated>
//     此代码由工具生成。
//     运行时版本:4.0.30319.34209
//
//     对此文件的更改可能会导致不正确的行为，并且如果
//     重新生成代码，这些更改将会丢失。
// </auto-generated>
//------------------------------------------------------------------------------

// 
// 此源代码由 wsdl 自动生成, Version=4.0.30319.33440。
// 
namespace Mesnac.Interface.Webservice.SapInterface {
    using System.Diagnostics;
    using System;
    using System.Xml.Serialization;
    using System.ComponentModel;
    using System.Web.Services.Protocols;
    using System.Web.Services;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="SI_DZMES_outBinding", Namespace="http://ll.com/DZMES")]
    public partial class SI_DZMES_outService : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback SI_DZMES_outOperationCompleted;
        
        /// <remarks/>
        public SI_DZMES_outService() {
            this.Url = "http://dpi.linglong.cn:50000/XISOAPAdapter/MessageServlet?channel=:BC_DZMES_SOAP_" +
                "out:CC_DZMES_SOAP_out&version=3.0&Sender.Service=BC_DZMES_SOAP_out&Interface=htt" +
                "p%3A%2F%2Fll.com%2FDZMES%5ESI_DZMES_out";
        }
        
        /// <remarks/>
        public event SI_DZMES_outCompletedEventHandler SI_DZMES_outCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://sap.com/xi/WebService/soap1.1", OneWay=true, Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Bare)]
        public void SI_DZMES_out([System.Xml.Serialization.XmlElementAttribute(Namespace="http://ll.com/DZMES")] DT_MES_in MT_DZMES_out) {
            this.Invoke("SI_DZMES_out", new object[] {
                        MT_DZMES_out});
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginSI_DZMES_out(DT_MES_in MT_DZMES_out, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("SI_DZMES_out", new object[] {
                        MT_DZMES_out}, callback, asyncState);
        }
        
        /// <remarks/>
        public void EndSI_DZMES_out(System.IAsyncResult asyncResult) {
            this.EndInvoke(asyncResult);
        }
        
        /// <remarks/>
        public void SI_DZMES_outAsync(DT_MES_in MT_DZMES_out) {
            this.SI_DZMES_outAsync(MT_DZMES_out, null);
        }
        
        /// <remarks/>
        public void SI_DZMES_outAsync(DT_MES_in MT_DZMES_out, object userState) {
            if ((this.SI_DZMES_outOperationCompleted == null)) {
                this.SI_DZMES_outOperationCompleted = new System.Threading.SendOrPostCallback(this.OnSI_DZMES_outOperationCompleted);
            }
            this.InvokeAsync("SI_DZMES_out", new object[] {
                        MT_DZMES_out}, this.SI_DZMES_outOperationCompleted, userState);
        }
        
        private void OnSI_DZMES_outOperationCompleted(object arg) {
            if ((this.SI_DZMES_outCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.SI_DZMES_outCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://ll.com/DZMES")]
    public partial class DT_MES_in {
        
        private DT_Rphead rpheadField;
        
        private DT_ProductionsProduction[] productionsField;
        
        private DT_RetProductionsRetProduction[] retProductionsField;
        
        private DT_RealDNsRealDN[] realDNsField;
        
        private DT_ReversalsReversal[] reversalsField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public DT_Rphead Rphead {
            get {
                return this.rpheadField;
            }
            set {
                this.rpheadField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("Production", Form=System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable=false)]
        public DT_ProductionsProduction[] Productions {
            get {
                return this.productionsField;
            }
            set {
                this.productionsField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("RetProduction", Form=System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable=false)]
        public DT_RetProductionsRetProduction[] RetProductions {
            get {
                return this.retProductionsField;
            }
            set {
                this.retProductionsField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("RealDN", Form=System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable=false)]
        public DT_RealDNsRealDN[] RealDNs {
            get {
                return this.realDNsField;
            }
            set {
                this.realDNsField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("Reversal", Form=System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable=false)]
        public DT_ReversalsReversal[] Reversals {
            get {
                return this.reversalsField;
            }
            set {
                this.reversalsField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://ll.com/DZMES")]
    public partial class DT_Rphead {
        
        private string mSGIDField;
        
        private string bUSIDField;
        
        private string bUSTYPField;
        
        private string tLDIDField;
        
        private string tLGNAMField;
        
        private string dTSENDField;
        
        private string sENDERField;
        
        private string rECIEVERField;
        
        private string dummy1Field;
        
        private string dummy2Field;
        
        private string dummy3Field;
        
        private string dummy4Field;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string MSGID {
            get {
                return this.mSGIDField;
            }
            set {
                this.mSGIDField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string BUSID {
            get {
                return this.bUSIDField;
            }
            set {
                this.bUSIDField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string BUSTYP {
            get {
                return this.bUSTYPField;
            }
            set {
                this.bUSTYPField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string TLDID {
            get {
                return this.tLDIDField;
            }
            set {
                this.tLDIDField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string TLGNAM {
            get {
                return this.tLGNAMField;
            }
            set {
                this.tLGNAMField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string DTSEND {
            get {
                return this.dTSENDField;
            }
            set {
                this.dTSENDField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string SENDER {
            get {
                return this.sENDERField;
            }
            set {
                this.sENDERField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string RECIEVER {
            get {
                return this.rECIEVERField;
            }
            set {
                this.rECIEVERField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy1 {
            get {
                return this.dummy1Field;
            }
            set {
                this.dummy1Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy2 {
            get {
                return this.dummy2Field;
            }
            set {
                this.dummy2Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy3 {
            get {
                return this.dummy3Field;
            }
            set {
                this.dummy3Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy4 {
            get {
                return this.dummy4Field;
            }
            set {
                this.dummy4Field = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_ProductionsProduction {
        
        private string seridField;
        
        private string productTypeField;
        
        private string plantField;
        
        private string materialCodeField;
        
        private string proVersionField;
        
        private string qtyField;
        
        private string rejectQtyField;
        
        private string rejectMatCodeField;
        
        private string postDateField;
        
        private string docDateField;
        
        private string storageLocField;
        
        private string batchField;
        
        private string headTxtField;
        
        private string dummy1Field;
        
        private string dummy2Field;
        
        private string dummy3Field;
        
        private string dummy4Field;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Serid {
            get {
                return this.seridField;
            }
            set {
                this.seridField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string ProductType {
            get {
                return this.productTypeField;
            }
            set {
                this.productTypeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Plant {
            get {
                return this.plantField;
            }
            set {
                this.plantField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string MaterialCode {
            get {
                return this.materialCodeField;
            }
            set {
                this.materialCodeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string ProVersion {
            get {
                return this.proVersionField;
            }
            set {
                this.proVersionField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Qty {
            get {
                return this.qtyField;
            }
            set {
                this.qtyField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string RejectQty {
            get {
                return this.rejectQtyField;
            }
            set {
                this.rejectQtyField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string RejectMatCode {
            get {
                return this.rejectMatCodeField;
            }
            set {
                this.rejectMatCodeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string PostDate {
            get {
                return this.postDateField;
            }
            set {
                this.postDateField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string DocDate {
            get {
                return this.docDateField;
            }
            set {
                this.docDateField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string StorageLoc {
            get {
                return this.storageLocField;
            }
            set {
                this.storageLocField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Batch {
            get {
                return this.batchField;
            }
            set {
                this.batchField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string HeadTxt {
            get {
                return this.headTxtField;
            }
            set {
                this.headTxtField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy1 {
            get {
                return this.dummy1Field;
            }
            set {
                this.dummy1Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy2 {
            get {
                return this.dummy2Field;
            }
            set {
                this.dummy2Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy3 {
            get {
                return this.dummy3Field;
            }
            set {
                this.dummy3Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy4 {
            get {
                return this.dummy4Field;
            }
            set {
                this.dummy4Field = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_RetProductionsRetProduction {
        
        private string seridField;
        
        private string productTypeField;
        
        private string plantField;
        
        private string componentMatField;
        
        private string qtyField;
        
        private string rejectQtyField;
        
        private string rejectMatCodeField;
        
        private string headMatCodeField;
        
        private string headMatVersionField;
        
        private string costCenterField;
        
        private string postDateField;
        
        private string docDateField;
        
        private string storageLocField;
        
        private string headTxtField;
        
        private string dummy1Field;
        
        private string dummy2Field;
        
        private string dummy3Field;
        
        private string dummy4Field;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Serid {
            get {
                return this.seridField;
            }
            set {
                this.seridField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string ProductType {
            get {
                return this.productTypeField;
            }
            set {
                this.productTypeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Plant {
            get {
                return this.plantField;
            }
            set {
                this.plantField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string ComponentMat {
            get {
                return this.componentMatField;
            }
            set {
                this.componentMatField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Qty {
            get {
                return this.qtyField;
            }
            set {
                this.qtyField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string RejectQty {
            get {
                return this.rejectQtyField;
            }
            set {
                this.rejectQtyField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string RejectMatCode {
            get {
                return this.rejectMatCodeField;
            }
            set {
                this.rejectMatCodeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string HeadMatCode {
            get {
                return this.headMatCodeField;
            }
            set {
                this.headMatCodeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string HeadMatVersion {
            get {
                return this.headMatVersionField;
            }
            set {
                this.headMatVersionField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string CostCenter {
            get {
                return this.costCenterField;
            }
            set {
                this.costCenterField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string PostDate {
            get {
                return this.postDateField;
            }
            set {
                this.postDateField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string DocDate {
            get {
                return this.docDateField;
            }
            set {
                this.docDateField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string StorageLoc {
            get {
                return this.storageLocField;
            }
            set {
                this.storageLocField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string HeadTxt {
            get {
                return this.headTxtField;
            }
            set {
                this.headTxtField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy1 {
            get {
                return this.dummy1Field;
            }
            set {
                this.dummy1Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy2 {
            get {
                return this.dummy2Field;
            }
            set {
                this.dummy2Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy3 {
            get {
                return this.dummy3Field;
            }
            set {
                this.dummy3Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy4 {
            get {
                return this.dummy4Field;
            }
            set {
                this.dummy4Field = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_RealDNsRealDN {
        
        private DT_RealDNsRealDNDNHeader dNHeaderField;
        
        private DT_RealDNsRealDNDNItem[] dNItemField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public DT_RealDNsRealDNDNHeader DNHeader {
            get {
                return this.dNHeaderField;
            }
            set {
                this.dNHeaderField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute("DNItem", Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public DT_RealDNsRealDNDNItem[] DNItem {
            get {
                return this.dNItemField;
            }
            set {
                this.dNItemField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_RealDNsRealDNDNHeader {
        
        private string sNNoField;
        
        private string sRFlagField;
        
        private string deliveryDateField;
        
        private string dummy1Field;
        
        private string dummy2Field;
        
        private string dummy3Field;
        
        private string dummy4Field;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string SNNo {
            get {
                return this.sNNoField;
            }
            set {
                this.sNNoField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string SRFlag {
            get {
                return this.sRFlagField;
            }
            set {
                this.sRFlagField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string DeliveryDate {
            get {
                return this.deliveryDateField;
            }
            set {
                this.deliveryDateField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy1 {
            get {
                return this.dummy1Field;
            }
            set {
                this.dummy1Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy2 {
            get {
                return this.dummy2Field;
            }
            set {
                this.dummy2Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy3 {
            get {
                return this.dummy3Field;
            }
            set {
                this.dummy3Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy4 {
            get {
                return this.dummy4Field;
            }
            set {
                this.dummy4Field = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_RealDNsRealDNDNItem {
        
        private string lineItemNoField;
        
        private string materialCodeField;
        
        private string plantField;
        
        private string storageLocField;
        
        private string qtyField;
        
        private string batchField;
        
        private string dummy1Field;
        
        private string dummy2Field;
        
        private string dummy3Field;
        
        private string dummy4Field;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string LineItemNo {
            get {
                return this.lineItemNoField;
            }
            set {
                this.lineItemNoField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string MaterialCode {
            get {
                return this.materialCodeField;
            }
            set {
                this.materialCodeField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Plant {
            get {
                return this.plantField;
            }
            set {
                this.plantField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string StorageLoc {
            get {
                return this.storageLocField;
            }
            set {
                this.storageLocField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Qty {
            get {
                return this.qtyField;
            }
            set {
                this.qtyField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Batch {
            get {
                return this.batchField;
            }
            set {
                this.batchField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy1 {
            get {
                return this.dummy1Field;
            }
            set {
                this.dummy1Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy2 {
            get {
                return this.dummy2Field;
            }
            set {
                this.dummy2Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy3 {
            get {
                return this.dummy3Field;
            }
            set {
                this.dummy3Field = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string Dummy4 {
            get {
                return this.dummy4Field;
            }
            set {
                this.dummy4Field = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType=true, Namespace="http://ll.com/DZMES")]
    public partial class DT_ReversalsReversal {
        
        private string matDocField;
        
        private string docYearField;
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string MatDoc {
            get {
                return this.matDocField;
            }
            set {
                this.matDocField = value;
            }
        }
        
        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(Form=System.Xml.Schema.XmlSchemaForm.Unqualified)]
        public string DocYear {
            get {
                return this.docYearField;
            }
            set {
                this.docYearField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.33440")]
    public delegate void SI_DZMES_outCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
}
