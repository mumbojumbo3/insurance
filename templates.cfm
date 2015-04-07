<script id="claimsTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Claims</h1>
	    <em class="left-text">A list of all your claims</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/documentsOrClaims.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container" id="claimList">
			<p class="right-text">
				<a class="button-big-icon icon-warning button-magenta" id="startClaim">Start a Claim</a>
			</p>
			{{#claims}}
				<div class="container no-bottom claim" claimID="{{claimid}}">
					<h3>{{claimdate}} - {{accidenttype}}</h3>
					<p>
						<strong>Status:</strong> {{claimstatus}}<br />
						<strong>Model:</strong> {{vehicle}}
					</p>	
				</div>
				<div class="decoration"></div>
			{{/claims}}
		</div>
	</div>	
</script>
<script id="paymentsTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Payments</h1>
	    <em class="left-text">A list of all your payments</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/pay.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container">
			<table>
				<thead>
					<tr>
						<th>
							Date
						</th>	
						<th>
							Status
						</th>	
						<th>
							Amount
						</th>	
						<th>
							Payment Type
						</th>	
					</tr>	
				</thead>
				<tbody>
					{{#payments}}
					<tr>
						<td>
							{{paymentdate}}
						</td>	
						
						<td>
							{{status}}
						</td>	
						<td>
							${{paymentamount}}
						</td>	
						<td>
							{{paymentmethod}}
						</td>	
					</tr>	
					{{/payments}}
				</tbody>
			</table>
		</div>
	</div>		
</script>
	<script id="addClaimTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Add Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content" id="createClaim">
		<div class="container no-bottom" id="accidentDetailsForm" >
			<h3>Accident Details</h3>
			<div class="formFieldWrap">
				<label 	class="field-title accidentDate" for="accidentDate">
					When did the accident occur?
				</label>	
				<input type="date" value="{{accidentDate}}" class="contactField " id="accidentDate">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title vehicleType" for="vehicleType">
					What make and model of vehicle were you driving?
				</label>	
				<input type="text" value="{{vehicleType}}" class="contactField " id="vehicleType">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title accidentType" for="accidentType">
					What type of accident occured?
				</label>	
				<select id="accidentType" class="contactField ">
					<option value=""></option>
					<option value="Collision">Collision</option>
				</select>	
			</div>	
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentDetailsSubmitButton" value="Next" data-formid="contactForm">
			</div>			
		</div>	
		
		<div class="container no-bottom" id="claimDetailsForm" style="display:none">
			<h3>Claim Details</h3>
			<div class="formFieldWrap">
				<label 	class="field-title numberofoccupants" for="numberofoccupants">
					How many occupants were in the vehicle?
				</label>	
				<input type="number" value="{{numberofoccupants}}" class="contactField " id="numberofoccupants">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title vehicledamage" for="vehicledamage">
					Please explain the damage that occured?
				</label>	
				<textarea class="contactTextarea requiredField" id="vehicledamage">{{vehicledamage}}</textarea>
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title causeofdamage" for="causeofdamage">
					How did the damage occur?
				</label>	
				<textarea class="contactTextarea requiredField" id="causeofdamage">{{causeofdamage}}</textarea>
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title relatedinjuries" for="relatedinjuries">
					Were there any injuries? If so, please explain:
				</label>	
				<textarea class="contactTextarea requiredField" id="relatedinjuries">{{relatedinjuries}}</textarea>
			</div>
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="claimDetailsSubmitButton" value="Next" data-formid="contactForm">
			</div>	
		</div>	
		
		<div class="container no-bottom" id="policeReportForm" style="display:none">
			<h3>Police Report</h3>
			<div class="formFieldWrap">
				<label 	class="field-title policereportnumber" for="policereportnumber">
					If a police report was filed, please provide the report number:
				</label>	
				<input type="text" value="{{policereportnumber}}" class="contactField " id="policereportnumber">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title policedepartmentarea" for="policedepartmentarea">
					What police department has jurisdiction of the accident?
				</label>	
				<input type="text" value="{{policedepartmentarea}}" class="contactField " id="policedepartmentarea">
			</div>
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="policeReportSubmitButton" value="Next" data-formid="contactForm">
			</div>
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-red contactSubmitButton" id="policeReportNoreportButton" value="No Police Report" data-formid="contactForm">
			</div>		
		</div>	
		
		<div class="container no-bottom" id="accidentLocationForm" style="display:none">
			<h3>Accident Location</h3>
			
			<div class="formFieldWrap">
				<label 	class="field-title policereportnumber" for="">
					Where did the accident occur?
				</label>	
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentaddress" for="accidentaddress">
					Address:
				</label>	
				<input type="text" value="{{accidentaddress}}" class="contactField " id="accidentaddress">
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentcity" for="accidentcity">
					City:
				</label>	
				<input type="text" value="{{accidentcity}}" class="contactField " id="accidentcity">
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentstate" for="accidentstate">
					State:
				</label>	
				<select id="accidentstate" class="field-title">
					<option value=""></option>
					<option value="NC">NC</option>
				</select>	
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentzip" for="accidentzip">
					Zip:
				</label>	
				<input type="text" value="{{accidentzip}}" class="contactField " id="accidentzip">
			</div>
			<h3>-OR-</h3>
			
			<div class="formFieldWrap" id="locationButton">
				<input type="submit" class="buttonWrap button button-blue currentPositionButton" id="currentPositionButton" value="Use my current Location" data-formid="contactForm">	
			</div>
			
			<div id="locationDisplay" style="display:none">
				<div class="formFieldWrap latitude">
					<label 	class="field-title accidentcity">
						Latitude:
					</label>	
					<span></span>
				</div>
				
				<div class="formFieldWrap longitude">
					<label 	class="field-title accidentcity" for="accidentcity">
						Longitude:
					</label>	
					<span></span>
				</div>
			</div>
			
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentLocationSubmitButton" value="Next" data-formid="contactForm">
			</div>
		</div>
		
		<div class="container no-bottom" id="accidentImagesForm" style="display:none">
			<h3>Accident Images</h3>
			<p>
				If you would like to submit images with your claim, you can do so by either taking new photos by clicking on the camera icon, or by selecting images already on your device by clicking the folder icon.
			</p>	
			
			<div class="one-half">
				<a href="" id="cameraButton">&nbsp;</a>
			</div>
			
			<!--<div class="two-half">
				<a href="" id="folderButton">&nbsp;</a>
			</div>-->			
			
			<div id="selectedImages">
				
			</div>	
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentImagesSubmitButton" value="Next" data-formid="contactForm">
			</div>
		</div>	
		
		<div class="container no-bottom" id="confirmForm" style="display:none">
			<h3>Confirm</h3>
			<p>
				If you are ready to file your claim, click on the button below.
			</p>	
			
			<p>
				Once your claim has been filed, one of our representatives will review it and contact you with any questions.  If at any time you wish to see the status of yoru claim you can do so by clicking on the claims button.
			</p>	
					
			
			<div class="formSubmitButtonErrorsWrap">
				<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="confirmSubmitButton" value="File Claim" data-formid="contactForm">
			</div>
		</div>	
		
		<div class="container no-bottom" id="createSuccessForm" style="display:none">
			<h3>Claim Status</h3>
			
			<div class="big-notification green-notification" id="successNotification" style="display:none">
                <h4 class="uppercase">Your claim has been submitted</h4>
                <p>Your claim has been succesfully submitted.  We will contact you with an update.</p>
            </div>
            
            <div class="big-notification red-notification" id="failureNotification" style="display:none">
                <h4 class="uppercase">Your claim has NOT been submitted</h4>
                <p>Your claim has not been submitted.  Your device does not currently have an internet connection so teh data can not be sent to our systems.  When your device does have an internet connection we will automatically submit your claim for you.</p>
            </div>
			
					
		</div>			
	</div>	
</script>
<!---<script id="addClaimTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom" id="accidentDetailsForm" >
			<h3>Accident Details</h3>
			<div class="formFieldWrap">
				<label 	class="field-title accidentDate" for="accidentDate">
					When did the accident occur?
				</label>	
				<input type="date" value="{{accidentDate}}" class="contactField " id="accidentDate">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title vehicleType" for="vehicleType">
					What make and model of vehicle were you driving?
				</label>	
				<input type="text" value="{{vehicleType}}" class="contactField " id="vehicleType">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title accidentType" for="accidentType">
					What type of accident occured?
				</label>	
				<select id="accidentType" class="contactField ">
					<option value=""></option>
					{{#accidentTypes}}
					<option value="{{accidenttype}}">{{accidenttype}}</option>
					{{/accidentTypes}}
				</select>	
			</div>	
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step2" class="buttonWrap button button-green contactSubmitButton">Next</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentDetailsSubmitButton" value="Next" data-formid="contactForm">--->
			</div>			
		</div>	
	</div>	
</script>	--->

<script id="addClaim2Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			<h3>Claim Details</h3>
			<div class="formFieldWrap">
				<label 	class="field-title numberofoccupants" for="numberofoccupants">
					How many occupants were in the vehicle?
				</label>	
				<input type="number" value="{{numberofoccupants}}" class="contactField " id="numberofoccupants">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title vehicledamage" for="vehicledamage">
					Please explain the damage that occured?
				</label>	
				<textarea class="contactTextarea requiredField" id="vehicledamage">{{vehicledamage}}</textarea>
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title causeofdamage" for="causeofdamage">
					How did the damage occur?
				</label>	
				<textarea class="contactTextarea requiredField" id="causeofdamage">{{causeofdamage}}</textarea>
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title relatedinjuries" for="relatedinjuries">
					Were there any injuries? If so, please explain:
				</label>	
				<textarea class="contactTextarea requiredField" id="relatedinjuries">{{relatedinjuries}}</textarea>
			</div>
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step3" class="buttonWrap button button-green contactSubmitButton">Next</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="claimDetailsSubmitButton" value="Next" data-formid="contactForm">--->
			</div>	
		</div>
	</div>	
</script>	

<script id="addClaim3Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			<h3>Police Report</h3>
			<div class="formFieldWrap">
				<label 	class="field-title policereportnumber" for="policereportnumber">
					If a police report was filed, please provide the report number:
				</label>	
				<input type="text" value="{{policereportnumber}}" class="contactField " id="policereportnumber">
			</div>
			
			<div class="formFieldWrap">
				<label 	class="field-title policedepartmentarea" for="policedepartmentarea">
					What police department has jurisdiction of the accident?
				</label>	
				<input type="text" value="{{policedepartmentarea}}" class="contactField " id="policedepartmentarea">
			</div>
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step4" class="buttonWrap button button-green contactSubmitButton">Next</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="policeReportSubmitButton" value="Next" data-formid="contactForm">--->
			</div>
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step4" class="buttonWrap button button-red contactSubmitButton">No Police Report</a>
				<!---<input type="submit" class="buttonWrap button button-red contactSubmitButton" id="policeReportNoreportButton" value="No Police Report" data-formid="contactForm">--->
			</div>		
		</div>	
	</div>
</script>	

<script id="addClaim4Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			<h3>Accident Location</h3>
			
			<div class="formFieldWrap">
				<label 	class="field-title policereportnumber" for="">
					Where did the accident occur?
				</label>	
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentaddress" for="accidentaddress">
					Address:
				</label>	
				<input type="text" value="{{accidentaddress}}" class="contactField " id="accidentaddress">
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentcity" for="accidentcity">
					City:
				</label>	
				<input type="text" value="{{accidentcity}}" class="contactField " id="accidentcity">
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentstate" for="accidentstate">
					State:
				</label>	
				<select id="accidentstate" class="contactField">
					<option value=""></option>
					<option value="NC">NC</option>
				</select>	
			</div>
			<div class="formFieldWrap">
				<label 	class="field-title accidentzip" for="accidentzip">
					Zip:
				</label>	
				<input type="text" value="{{accidentzip}}" class="contactField " id="accidentzip">
			</div>
			<h3>-OR-</h3>
			
			<div class="formFieldWrap" id="locationButton">
				<input type="submit" class="buttonWrap button button-blue currentPositionButton" id="currentPositionButton" value="Use my current Location" data-formid="contactForm">	
			</div>
			
			<div id="locationDisplay" style="display:none">
				<div class="formFieldWrap latitude">
					<label 	class="field-title accidentcity">
						Latitude:
					</label>	
					<span></span>
				</div>
				
				<div class="formFieldWrap longitude">
					<label 	class="field-title accidentcity" for="accidentcity">
						Longitude:
					</label>	
					<span></span>
				</div>
			</div>
			
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step5" class="buttonWrap button button-green contactSubmitButton">Next</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentLocationSubmitButton" value="Next" data-formid="contactForm">--->
			</div>
		</div>
	</div>	
</script>		

<script id="addClaim5Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">	
		<div class="container no-bottom">
			<h3>Accident Images</h3>
			<p>
				If you would like to submit images with your claim, you can do so by either taking new photos by clicking on the camera icon, or by selecting images already on your device by clicking the folder icon.
			</p>	
			
			<div class="one-half">
				<a href="" id="cameraButton">Camera Icon</a>
			</div>
			
			<div class="two-half">
				<a href="">Folder Icon</a>
			</div>			
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step6" class="buttonWrap button button-green contactSubmitButton">Next</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="accidentImagesSubmitButton" value="Next" data-formid="contactForm">--->
			</div>
		</div>	
	</div>	
</script>	

<script id="addClaim6Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			<h3>Confirm</h3>
			<p>
				If you are ready to file your claim, click on the button below.
			</p>	
			
			<p>
				Once your claim has been filed, one of our representatives will review it and contact you with any questions.  If at any time you wish to see the status of yoru claim you can do so by clicking on the claims button.
			</p>	
					
			
			<div class="formSubmitButtonErrorsWrap">
				<a href="#/createClaim/step7" class="buttonWrap button button-green contactSubmitButton">File Claim</a>
				<!---<input type="submit" class="buttonWrap button button-green contactSubmitButton" id="confirmSubmitButton" value="File Claim" data-formid="contactForm">--->
			</div>
		</div>
	</div>	
</script>

<script id="addClaim7Tmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Create Claim</h1>
	    <em class="left-text">This step by step process will help you to create yoru claim</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/form.jpg" alt="img">
	</div>
	<div class="content">	
		<div class="container no-bottom">
			<h3>Claim Status</h3>
			
			<div class="big-notification green-notification" id="successNotification" style="display:none">
	            <h4 class="uppercase">Your claim has been submitted</h4>
	            <p>Your claim has been succesfully submitted.  We will contact you with an update.</p>
	        </div>
	        
	        <div class="big-notification red-notification" id="failureNotification" style="display:none">
	            <h4 class="uppercase">Your claim has NOT been submitted</h4>
	            <p>Your claim has not been submitted.  Your device does not currently have an internet connection so teh data can not be sent to our systems.  When your device does have an internet connection we will automatically submit your claim for you.</p>
	        </div>
		</div>
	</div>	
</script>
					

<script id="claimTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Claim</h1>
	    <em class="left-text">Information regarding your claim on {{claimdate}}</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/claim.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container">
			<h3>Accident Details</h3>
			<strong>Date:</strong> {{claimdate}}<br />
			<strong>Vehicle:</strong> {{vehicle}}<br />
			<strong>Accident Type:</strong> {{accidenttype}}<br />
			<strong>Status:</strong> {{claimstatus}}</p>
		</div>	
		<div class="container">
			<div class="toggle-1">
				<a class="deploy-toggle-1" href="#">Accident Location</a>
				<div class="toggle-content">
					<p>{{accidentaddress}}<br />
					{{accidentcity}}, {{accidentstate}} {{accidentzip}}</p>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="toggle-2">
				<a class="deploy-toggle-1" href="#">Repair Shop Location</a>
				<div class="toggle-content">
					<p>{{garageaddress}}<br />
					{{garagecity}}, {{garagestate}} {{garagezip}}</p>
					<p><strong>Contact:</strong> {{garagecontact}}</p>
					<p><strong>Phone:</strong> {{garagephone}}</p>
				</div>
			</div>
		</div>		
		<div class="container">	
			<div class="toggle-1">
				<a class="deploy-toggle-1" href="#">Claim Details</a>
				<div class="toggle-content">
					<p><strong>Number of Occupants:</strong> {{numberofoccupants}}</p>
					<p><strong>Vehicle Damage:</strong> {{vehicledamage}}</p>
					<p><strong>Cause of Damage:</strong> {{causeofdamage}}</p>
					<p><strong>Related Injuries:</strong> {{relatedinjuries}}</p>
				</div>
			</div>
		</div>
		<div class="container">	
			<div class="toggle-1">
				<a class="deploy-toggle-1" href="#">Police Details</a>
				<div class="toggle-content">
					<p><strong>Police Report Number:</strong> {{policereportnumber}}</p>
					<p><strong>Police Department:</strong> {{policedepartmentarea}}</p>
				</div>
			</div>
		</div>	
		
		<div class="container">	
			<div class="toggle-1">
				<a class="deploy-toggle-1" href="#" id="commentTitleBar">Comments (<span>{{comments.length}}</span>)</a>
				<div class="toggle-content">
					<div id="commentList">
						{{#comments}}
							{{#isrep}}
								<em class="speach-left-title">{{repname}} says:</em>
							{{/isrep}}
							
							{{^isrep}}
								<em class="speach-right-title">You say:</em>
							{{/isrep}}
							
							<p class="speach-{{#isrep}}left{{/isrep}}{{^isrep}}right blue-bubble{{/isrep}}">{{message}}</p>
							<div class="clear"></div>
						{{/comments}}	
					</div>
					<div class="formFieldWrap">
						<label 	class="field-title comment" for="comment">
							Comment:
						</label>	
						<textarea class="contactTextarea requiredField" id="comment"></textarea>
					</div>
					
					<div class="formSubmitButtonErrorsWrap">
						<a href="#" class="buttonWrap button button-green contactSubmitButton" id="commentBtn" claimid="{{claimid}}">Submit</a>
					</div>
					
				</div>
			</div>
		</div>	

		{{#images.length}}
		<div class="container">	
			<div class="toggle-1">
				<a class="deploy-toggle-1" href="#">Images ({{images.length}})</a>
				<div class="toggle-content">
					{{#images}}
						<p>{{imagePath}}</p>
					{{/images}}
				</div>
			</div>
		</div>	
		{{/images.length}}
		
	</div>	
</script>
<script id="policyDocumentsTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Policy Documents</h1>
	    <em class="left-text">A list of all documents related to your policy</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/documents.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			{{#policyDocuments}}
				<div class="portfolio-item-full-width">
					<a href="{{filepath}}" target="_blank"><img src="assets/images/document_48.png" /></a>
					<a href="{{filepath}}" target="_blank"><h4>{{name}}</h4></a>
					<p>A description about the document</p>
				</div>	
				<div class="decoration"></div>
			{{/policyDocuments}}
		</div>	
	</div>	
</script>	

<script id="policyTmpl" type="text/template">
	<div class="content-section">
	    <h1 class="left-text">Policy</h1>
	    <em class="left-text">Information regarding your policy</em>
	    <div class="overlay"></div>
	    <img class="responsive-image" src="assets/images/policy.jpg" alt="img">
	</div>
	<div class="content">
		<div class="container no-bottom">
			<div class="one-half">
				<h2>For Others</h2>
				<p>
					The below coverages pay out to other parties if the accident is your fault.
				</p>
				<div class="decoration"></div>
				<p>
					Bodily Injury Liability  ${{bodilyinjuryliabilityamount}}
				</p>
				<p>
					{{bodilyinjuryliabilitydescription}}
				</p>
				<p> Pays if you are responsible for another person's injury or death in an auto accident. It also pays for your legal defense.</p>
				<div class="decoration"></div>	
					
				<p>Property Damage Liability  ${{propertydamageamount}}</p>	
				<p>{{propertydamagedescription}}</p>
				<p>Pays if you are responsible for damage to another person's property.</p>
			</div>	
			
			<div class="two-half">
				<h2>For You</h2>
				<p>The below coverages pay out to you and your passengers.</p>
				<div class="decoration"></div>	
				<p>
					Medical Payments  ${{medicalpaymentsamount}}
				</p>
				<p>
					{{medicalpaymentsdescription}}
				</p>
				<p>Pays medical expenses such as surgery, x-rays, ambulance, and physicians, regardless of who was at fault.</p>		
				<div class="decoration"></div>	
				
				<p>
					Combined Uninsured Motorist & Underinsured Motorist  
				</p>	
				<p>
					{{combineduninsureddescription}}
				</p>
				<p>Pays for your injuries caused by an uninsured motorist.</p>	
				<div class="decoration"></div>
				<p>
					Uninsured Motorist Property Damage  ${{uninsuredmotoristamount}}
				</p>
				<p>
					{{uninsuredmotoristdescription}}
				</p>
				<p>
					Pays for damages to your vehicle caused by a driver without insurance.
				</p>				
				
			</div>	
		</div>	
	</div>	
</script>

<script id="insuranceCardTmpl" type="text/template">
	<div class="content">
		<div class="container no-bottom">
			<h1>Insurance Card</h1>
			<p><strong>Policy Number:</strong> {{policynumber}}</p>
			<p><strong>Expiration:</strong> {{expiration}}</p>
			<p><strong>Coverage:</strong> {{coveragetype}}</p>
		</div>
	</div>		
	
</script>