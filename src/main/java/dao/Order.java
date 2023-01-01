package dao;

public class Order {
	private String name, seller,orderedby;
	private float price, rating;
	private int pid,quantity,oid;
	private int confirmed;
	
	public String getName() { return name;}
	public String getSeller() {return seller;}
	public float getPrice() {return price;}
	public float getRating() {return rating;}
	//public int getTimesOrdered() {return timesOrdered;}
	public int getPid() {return pid;}
	public int getQuantity() {return quantity;}
	public int getConfirmed() {return confirmed;}
	public int getOid() {return oid;}
	public String getOrderedBy() { return orderedby;}
	
	public void setName(String n) {name =n;}
	public void setSeller(String s) {seller=s;}
	public void setPrice(float p) {price=p;}
	public void setRating(float r) {rating =r;}
	//public void setTimesOrdered(int to) {timesOrdered =to;}
	public void setPid(int p) {pid=p;}
	public void setQuantity(int quan) {quantity=quan;}
	public void setConfirmed(int c) {confirmed=c;}
	public void setOid(int o) {oid=o;}
	public void setOrderedBy(String ob) {orderedby =ob;}
}
