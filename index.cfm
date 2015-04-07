<cfinclude template="/CFIDE/cfclient/useragent.cfm">
<cfclientsettings detectdevice="true" enabledeviceapi="true"/>

<!DOCTYPE html>
<html lang="en-US">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="apple-mobile-web-app-status-bar-style" content="black">

		<title>Crash Test Insurance</title>
    	<link href="assets/css/app.css" rel="stylesheet" media="screen">
    	<link href="assets/css/framework.css" rel="stylesheet" media="screen">
    	<link href="assets/css/swipebox.css" rel="stylesheet" media="screen">
	
</head>
<body>
	
	<!---<cfclient>--->
		<cfinclude template="dataSynchFunctions.cfm" >
		<cfinclude template="DAOFunctions.cfm" >
		<cfinclude template="UtilityFunctions.cfm" >
		<cfinclude template="templates.cfm" >
	<!---</cfclient>--->
	
	<cfclient>
		<cfscript>
			//var connectionType = cfclient.connection.getType();
			var connectionType = 'WIFI';
			app.init();
			
			invokeCFClientFunction('getApplicationSettings', function(appSettings){
				dataSynch.init(appSettings.updateURL,appSettings.saveURL,appSettings.dataUpdateFrequency,connectionType);
			});
			
			/* callback handlers */
				
			/*Update connection info in dataSynch object so data is not pulled/pushed when offline */
			cfclient.connection.onOnline(dataSynch.online);
			cfclient.connection.onOffline(dataSynch.offline);
			
			/*Stop the datasynch timer when battery level is low as polling can drain batter power*/
			cfclient.events.onBatteryCritical(dataSynch.stopTimer);
			
			/*Start datasynch timer when battery level is above 10%*/
			
			cfclient.events.onBatteryStatusChange(function(data){
				if(!dataSynch.isRunning && parseInt(data.level) > 10){
					dataSynch.startTimer();
				}
			});
		</cfscript>	
	</cfclient>	
		<div class="header" style="display:none">
			<a href="#" class="show-navigation"></a>
		    <a href="#" class="hide-navigation"></a>
		    <img src="assets/images/logo_v2.png" class="page-logo" alt="img">
		</div>
		
		<div class="navigation">
			<div class="navigation-wrapper">
		        <div class="nav-item">
		            <a href="#/homepage" class="landing-icon">Homepage</a>
		        </div>
		        <div class="nav-item">
					<a class="submenu-item policy-thumb-icon" href="#">
						Policy
						<em class="dropdown-item"></em>
					</a>
					<div class="submenu">
						<a href="#/policy">
							Policy Information
							<em class="unselected-item"></em>
						</a>
						<a href="#/policyDocuments">
							Policy Documents
							<em class="unselected-item"></em>
						</a>
						<a href="#/insuranceCard">
							Insurance Card
							<em class="unselected-item"></em>
						</a>
					</div>
				</div>
		        <div class="nav-item">
	            	<a class="submenu-item gallery-icon" href="#">
	            		Claims
	            		<em class="dropdown-item"></em>
	            	</a>
		            
		            <div class="submenu">
						<a href="#/claims">
							List Claims
							<em class="unselected-item"></em>
						</a>
						<a href="#/createClaim">
							Create Claim
							<em class="unselected-item"></em>
						</a>
					</div>
		        </div>
		        <div class="nav-item">
		            <a href="#/payments" class="payments-thumb-icon">Payments</a>
		        </div>
		        <div class="nav-item">
		            <a href="#/account" class="features-icon">Account</a>
		        </div>
		    	
		    </div>
		</div>
		
		<div class="page-header-clear"></div>
		
		
		
		<div id="dash" class="page" style="background-color:#414141;display:none">
			<div class="homepage-wrapper">
				<img class="homepage-logo" src="assets/images/logo_v2.png"  alt="img">
			    <em class="homepage-logo-sub">Insurance</em>
			     
			    <div class="homepage-navigation">
			    	<a class="home-icon"    href="#/homepage">Homepage</a>
			        <a class="policy-icon"    href="#/policy">Policy</a>
			        <a class="gallery-icon"  href="#/claims">Claims</a>
			        <a class="type-icon"  href="#/createClaim">Create Claim</a>
			        <a class="payments-icon"	href="#/payments" >Payments</a>
			        <a class="jquery-icon"   href="#/account">Account</a>
			        
			        <div class="clear"></div>
			    </div>
			</div>
			
			<div class="homepage-background" style="background-color:#414141">
				<div class="bg-pattern"></div>
			    <div class="bg-overlay"></div>
				<img id="bg" src="assets/images/bg_2.png" alt="img">
			</div>
		</div>
		
		<div id="login" class="page" style="display:none" >
			<div class="homepage-wrapper">
				<img class="homepage-logo" src="assets/images/logo_v2.png"  alt="img">
			    <em class="homepage-logo-sub">Insurance</em>
			     
			    <div class="loginPage">
			    	<p>To use this application, you need to have an account.</p>
					<p>Login with your account credentials below. If you do not have an account please create one on the web site.</p>
					
					<p id="loginStatus" style="display:none"></p>
					<div class="container no-bottom">
						<div class="formFieldWrap">
							<label 	class="field-title policereportnumber" for="username">
								Username:
							</label>	
							<input type="text" value="" class="contactField " id="username">
						</div>
						
						<div class="formFieldWrap">
							<label 	class="field-title policedepartmentarea" for="policedepartmentarea">
								Password:
							</label>	
							<input type="password" value="" class="contactField " id="password">
						</div>
						
						
						<div class="formSubmitButtonErrorsWrap">
							<a href="#" class="buttonWrap button button-green loginButton" id="loginButton">Login</a>
						</div>
					</div>
			        <div class="clear"></div>
			    </div>
			</div>
			
			<div class="homepage-background" style="background-color:#414141">
				<div class="bg-pattern"></div>
			    <div class="bg-overlay"></div>
				<img id="bg" src="assets/images/bg_2.png" alt="img">
			</div>
			
		</div>
		
		<div id="claims" class="page" style="display:none">
			
		</div>
		
		<div id="claim" class="page" style="display:none">
			
		</div>
		
		<div id="gallery" class="page" style="display:none">
			<div class="content-section">
			    <h1 class="left-text">Gallery</h1>
			    <em class="left-text">A list of images taken with this app</em>
			    <div class="overlay"></div>
			    <img class="responsive-image" src="assets/images/gallery.jpg" alt="img">
			</div>
			<div class="content">
				<div class="container no-bottom">
					<ul class="gallery round-thumb">
					</ul>	
				</div>	
			</div>
		</div>
		
			
		
		<div id="policy" class="page" style="display:none">
			
				
		</div>	
		
		<div id="policyDocuments" class="page" style="display:none">
			
		</div>	
		
		<div id="insuranceCard" class="page" style="display:none">
			
		</div>	
		
		<div id="createClaim" class="page" style="display:none">
			
		</div>	

				
		<div id="payments" class="page" style="display:none">
			
		</div>	
		
		<div id="account" class="page" style="display:none">
			
			<div class="content-section">
			    <h1 class="left-text">Account</h1>
			    <em class="left-text">Control elements of your account from here (To be completed in phase 2)</em>
			    <div class="overlay"></div>
			    <img class="responsive-image" src="assets/images/form2.jpg" alt="img">
			</div>
			<div class="content">
				<div class="container no-bottom">
					<div class="formSubmitButtonErrorsWrap">
						<a href="#" class="buttonWrap button button-red logoutButton">Logout</a>
					</div>		
				</div>	
			</div>
		</div>
		
	</body>
	
	<!-- libraries -->
	<script src="assets/js/jquery.js"></script>
	<script src="assets/js/jqueryui.js"></script>
	<script src="assets/js/jquery.swipebox.js"></script>
	<script src="assets/js/mustache.js"></script>
	<script src="assets/js/director.js"></script>
	
	<!-- app files -->
	<script src="assets/js/app.js"></script>
	<script src="assets/js/dataSynch.js"></script>
	<script src="assets/js/routes.js"></script>
	
	<script>
	var router = Router(routes);
		router.init();
	</script>
    
</html>
