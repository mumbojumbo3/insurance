<cfclient>
	<cfscript>
		window.dsName = 'insurance';
		
		public boolean function checkIfDatabaseExists(){
			try{
				queryExecute("SELECT claimID from claim LIMIT 1",[],{"datasource":#window.dsName#});
				return true;
			}catch(any e){
				return false;
			}
		}
		
		public void function generateDatabase(){
			return invokeInSyncMode(createTables());
		}
		
		public void function saveData(table,rowData){
			switch(table){
				case 'claim':
					if(rowData.update){
						updateClaim(rowData);
					}else{
						saveClaim(rowData);
					}
				break;
				
				case 'claimComment':
					if(rowData.update){
						updateClaimComment(rowData);
					}else{
						saveClaimComment(rowData);
					}
				break;
				
				case 'claimImages':
					if(rowData.update){
						updateClaimImages(rowData);
					}else{
						saveClaimImages(rowData);
					}
				break;
				
				case 'payments':
					if(rowData.update){
						updatePayments(rowData);
					}else{
						savePayments(rowData);
					}
				break;
				
				case 'policy':
					if(rowData.update){
						updatePolicy(rowData);
					}else{
						savePolicy(rowData);
					}
				break;
				
				case 'policyDocument':
					if(rowData.update){
						updatePolicyDocument(rowData);
					}else{
						savePolicyDocument(rowData);
					}
				break;
				
				
			}
			
		}
		
		public void function saveClaim(data){
			queryExecute('INSERT INTO claim(claimid, policyID,claimDate, vehicle, numberOfOccupants, vehicleDamage, causeOfDamage, accidentType, relatedInjuries, policeReportNumber, policeDepartmentArea, claimStatus, accidentLocationLat, accidentLocationLon, accidentLocationAddress, accidentLocationCity, accidentLocationState, accidentLocationZip, garageName, garageAddress, garageCity, garageState, garageZip, garageContact, garagePhone, lastUpdatedDate, createdDateTime, modifiedDateTime, deleted,synched) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[data.claimid, data.policyID,data.claimDate, data.vehicle, data.numberOfOccupants, data.vehicleDamage, data.causeOfDamage, data.accidentType, data.relatedInjuries, data.policeReportNumber, data.policeDepartmentArea, data.claimStatus, data.accidentLocationLat, data.accidentLocationLon, data.accidentLocationAddress, data.accidentLocationCity, data.accidentLocationState, data.accidentLocationZip, data.garageName, data.garageAddress, data.garageCity, data.garageState, data.garageZip, data.garageContact, data.garagePhone, data.lastUpdatedDate, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), trueFalseFormat(1)],{"datasource":#window.dsName#});
		}
		
		public void function updateClaim(data){
			queryExecute('UPDATE claim SET policyID=?, claimDate=?, vehicle=?, numberOfOccupants=?, vehicleDamage=?, causeOfDamage=?, accidentType=?, relatedInjuries=?, policeReportNumber=?, policeDepartmentArea=?, claimStatus=?, accidentLocationLat=?, accidentLocationLon=?, accidentLocationAddress=?, accidentLocationCity=?, accidentLocationState=?, accidentLocationZip=?, garageName=?, garageAddress=?, garageCity=?, garageState=?, garageZip=?, garageContact=?, garagePhone=?, lastUpdatedDate=?, createdDateTime=?, modifiedDateTime=?, deleted=? WHERE claimID=?',[ data.policyID,data.claimDate, data.vehicle, data.numberOfOccupants, data.vehicleDamage, data.causeOfDamage, data.accidentType, data.relatedInjuries, data.policeReportNumber, data.policeDepartmentArea, data.claimStatus, data.accidentLocationLat, data.accidentLocationLon, data.accidentLocationAddress, data.accidentLocationCity, data.accidentLocationState, data.accidentLocationZip, data.garageName, data.garageAddress, data.garageCity, data.garageState, data.garageZip, data.garageContact, data.garagePhone, data.lastUpdatedDate, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.claimid],{"datasource":#window.dsName#});
		}
		
		public void function saveClaimComment(data){
			if(!isDefined(data.claimCommentID)){
				data.claimCommentID = createUUID();
			}
			
			if(!isDefined(data.messageDateTime)){
				data.messageDateTime = now();
			}
			
			if(!isDefined(data.repName)){
				data.repName = '';
			}
			
			if(!isDefined(data.createdDateTime)){
				data.createdDateTime = now();
			}
			
			if(!isDefined(data.modifiedDateTime)){
				data.modifiedDateTime = now();
			}

			queryExecute('INSERT INTO claimComment(claimCommentID, claimID, message, messageDateTime, isRep, repName, createdDateTime, modifiedDateTime, deleted, synched)  VALUES (?,?,?,?,?,?,?,?,?,?)',[data.claimCommentID, data.claimID, data.message, data.messageDateTime, trueFalseFormat(data.isRep), data.repName, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), trueFalseFormat(data.synched)],{"datasource":#window.dsName#});
		}
		
		public void function updateClaimComment(data){
			queryExecute('UPDATE claimComment SET claimID=?, message=?, messageDateTime=?, isRep=?, repName=?, createdDateTime=?, modifiedDateTime=?, deleted=?, synched=? WHERE claimCommentID=?',[data.claimID, data.message, data.messageDateTime, trueFalseFormat(data.isRep), data.repName, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), trueFalseFormat(data.synched),data.claimCommentID],{"datasource":#window.dsName#});
		}
		
		public void function saveClaimImages(data){
			queryExecute('INSERT INTO claimImages(claimImageID, claimID, imagePath, createdDateTime, modifiedDateTime, deleted)   VALUES (?,?,?,?,?,?)',[data.claimImageID, data.claimID, data.imagePath, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted)],{"datasource":#window.dsName#});
		}
		
		public void function updateClaimImages(data){
			queryExecute('UPDATE claimImages SET claimID=?, imagePath=?, createdDateTime=?, modifiedDateTime=?, deleted=? WHERE claimImageID=?',[data.claimID, data.imagePath, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.claimImageID],{"datasource":#window.dsName#});
		}
		
		public void function savePolicy(data){
			queryExecute('INSERT INTO policy(policyID, policyNumber, expiration, coverageType, bodilyInjuryLiabilityAmount, bodilyInjuryLiabilityDescription, propertyDamageAmount, propertyDamageDescription, medicalPaymentsAmount, medicalPaymentsDescription, combinedUninsuredAmount, combinedUninsuredDescription, uninsuredMotoristAmount, uninsuredMotoristDescription, createdDateTime, modifiedDateTime, deleted, insuranceCardFilePath)  VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[data.policyID, data.policyNumber, data.expiration, data.coverageType, data.bodilyInjuryLiabilityAmount, data.bodilyInjuryLiabilityDescription, data.propertyDamageAmount, data.propertyDamageDescription, data.medicalPaymentsAmount, data.medicalPaymentsDescription, data.combinedUninsuredAmount, data.combinedUninsuredDescription, data.uninsuredMotoristAmount, data.uninsuredMotoristDescription, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.insuranceCardFilePath],{"datasource":#window.dsName#});
		}
		
		public void function updatePolicy(data){
			queryExecute('UPDATE policy SET policyNumber=?, expiration=?, coverageType=?, bodilyInjuryLiabilityAmount=?, bodilyInjuryLiabilityDescription=?, propertyDamageAmount=?, propertyDamageDescription=?, medicalPaymentsAmount=?, medicalPaymentsDescription=?, combinedUninsuredAmount=?, combinedUninsuredDescription=?, uninsuredMotoristAmount=?, uninsuredMotoristDescription=?, createdDateTime=?, modifiedDateTime=?, deleted=?, insuranceCardFilePath=? WHERE policyID=?',[data.policyNumber, data.expiration, data.coverageType, data.bodilyInjuryLiabilityAmount, data.bodilyInjuryLiabilityDescription, data.propertyDamageAmount, data.propertyDamageDescription, data.medicalPaymentsAmount, data.medicalPaymentsDescription, data.combinedUninsuredAmount, data.combinedUninsuredDescription, data.uninsuredMotoristAmount, data.uninsuredMotoristDescription, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.insuranceCardFilePath, data.policyID],{"datasource":#window.dsName#});
		}
		
		public void function savePolicyDocument(data){
			queryExecute('INSERT INTO policyDocument(policyDocumentID, name, filepath, createdDateTime, modifiedDateTime, deleted, policyID) VALUES (?,?,?,?,?,?,?)',[data.policyDocumentID, data.name, data.filepath, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.policyID],{"datasource":#window.dsName#});
		}
		
		public void function updatePolicyDocument(data){
			queryExecute('UPDATE policyDocument SET name=?, filepath=?, createdDateTime=?, modifiedDateTime=?, deleted=?, policyID=? WHERE policyDocumentID=?',[data.name, data.filepath, data.createdDateTime, data.modifiedDateTime, trueFalseFormat(data.deleted), data.policyID, data.policyDocumentID],{"datasource":#window.dsName#});
		}
		
		public void function savePayments(data){
			queryExecute('INSERT INTO payments(paymentID, policyID, paymentAmount, paymentDate, status, createdDateTime, modifiedDateTime, deleted, paymentMethod)  VALUES (?,?,?,?,?,?,?,?,?)',[data.paymentID, data.policyID, data.paymentAmount, data.paymentDate, data.status, data.createdDateTime, data.modifiedDateTime, data.deleted, data.paymentMethod],{"datasource":#window.dsName#});
		}
		
		public void function updatePayments(data){
			queryExecute('UPDATE payments SET policyID=?, paymentAmount=?, paymentDate=?, status=?, createdDateTime=?, modifiedDateTime=?, deleted=?, paymentMethod=? WHERE paymentID=?',[data.policyID, data.paymentAmount, data.paymentDate, data.status, data.createdDateTime, data.modifiedDateTime, data.deleted, data.paymentMethod,data.paymentID],{"datasource":#window.dsName#});
		}
		
		
		public void function pushUnsynchedImages(){
			var qClaimsImages = queryExecute('SELECT * FROM claimImages WHERE synched="false"',[],{"datasource":#window.dsName#});
			console.log(queryToObject(qClaimsImages));
			
			$(queryToObject(qClaimsImages)).each(function(pos,value){
				uploadFileToServer(value.localimagepath,value.claimimageid);
			});
			
			updateSynchData();
		}
		
		public void function wipeDatabase(){
			queryExecute('drop table if exists claim',[],{"datasource":#window.dsName#});
			queryExecute('drop table if exists claimComment',[],{"datasource":#window.dsName#});
			queryExecute('drop table if exists claimImages',[],{"datasource":#window.dsName#});
			queryExecute('drop table if exists payments',[],{"datasource":#window.dsName#});
			queryExecute('drop table if exists policy',[],{"datasource":#window.dsName#});
			queryExecute('drop table if exists policyDocument',[],{"datasource":#window.dsName#});
			
			invokeInSyncMode(createTables());
			setLastUpdateDate(' ');
		}
		
		public void function setLastUpdateDate(){
			cfclient.localstorage.setItem('dbLastUpdatedDate',now());
		}
		
		public void function clearLastUpdateDate(updatedDate=now()){
			cfclient.localstorage.setItem('dbLastUpdatedDate','');
		}
		
		public void function getLastUpdateDate(){
			try{
				return cfclient.localstorage.getItem('dbLastUpdatedDate');
			}catch (any e){
				return '';
			}
		}
		
		/*Helper Functions */
		
		public boolean function trueFalseFormat(value){
			if(value eq '1' OR value eq 'true' or value eq true){
				return true;
			}else{
				return false;
			}
		}
		
	</cfscript>		
</cfclient>