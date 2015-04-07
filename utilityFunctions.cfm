<cfclient>
	<cfscript>
		public struct function checkLogin(){
			var response={success:false,userID:''};
			
			try{
				var userID = cfclient.localstorage.getItem('userID');
				if(len(trim(userID ))){
					response.success=true;
					response.userID = userID;
					return response;
				}else{
					return response;
				}
			}catch (any e){
				return response;
			}
		}
		
		public void function setLoginCredentials(credentials){
			cfclient.localstorage.setItem('userID',credentials);
		}
		
		public void function removeLoginCredentials(){
			cfclient.localstorage.setItem('userID','');
		}
		
		
		public struct function getApplicationSettings(){
			var result={dataUpdateFrequency:15,updateURL='',saveURL=''};
			
			try{
				result.updateURL = cfclient.localstorage.getItem('updateURL');
				
				if(isNull(result.updateURL)){
					cfclient.localstorage.setItem('updateURL','http://app.simonfree.com/insurancedata.cfc?method=getUpdatedData');
					result.updateURL='http://app.simonfree.com/insurancedata.cfc?method=getUpdatedData';
				}
			}catch (any e){
				cfclient.localstorage.setItem('updateURL','http://app.simonfree.com/insurancedata.cfc?method=getUpdatedData');
			}
			
			try{
				result.saveURL = cfclient.localstorage.getItem('saveURL');
				
				if(isNull(result.saveURL)){
					cfclient.localstorage.setItem('saveURL','http://app.simonfree.com/insurancedata.cfc?method=updateData');
					result.saveURL='http://app.simonfree.com/insurancedata.cfc?method=updateData';
				}
			}catch (any e){
				cfclient.localstorage.setItem('saveURL','http://app.simonfree.com/insurancedata.cfc?method=updateData');
			}
			

			try{
				result.dataUpdateFrequency = cfclient.localstorage.getItem('dataUpdateFrequency');
				
				if(isNull(result.dataUpdateFrequency)){
					cfclient.localstorage.setItem('dataUpdateFrequency',15);
					result.dataUpdateFrequency=15;
				}
			}catch (any e){
				cfclient.localstorage.setItem('dataUpdateFrequency',15);
			}

			return result;
		}
		
		public boolean function saveApplicationSettings(data){
			cfclient.localstorage.setItem('dataUpdateFrequency',data.dataUpdateFrequency);
			cfclient.localstorage.setItem('updateURL',data.updateURL);
			cfclient.localstorage.setItem('saveURL',data.saveURL);

			dataSynch.stopTimer();
			dataSynch.startTimer(data.dataUpdateFrequency);
			
			return true;
		}
		
		public any function getCurrentPosition(){
			return cfclient.geolocation.getCurrentPosition();
		}
		
		public any function takePicture(){
			var opt = cfclient.camera.getOptions();
			var imageUrl = cfclient.camera.getPicture(opt,false);
			
			var newFilePath = copyFileFromTempToPersistentFileSystem(imageUrl);
			
			pic = cfclient.file.readAsBase64(newFilePath);
			
			$('##selectedImages').append('<img src="data:image/jpeg;base64,' + pic + '" width="100" height="100" />');
			app.claimData.images.push(newFilePath);
		
		}
		
		function copyFileFromTempToPersistentFileSystem (tempFilePath){
			//save existing file system
			var oldFileSystem = cfclient.file.getFileSystem();
		
			//Get file object from the path
			var tmpFile = cfclient.file.get(tempFilePath);
			var path = 'insurance';
			
			if( !cfclient.file.directoryExists(path)){
			 	cfclient.file.createDirectory(path);
			 }
			
		
			//If file with the same name exists in the persistent file system, then try save
			//it with different name
			
			var newFilePath = path + "/" + replace(tmpFile.name,".","_") + "_" + createUUID() + ".jpg";
			
			//Copy file
			cfclient.file.copy(tempFilePath,newFilePath);
		
			//Restore old file system
			cfclient.file.setFileSystem(oldFileSystem.name);
		
			//return new file path
			return newFilePath;
		}
		
		
		
		function uploadFileToServer(imageFilePath,claimImageID){
			
				var uploadOptions = {
					fileKey:"uploadedPicture",
					fileName:"uploadedPictured.jpg",
					claimImageID:claimImageID
				};
			
				cfclient.file.upload(imageFilePath, 'http://app.simonfree.com/fileUpload.cfm?claimimageID='+ claimImageID,
						onFileUploaded, uploadError, uploadOptions
				);
			
				function onFileUploaded(data)
				{
					updateClaimImageWithRemoteFile(claimImageID,$.trim(data.response));
					return data;
				}
			
				function uploadError(err)
				{
					console.log('error');
					console.log(err);
					//See error codes at http://docs.phonegap.com/en/3.3.0/cordova_file_file.md.html#FileTransferError
					if (err.code == 3)
						alert("Error uploading file - Connection error");
					else
						alert("Error uploading file. Code - " + err.code);
				}
			
			}
			
			
		function getFileList(path){
			var opt = cfclient.camera.getOptions();
  			var imageData = cfclient.camera.getPictureFromPhotoLibrary(opt,false);
  			console.log(imageData);
  			
  			pic = cfclient.file.readAsBase64(imageData);
			
			$('##selectedImages').append('<img src="data:image/jpeg;base64,' + pic + '" width="100" height="100" />');
			//app.claimData.images.push(imageData);
			 
			return ;
		}	
		
		function getGalleryImages(){
			
			var path = 'insurance';
			
			if( !cfclient.file.directoryExists(path)){
			 	cfclient.file.createDirectory(path);
			 }
			 
			 var files = cfclient.file.listDirectory(path);
			 var aImages = [];
			 
			 for(aImage in files){
			 	arrayAppend(aImages,cfclient.file.readAsBase64(aImage.fullPath));
			 }
			 
			return aImages;
		}	
	</cfscript>
</cfclient>	