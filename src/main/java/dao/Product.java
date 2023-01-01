package dao;

public class Product {
	private String name, seller;
	private float price, rating;
	private int timesOrdered,pid,quantity;
	
	public String getName() { return name;}
	public String getSeller() {return seller;}
	public float getPrice() {return price;}
	public float getRating() {return rating;}
	public int getTimesOrdered() {return timesOrdered;}
	public int getPid() {return pid;}
	public int getQuantity() {return quantity;}
	
	public void setName(String n) {name =n;}
	public void setSeller(String s) {seller=s;}
	public void setPrice(float p) {price=p;}
	public void setRating(float r) {rating =r;}
	public void setTimesOrdered(int to) {timesOrdered =to;}
	public void setPid(int p) {pid=p;}
	public void setQuantity(int quan) {quantity=quan;}
}
