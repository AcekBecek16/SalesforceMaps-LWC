import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
import  gelocation_Controller  from '@salesforce/apex/Geolocation_Controller.GeoapifyReverse';
import  CheckIn_Controller  from '@salesforce/apex/Geolocation_Controller.CreateEventCheckIn';
import { NavigationMixin } from 'lightning/navigation';


export default class CheckInLocation  extends NavigationMixin(LightningElement) {
    @api latitude = null;
	@api longitude = null;
	@api altitude = null;
	@api speed = null;
	@api heading = null;
	@api zoomLevel = 15;
	@api showErrors = false;
	@api showMap = false;
	@track markers = [];
	@api recordId = null;
	@api objectApiName = null;

    
	renderedCallback() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(this.success.bind(this), this.problem.bind(this), {
				enableHighAccuracy: true,
				timeout: 5000,
				maximumAge: 0
			});
		} else if (this.showErrors) {
			this.dispatchEvent(
				new ShowToastEvent({
					message: 'Device does not support geolocation or does not allow it for this application.',
					variant: 'error',
					mode: 'sticky'
				})
			);
		}
	}

	success(position) {
		this.latitude = position.coords.latitude;
		this.longitude = position.coords.longitude;
		this.altitude = position.coords.altitude;
		this.speed = position.coords.speed;
		this.heading = position.coords.heading === NaN ? null : position.coords.heading;
		this.dispatchEvent(new FlowAttributeChangeEvent('latitude', this.latitude));
		this.dispatchEvent(new FlowAttributeChangeEvent('longitude', this.longitude));
		this.dispatchEvent(new FlowAttributeChangeEvent('altitude', this.altitude));
		this.dispatchEvent(new FlowAttributeChangeEvent('speed', this.speed));
		this.dispatchEvent(new FlowAttributeChangeEvent('heading', this.heading));
		if (this.showMap)
			this.markers = [
				{
					location: {
						Latitude: this.latitude,
						Longitude: this.longitude
					}
				}
			];
	}

	problem(error) {
		if (this.showErrors) {
			this.dispatchEvent(
				new ShowToastEvent({
					title: 'Could not retrieve geolocation.',
					message: `Error code ${error.code}: ${error.message}`,
					variant: 'error',
					mode: 'sticky'
				})
			);
		}
	}
	navigateToRecordViewPage(EventId){
		// View a custom object record.
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: EventId,
				objectApiName: 'Event', 
				actionName: 'view'
			}
		});
	}

    CheckIn(event){
        gelocation_Controller({
            latitude: this.latitude,
            longitude: this.longitude,
        })
        .then(res=>{
			const location = new ShowToastEvent({
				title: 'Check In Success',
				message: 'Location '+res,
				variant: 'success',
			});
			this.dispatchEvent(location);
			CheckIn_Controller({
				latitude: this.latitude,
                longitude: this.longitude,
				RecordID: this.recordId,
				Address: res,
				ObjectName: this.objectApiName
			})
			.then(EventID=>{
				this.navigateToRecordViewPage(EventID);
			})
			
		})
        
    }
}