
# Salesforce Map Check In and Check Out

This is Step by Step to install Salesforce Map

### Login to Sandbox

First, login to Salesforce Sandbox and configure the object.

## Environment Variables

To run this project, you will need to add the following environment variables to your Sandbox

### Configure Object Event

Create `Custom Field` with following information:

| Field Name | Field Api Name     | Type                |
| :-------- | :------- | :------------------------- |
| `Check In Latitude` | `Check_In_Latitude__c` | Number(10,7) |
| `Check In Longitude` | `Check_In_Longitude__c` | Number(10,7) |
| `Check In Date` | `Check_In_Date__c` | Date/Time |
| `Check In Address Line` | `Check_In_Address_Line__c` | TextArea |
| `Check Out Latitude` | `Check_Out_Latitude__c` | Number(10,7) |
| `Check Out Longitude` | `Check_Out_Longitude__c` | Number(10,7) |
| `Check Out Date` | `Check_Out_Date__c` | Date/Time |
| `Check Out Address Line` | `Check_Out_Address_Line__c` | TextArea |

Create `Record Type` for Geolocation:

Record Type Name : `Geolocation`


### Configure Custom Label

Create `Custom Label` with following information:

`GeoLocation_API_Key` : Your API key

`Geolocation_URL` : https://api.geoapify.com/v1/geocode/reverse?



### Configure Remote Site Settings

Create `Remote Site` with following information:

`Geoapify` : https://api.geoapify.com

## Deployment

Download the latest file and Open with VSCode. After that, deploy the project to your sandbox.

----------------------------------------------------------------
Thanks :)

