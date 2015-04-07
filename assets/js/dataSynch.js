var dataSynch = {
	isOnline: false,
	updateURL:'',
	saveURL:'',
	updatesTimer:'',
	dataUpdateFrequency:'',
	init: function(_updateURL,_saveURL,_dataUpdateFrequency,_connectionType){

		dataSynch.updateURL=_updateURL;
		dataSynch.saveURL=_saveURL;
		
		if(_connectionType == 'NONE'){
			dataSynch.offline();
		}else{
			dataSynch.online();
		}
		
		dataSynch.checkDatabaseExists();
		dataSynch.checkForDataUpdates();

		dataSynch.startTimer(_dataUpdateFrequency);
		
	},
	online: function(){
		dataSynch.isOnline=true;
	},
	offline: function(){
		dataSynch.isOnline=false;
	},
	startTimer: function(minutes){
		dataSynch.updatesTimer = setInterval(function(){dataSynch.checkForDataUpdates()},(minutes *1000));
	},
	stopTimer: function(){
		clearInterval(dataSynch.updatesTimer);
	},
	checkDatabaseExists: function(){
		invokeCFClientFunction('checkIfDatabaseExists', function(data) {
			if(!data){
				dataSynch.createDatabase();
			}
		});	
	},
	createDatabase: function(){
		invokeCFClientFunction('generateDatabase', function() {
			dataSynch.checkForDataUpdates();
		});
	},
	checkForDataUpdates: function(){
		if(dataSynch.isOnline){
			invokeCFClientFunction('getLastUpdateDate', function(dateLastUpdated) {
				$.getJSON( dataSynch.updateURL, {
				    userID: app.getUserID(),
				    lastupdateddatetime: dateLastUpdated,
				    format: "json"
				  })
				    .done(function( data ) {
						for(table in data){
							for(row in data[table]){
								invokeCFClientFunction('saveData',table,data[table][row],null);
							}
						}
						  	
						invokeCFClientFunction('setLastUpdateDate');
				    }).error(function(data){
				    	console.log('checkForDataUpdates - error');
				    	console.log('url:' + dataSynch.updateURL);
				    	console.log(data);
				    });
				
			});
		
		}	
	},
	pushUpdates: function(){
		if(dataSynch.isOnline){
			invokeCFClientFunction('getUnsynchedData', function(unsynchedData) {
					for(type in unsynchedData){
						
						for(row in unsynchedData[type]){
							$.getJSON( dataSynch.saveURL, {
							    userID: app.getUserID(),
							    data: JSON.stringify(unsynchedData[type][row]),
							    
							    type:type,
							    format: "json"
							  })
							    .done(function( data ) {
							    	
							    	
							    }).error(function(data,d1,d2,d3,d4){
							    	
							    	console.log('pushUpdates - error');
							    	console.log('url:' + dataSynch.saveURL);
							    	
							    	console.log(type);
							    	console.log(unsynchedData[type][row]);
							    	
							    });
						}
					}
				    invokeCFClientFunction('pushUnsynchedImages');
				});
				
				
				
		}	
	},
	resetDatabase: function(){
		invokeCFClientFunction('wipeDatabase');
	}
}