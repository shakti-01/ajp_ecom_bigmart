package dao;

public class Review {
	private String title,content;
	private float rating;
	
	public String getTitle() { return title;}
	public String getContent() {return content;}
	public float getRating() { return rating;}
	
	public void setTitle(String t) {title=t;}
	public void setContent(String c) {content=c;}
	public void setRating(float r) { rating=r;}
}
