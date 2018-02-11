<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List,feedreader.TweetVO, java.text.SimpleDateFormat;" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href="slds/assets/styles/salesforce-lightning-design-system.css">
<title>Salesforce Tweets</title>
</head>
<body>
	<div class='slds-page-header' role="banner">
		<div class="slds-media slds-media--center">
			<div class="slds-media__body">
				<p class="slds-pageheader__title slds-align-middle">
					<img src="slds/assets/Twitter_Circle.png" alt="Twitter logo" height="52" width="52"/>
					&nbsp;Welcome to the Salesforce Twitter Feed Reader App! 
					<img src="slds/assets/salesforce-logo.png" alt="Salesforce logo" height="80" width=90" />
				</p>
			</div>
		</div>
	</div>
	<%
	boolean emptyString = request.getAttribute("noSearchString")!= null && request.getAttribute("noSearchString").equals("true");
	boolean emptyResultSet =  request.getAttribute("noResults") != null && request.getAttribute("noResults").equals("true");
	%>
	<div class="slds-grid">
		<div class="slds-col">
		<div style= "padding-left: 20px">
		<br/><br/><br/>
		This application is built as part of the Twitter Challenge Coding assessment.
		<br/><br/><br/>
		Objective : <br/>
		&nbsp;&nbsp;1. Display the 10 latest tweets by user @salesforce <br/>
		&nbsp;&nbsp;2. User should also be able to search the tweets for a word of their choice<br/>
		&nbsp;&nbsp;3. Each minute the tweets will automatically update to show the most recent 10 tweets</pre>
		<br/><br/>
		The source code is available on Github.
		<br/><br/>
		<form action="TweetReaderServlet" method="post">
			<div class="slds-button" >
				<button class="slds-button_brand" type="submit"	name="action" value="fetch">Fetch latest tweets</button>
			</div>
			<br/><br/>
			<% if(emptyResultSet && !emptyString) { %>
			<div class="slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_warning" role="alert">
			  <span class="slds-assistive-text">warning</span>
			   <h2>Your search filtered no specific tweets</h2>
			  <button class="slds-button slds-notify__close slds-button_icon-inverse" title="Close">
			    <svg class="slds-button__icon" aria-hidden="true">
			      <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/assets/icons/utility-sprite/svg/symbols.svg#close" />
			    </svg>
			    <span class="slds-assistive-text">Close</span>
			  </button>
			</div>
			<%} if(emptyResultSet && emptyString) { %>
			<div class="slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error" role="alert">
			  <h2>Please enter in the text box the word you wish to search for</h2>
			  <button class="slds-button slds-notify__close slds-button_icon-inverse" title="Close">
			    <svg class="slds-button__icon" aria-hidden="true">
			      <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/assets/icons/utility-sprite/svg/symbols.svg#close" />
			    </svg>
			    <span class="slds-assistive-text">Close</span>
			  </button>
			</div>
			<%} %>
			<div class="slds-form-element ">
		    	<div class="slds-form-element__control">
		   			<textarea name ="input" id="textarea-id-01" class="slds-textarea" placeholder="Enter search string to filter latest tweets here"></textarea>
		 		</div>
			</div>
			<br/>
			<div class="slds-button" >
				<button class="slds-button_brand" type="submit"	name="action" value="search">Search tweets</button>
			</div>
		</form>
		</div>
		</div>	
		<div class="slds-col slds-size_2-of-3">
		<div style= "padding-left: 100px">
		<%
		response.setIntHeader("Refresh", 60);
		List<TweetVO> tweetList = (List<TweetVO>) request.getAttribute("tweetlist");
		if(tweetList != null) {
		 for(TweetVO tweet : tweetList) {  
		%>	
		<div class="slds-medium-size_1-of-2">
		
		<article class="slds-card">
	  	<div class="slds-card__header slds-grid">
	    <header class="slds-media slds-media_center slds-has-flexi-truncate">
	      <div class="slds-media__figure">
	         <span class="slds-avatar_medium">
	  			<img alt="Person name" src="<%=tweet.getProfilePic() %>" title="User profile image" />
			</span>
	      </div>
	      <div class="slds-media__body">
	        <h2>
	          <a href="javascript:void(0);" class="slds-card__header-link slds-truncate" title="[object Object]">
	            <span class="slds-text-heading_small">&nbsp;<%= tweet.getUserName() %> <br/> @ <%= tweet.getScreenName()%></span>
	          </a>
	        </h2>
	      </div>
	    </header>
	    <div class="slds-no-flex">
	     <%
	     	SimpleDateFormat formatter = new SimpleDateFormat("hh:mm a - dd MMM yyyy");
	     	String formattedDate = formatter.format(tweet.getTweetDate());
	     %>
	     <span class="slds-badge"> <%=formattedDate %> </span>
	    </div>
	  </div>
	  <div class="slds-card__body slds-card__body_inner"> <%=tweet.getTweetContent() %>
	  <%
	   if(tweet.getTweetImages() != null && tweet.getTweetImages().length > 0) {
	  	for(int j=0, count=0;j<tweet.getTweetImages().length && count <= 5;j++) {
	  		String temp[] = tweet.getTweetImages();
	  %>
	  	 <img src="<%=temp[j]%>" alt="Tweet img" height="500" width="500"/><br/>
	  <%}} %>
	  
	  </div>
	  <img src="slds/assets/retweet.png" alt="Twitter logo" height="52" width="52"/>
	   <%=tweet.getTimesRetweeted() %>
	   </article>
		</div>	
		<%}} %>
		<br/><br/><br/>
		</div>
		</div>
	</div>
</body>
</html>