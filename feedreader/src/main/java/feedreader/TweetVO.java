package feedreader;

import java.util.Date;
/**
 * 
 * @author Saranya
 * This class describes the Tweet Object we display in our app.
 */

public class TweetVO {

	private String userName;
	private String screenName;
	private String profilePic;
	private String tweetContent;
	private String[] tweetImages;
	private int timesRetweeted;
	private Date tweetDate;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getScreenName() {
		return screenName;
	}
	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}
	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	public String getTweetContent() {
		return tweetContent;
	}
	public void setTweetContent(String tweetContent) {
		this.tweetContent = tweetContent;
	}
	public int getTimesRetweeted() {
		return timesRetweeted;
	}
	public void setTimesRetweeted(int timesRetweeted) {
		this.timesRetweeted = timesRetweeted;
	}
	public Date getTweetDate() {
		return tweetDate;
	}
	public void setTweetDate(Date tweetDate) {
		this.tweetDate = tweetDate;
	}
	public String[] getTweetImages() {
		return tweetImages;
	}
	public void setTweetImages(String[] tweetImages) {
		this.tweetImages = tweetImages;
	}
	
}
