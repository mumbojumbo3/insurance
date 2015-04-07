var app = {

	isOnline: false,
	claimData: {images:[]},
	userID:'',
	init: function () {
		"use strict";
		app.bindEvents();
		app.docReady();
	},
	
	bindEvents: function () {
		$('body').on('click','#loginButton',function(){
			
			$.ajax({
			  type: 'GET',
				  url: 'http://app.simonfree.com/insuranceaccount.cfc?method=login',
				 data: { username: $('#username').val(), password: $('#password').val() },
				  dataType: 'json',
				  success: function(data){
				  	if(data.SUCCESS){
				  		app.setLoginCredentials(data.LOGINTOKEN);
				  		app.setUserID(data.LOGINTOKEN);
						app.viewHome();
				  	}else{
				  		$('#loginStatus').html(data.MESSAGE);
				  		$('#loginStatus').show();
				  	}
				  },
				  error: function(xhr, type){
				  	console.log('error');
				    console.log(type);
				    console.log(xhr);
				  }
				});
		});
		
		$('#account').on('click','.logoutButton',function(e){
			e.preventDefault();
			invokeCFClientFunction('removeLoginCredentials', null, function(data) {
				$('#username').val('');
				$('#password').val('');
				$('#loginStatus').html('You have been logged out');
				$('#loginStatus').show();
				app.viewLogin();
			});	
		});
		
		
		
		$('#claims').on('click','.claim',function(){
			app.viewClaim($(this).attr('claimID'));
		})
		
		$('#claim').on('click','.deploy-toggle-1',function(){
			$(this).parent().find('.toggle-content').toggle(100);
			$(this).toggleClass('toggle-1-active');
			return false;
		});
		
		$('#claim').on('click','#commentBtn',function(e){
			e.preventDefault();
			saveClaimComment({claimID:$(this).attr('claimid'), message:$('#comment').val(),isRep:0,deleted:0,synched:0} );
			$('#commentList').append('<em class="speach-right-title">You say:</em><p class="speach-right blue-bubble">' + $('#comment').val() + '</p><div class="clear"></div>')
			$('#comment').val('');
		});
		
		
		$('.show-navigation').click(function(){
			showNavigation()
			return false;
		});
		
		$('.hide-navigation').click(function(){
			hideNavigation();
			return false;
		});
			
		$('.submenu-item').click(function(){
			$(this).parent().find('.dropdown-item').toggleClass('active-dropdown');
			$(this).parent().find('.submenu').toggle(150);
			return false;
		});
		$('body').on('click','#startClaim',function(e){
			e.preventDefault();
			app.viewCreateClaim();
		});
		
		$('#createClaim').on('click','#accidentDetailsSubmitButton',function(){
			app.claimData.accidentDate=$('#accidentDate').val();
			app.claimData.vehicleType=$('#vehicleType').val();
			app.claimData.accidentType=$('#accidentType').val();
			
			$('#accidentDetailsForm').hide();
			$('#claimDetailsForm').show();
		});
		
		$('#createClaim').on('click','#claimDetailsSubmitButton',function(){
			app.claimData.numberofoccupants=$('#numberofoccupants').val();
			app.claimData.vehicledamage=$('#vehicledamage').val();
			app.claimData.causeofdamage=$('#causeofdamage').val();
			app.claimData.relatedinjuries=$('#relatedinjuries').val();
			
			$('#claimDetailsForm').hide();
			$('#policeReportForm').show();
		});
		
		$('#createClaim').on('click','#policeReportSubmitButton',function(){
			app.claimData.policereportnumber=$('#policereportnumber').val();
			app.claimData.policedepartmentarea=$('#policedepartmentarea').val();
			
			$('#policeReportForm').hide();
			$('#accidentLocationForm').show();
		});
		
		$('#createClaim').on('click','#policeReportNoreportButton',function(){
			$('#policeReportForm').hide();
			$('#accidentLocationForm').show();
		});
		
		$('#createClaim').on('click','#accidentLocationSubmitButton',function(){
			app.claimData.accidentaddress=$('#accidentaddress').val();
			app.claimData.accidentcity=$('#accidentcity').val();
			app.claimData.accidentstate=$('#accidentstate').val();
			app.claimData.accidentzip=$('#accidentzip').val();
			
			$('#accidentLocationForm').hide();
			$('#accidentImagesForm').show();
		});
		
		$('#createClaim').on('click','#accidentImagesSubmitButton',function(){
			$('#accidentImagesForm').hide();
			$('#confirmForm').show();
		});
		
		$('#createClaim').on('click','#confirmSubmitButton',function(){
			invokeCFClientFunction('saveClaimData', app.claimData, function(data) {
				$('#confirmForm').hide();
				$('#createSuccessForm').show();
				
				if(dataSynch.isOnline){
					dataSynch.pushUpdates();
					$('#successNotification').show();
				}else{
					$('#failureNotification').show();
				}
			});	
		});
		
		$('#createClaim').on('click','#currentPositionButton',function(){
			invokeCFClientFunction('getCurrentPosition', function(data) {
				app.claimData.accidentlatitude=data.coords.latitude;
				app.claimData.accidentlongitude=data.coords.longitude;
				
				$('.latitude span').html(app.claimData.accidentlatitude);
				$('.longitude span').html(app.claimData.accidentlongitude);
				
				$('#locationButton').hide();
				$('#locationDisplay').show();
				
			});	
		});
		
		$('#createClaim').on('click','#cameraButton',function(e){
			e.preventDefault();
			invokeCFClientFunction('takePicture',null,function(data){
				$(app.claimData.images).each(function(pos,value){
					$('#selectedImages').append(value.imageTag);
				})
			});	
		});	
		
		$('#createClaim').on('click','#folderButton',function(e){
			e.preventDefault();
			
			invokeCFClientFunction('getFileList','gallery',function(data){
				console.log(data);
				/*$(data).each(function(image){
					
				});*/
			});
			
			
		});	
	},	
	docReady: function () {
		invokeCFClientFunction('checkLogin', function(loginCheck) {
			if(loginCheck.success){
				app.setUserID(loginCheck.userID);
				app.viewHome();
			}else{
				app.viewLogin();
			}
		});	
		
		//$( '.swipebox' ).swipebox();
	},	
	viewLogin: function(){
		switchPage('login',false);
	},
	viewHome: function(){
		switchPage('dash',false);
	},
	viewPolicy: function(){
		invokeCFClientFunction('getPolicy', function(data) {
			var content = Mustache.to_html($('#policyTmpl').html(), JSON.parse(data));
			switchPage('policy',true,content);
		});	
	},
	viewClaims: function(){
		invokeCFClientFunction('getClaims', function(data) {
			var content = Mustache.to_html($('#claimsTmpl').html(), {claims:JSON.parse(data)});
			switchPage('claims',true,content);
		});	
	},
	viewClaim: function(id){
		invokeCFClientFunction('getClaim',id, function(data) {
			for(comment in data.comments){
				if(data.comments[comment].isrep == 'true'){
					data.comments[comment].isrep = true;
				}else{
					data.comments[comment].isrep=false;
				}
			}
			var content = Mustache.to_html($('#claimTmpl').html(), data);
			switchPage('claim',true,content);
		});	
	},
	viewAccount: function(){
		switchPage('account',true);
	},
	viewPolicyDocuments: function(){
		invokeCFClientFunction('getPolicyDocuments', function(data) {
			var content = Mustache.to_html($('#policyDocumentsTmpl').html(), {policyDocuments:JSON.parse(data)});
			switchPage('policyDocuments',true,content);
		});	
	},
	viewInsuranceCard: function(){
		invokeCFClientFunction('getPolicy', function(data) {
			var data = JSON.parse(data);
			var content = Mustache.to_html($('#insuranceCardTmpl').html(), data);
			switchPage('insuranceCard',true,content);
		});
	},
	viewCreateClaim: function(){
		var content = Mustache.to_html($('#addClaimTmpl').html(), app.claimData);
		switchPage('createClaim',true,content);
	},
	viewPayments: function(){
		invokeCFClientFunction('getPayments', function(data) {
			var content = Mustache.to_html($('#paymentsTmpl').html(), {payments:JSON.parse(data)});
			switchPage('payments',true,content);
		});	
	},
	setLoginCredentials: function(credentials){
		invokeCFClientFunction('setLoginCredentials',credentials,null);	
	},
	getUserID: function(){
		return app.userID;
	},
	setUserID: function(userID){
		app.userID =userID;
	}
	
}	

/******
Utility Functions
*****/

var queryToObject = function(q) {
    var col, i, r, _i, _len, _ref, _ref2, _results;
    _results = [];
    for (i = 0, _ref = q.ROWCOUNT; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
      r = {};
      _ref2 = q.COLUMNS;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        col = _ref2[_i];
        r[col.toLowerCase()] = q.DATA[col][i];
      }
      _results.push(r);
    }

    return _results;
  };
  
var rowToObject = function(q) {
    var col, i, r, _i, _len, _ref, _ref2, _results;
      r = {};
      _ref2 = q.COLUMNS;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        col = _ref2[_i];
        r[col.toLowerCase()] = q.DATA[col][0];
      }
    return r;
  };  
  
function switchPage(page,showHeader,content){
	
	hideNavigation();
	$('.page').hide();
	if(content !='undefined'){
		$('#' + page).html(content);
	}
	
	if(page == 'dash'){
		$('body').css('background-color','#414141');	
	}else{
		$('body').css('background-color','#FFFFFF');
	}
	$('#' + page).show();
	
	if(showHeader){
		if(!$('.header').is(':visible')){
			$('.header').show();
		}
	}else{
		if($('.header').is(':visible')){
			$('.header').hide();
		}
	}
}




function showNavigation(){
	if($('.show-navigation').is(':visible')){
		$('body,html').animate({
			scrollTop:0
		}, 800, 'easeOutExpo');
		
		$('.show-navigation').hide();
		
		$('.hide-navigation').show();
		
		$('.navigation').animate({
			top: '60',
		}, 300, 'easeInOutQuad', function(){});
	}
}

function hideNavigation(){
	if($('.hide-navigation').is(':visible')){
		$('.hide-navigation').hide();
		$('.show-navigation').show();
		$('.navigation').animate({
			top: '-300%',
		}, 300, 'easeInOutQuad', function(){});
	}
}
/*
$(document).ready(function(){
	$(".swipebox").swipebox({
		useCSS : true, // false will force the use of jQuery for animations
		hideBarsDelay : 3000 // 0 to always show caption and action bar
	});
	
	$(".swipebox-wide").swipebox({
		useCSS : true, // false will force the use of jQuery for animations
		hideBarsDelay : 3000 // 0 to always show caption and action bar
	});
});
*/
