<cfclient>
	<cfscript>
		/**********
		Select Queries
		**********/
		window.dsName = 'insurance';
		
		public any function getClaims(){
			var qClaims = queryExecute('SELECT * FROM claim WHERE deleted="false" ORDER BY claimDate DESC ',[],{"datasource":#window.dsName#});
			return JSON.stringify(queryToObject(qClaims));
		}
		
		public any function getClaim(claimID){
			var qClaim = queryExecute('SELECT * FROM claim WHERE claimID=? AND deleted="false"',[claimID],{"datasource":#window.dsName#});
			var data = rowToObject(qClaim);
			data.comments = getClaimComments(trim(claimID));
			data.images=getClaimImages(trim(claimID));
			return data;
		}
		
		public any function getPolicy(){
			var qPolicy = queryExecute('SELECT* FROM policy WHERE deleted="false" LIMIT 1',[],{"datasource":#window.dsName#});
			return JSON.stringify(rowToObject(qPolicy));
		}
		
		public any function getClaimComments(claimID){
			var qComments = queryExecute('SELECT * FROM claimComment WHERE claimID=? AND deleted="false"  ORDER BY createdDateTime',[claimID],{"datasource":#window.dsName#});
			return queryToObject(qComments);
		}
		
		
		public any function getClaimImages(claimID){
			var qImages = queryExecute('SELECT * FROM claimImages WHERE claimID=? AND deleted="false" ',[claimID],{"datasource":#window.dsName#});
			return queryToObject(qImages);
		}

		public any function getPayments(){
			var qPayments = queryExecute('SELECT * FROM payments WHERE deleted=0 ORDER BY paymentDate DESC',[],{"datasource":#window.dsName#});
			return JSON.stringify(queryToObject(qPayments));
		}
		
		public any function getPolicyDocuments(){
			var qDocuments = queryExecute('SELECT * FROM policyDocument WHERE deleted = "false" ORDER BY name',[],{"datasource":#window.dsName#});
			return JSON.stringify(queryToObject(qDocuments));
		}
		
		public any function getUnsynchedData(){
			var qClaims = queryExecute('SELECT * FROM claim WHERE synched="false"',[],{"datasource":#window.dsName#});
			var qClaimsImages = queryExecute('SELECT * FROM claimImages WHERE synched="false"',[],{"datasource":#window.dsName#});
			var qClaimsComments = queryExecute('SELECT * FROM claimComment WHERE synched="false"',[],{"datasource":#window.dsName#});
			return {claim:queryToObject(qClaims),claimImages:queryToObject(qClaimsImages),claimComment:queryToObject(qClaimsComments)};
		}
		
		/*******
		Update Functions
		*******/
		
		public any function saveClaimData(data){
			var claimID = createUUID();
			queryExecute('INSERT INTO claim(claimid, policyID,claimDate, vehicle, numberOfOccupants, vehicleDamage, causeOfDamage, accidentType, relatedInjuries, policeReportNumber, policeDepartmentArea, claimStatus, accidentLocationLat, accidentLocationLon, accidentLocationAddress, accidentLocationCity, accidentLocationState, accidentLocationZip, garageName, garageAddress, garageCity, garageState, garageZip, garageContact, garagePhone, lastUpdatedDate, createdDateTime, modifiedDateTime, deleted,synched) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',[claimID, '',data.accidentDate, data.vehicleType, data.numberofoccupants, data.vehicledamage, data.causeofdamage, data.accidentType, data.relatedinjuries, data.policereportnumber, data.policedepartmentarea, 'Pending', data.accidentlatitude, data.accidentlongitude, data.accidentaddress, data.accidentcity, data.accidentstate, data.accidentzip, '', '', '', '', '', '', '', now(), now(), now(), false,false],{"datasource":#window.dsName#});
			console.log(claimID);
			console.log(app.claimData.images);
			$(app.claimData.images).each(function(pos,value){
				queryExecute('INSERT INTO claimImages(claimImageID, claimID, imagePath, localImagePath, createdDateTime, modifiedDateTime, deleted,synched)   VALUES (?,?,?,?,?,?,?,?)',[createUUID(), claimID, '', value, now(), now(), trueFalseFormat(0), trueFalseFormat(0)],{"datasource":#window.dsName#});
			});
			
		}

		public void function updateSynchData(){
			queryExecute('UPDATE claim SET synched=1',[],{"datasource":#window.dsName#});
			queryExecute('UPDATE claimImages SET synched=1',[],{"datasource":#window.dsName#});
			queryExecute('UPDATE claimComment SET synched=1',[],{"datasource":#window.dsName#});
		}
		
		public void function updateClaimImageWithRemoteFile(claimImageID,imagePath){
			queryExecute('UPDATE claimImages SET imagePath=? WHERE claimImageID=?',[imagePath,claimImageID],{"datasource":#window.dsName#});
		}
		
		
		/********
			Table Creation Functions
		********/
		public boolean function createTables(){
			createClaimTable();
			createClaimCommentTable();
			createclaimImagesTable();
			createPaymentsTable();
			createPolicyTable();
			createPolicyDocumentTable();
			createAccidentTypeTable();
			return true;
		}				
		
		public void function createClaimTable(){
			queryExecute('create table if not exists claim (
				claimid varchar(40) NOT NULL,
				policyID           	varchar(200) NULL,
				claimDate              	datetime NULL,
				vehicle                	varchar(200) NULL,
				numberOfOccupants      	int(11) NULL,
				vehicleDamage          	text NULL,
				causeOfDamage          	text NULL,
				accidentType           	varchar(200) NULL,
				relatedInjuries        	text NULL,
				policeReportNumber     	varchar(100) NULL,
				policeDepartmentArea   	varchar(200) NULL,
				claimStatus            	varchar(100) NULL,
				accidentLocationLat    	varchar(100) NULL,
				accidentLocationLon    	varchar(100) NULL,
				accidentLocationAddress	varchar(100) NULL,
				accidentLocationCity   	varchar(100) NULL,
				accidentLocationState  	varchar(25) NULL,
				accidentLocationZip    	varchar(25) NULL,
				garageName             	varchar(100) NULL,
				garageAddress          	varchar(100) NULL,
				garageCity             	varchar(100) NULL,
				garageState            	varchar(25) NULL,
				garageZip              	varchar(25) NULL,
				garageContact          	varchar(100) NULL,
				garagePhone            	varchar(100) NULL,
				lastUpdatedDate        	datetime NULL,
				createdDateTime        	datetime NULL,
				modifiedDateTime       	datetime NULL,
				deleted                	bit(1) NULL,
				synched                	bit(1) NULL
				);',[],{"datasource":#window.dsName#});
			return;
		
		
		}
		
		public void function createClaimCommentTable(){
			queryExecute('create table if not exists claimComment  ( 
				claimCommentID  	varchar(40) NULL,
				claimID         	varchar(40) NULL,
				message         	text NULL,
				messageDateTime 	datetime NULL,
				isRep           	bit(1) NULL,
				repName         	varchar(100) NULL,
				createdDateTime 	datetime NULL,
				modifiedDateTime	datetime NULL,
				deleted         	bit(1) NULL ,
				synched         	bit(1) NULL 
				);',[],{"datasource":#window.dsName#});
			return;	
		}
		
		
		
		public void function createclaimImagesTable(){
			queryExecute('create table if not exists claimImages  ( 
				claimImageID    	varchar(40) NULL,
				claimID         	varchar(40) NULL,
				imagePath       	varchar(200) NULL,
				localImagePath       	varchar(200) NULL,
				createdDateTime 	datetime NULL,
				modifiedDateTime	datetime NULL,
				deleted         	bit(1) NULL,
				synched         	bit(1) NULL  
				);',[],{"datasource":#window.dsName#});
			return;	
		}
		
		public void function createPaymentsTable(){
			queryExecute('create table if not exists payments  ( 
				paymentID       	varchar(40) NULL,
				policyID        	varchar(40) NULL,
				paymentAmount   	float NULL,
				paymentDate     	date NULL,
				status          	varchar(40) NULL,
				createdDateTime 	datetime NULL,
				modifiedDateTime	datetime NULL,
				deleted         	bit(1) NULL,
				paymentMethod   	varchar(50) NULL 
				);',[],{"datasource":#window.dsName#});
			return;	
		}
		
		public void function createPolicyTable(){
			queryExecute('create table if not exists policy( 
				policyID                        	varchar(25) NULL,
				policyNumber                    	varchar(25) NULL,
				expiration                      	datetime NULL,
				coverageType                    	varchar(25) NULL,
				bodilyInjuryLiabilityAmount     	float NULL,
				bodilyInjuryLiabilityDescription	varchar(200) NULL,
				propertyDamageAmount            	float NULL,
				propertyDamageDescription       	varchar(200) NULL,
				medicalPaymentsAmount           	float NULL,
				medicalPaymentsDescription      	varchar(200) NULL,
				combinedUninsuredAmount         	float NULL,
				combinedUninsuredDescription    	varchar(200) NULL,
				uninsuredMotoristAmount         	float NULL,
				uninsuredMotoristDescription    	varchar(200) NULL,
				createdDateTime                 	datetime NULL,
				modifiedDateTime                	datetime NULL,
				deleted                         	bit(1) NULL,
				insuranceCardFilePath           	varchar(200) NULL 
				);',[],{"datasource":#window.dsName#});
			return;	
		}
		
		public void function createPolicyDocumentTable(){
			queryExecute('create table if not exists policyDocument  ( 
				policyDocumentID	varchar(25) NULL,
				name            	varchar(200) NULL,
				filepath        	varchar(200) NULL,
				createdDateTime 	datetime NULL,
				modifiedDateTime	datetime NULL,
				deleted         	bit(1) NULL,
				policyID        	varchar(25) NULL 
				);',[],{"datasource":#window.dsName#});
			return;	
		}
		
		public void function createAccidentTypeTable(){
			queryExecute('create table if not exists accidentType  ( 
				accidentTypeID	varchar(40) NULL,
				accidentType            	varchar(200) NULL
				);',[],{"datasource":#window.dsName#});
				
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Collission'],{"datasource":#window.dsName#});
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Weather'],{"datasource":#window.dsName#});
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Animal'],{"datasource":#window.dsName#});
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Theft'],{"datasource":#window.dsName#});
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Vandelism'],{"datasource":#window.dsName#});
			queryExecute('INSERT INTO accidentType (accidentTypeID,accidentType) VALUES (?,?)',[createUUID(),'Breakdown'],{"datasource":#window.dsName#});
		}
		
		
		
		/************
		helper function
		*************/
		
		
	</cfscript>		
</cfclient>