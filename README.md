# EXOAzureFunction
Sample Timer Trigger Azure function using the Exchange Online V2 PowerShell module and unattended authentiction.

EXOFunction.ps1 is a example code for using unattended authentication with the Exchange Online V2 module in an Azure function. Additional configuration is required to support this

# Azure Function App Requirements

This is example requires that PowerShell 7 is selected as the Runtime for the Azure Function

# Authentication Requirements

This example leverages an App Registration that has been configured to use a certificate for Authentication. A great way to generate this certificate is using an Azure Key Vault - https://docs.microsoft.com/en-us/azure/key-vault/certificates/certificate-scenarios. The certificate can be self-signed.

Key Vault certificates can be imported directly into the app service for your Azure Function:

[ImportCertificate.png](Documentation/ImportCertificate.png)

# Azure Function App Configuration

Several configuration items must be added to your Azure Function configuration to ensure the function will have access to required information. The following items need to be added:

    WEBSITE_LOAD_CERTIFICATES : The value of this item is the Thumbprint of the certifacte that was imported into the App Service.
    AuthCertThumbprint : This should be the thumbprint value for the certificate that will authenticate to Exchange Online (In almost all cases will the same value as WEBSITE_LOAD_CERTIFICATES)
    ClientID : The value of this item is the ClientID/Application ID from your Azure AD App Registration
    TenantName : The value of this item is the *.onmicrosoft.com domain for your tenant




