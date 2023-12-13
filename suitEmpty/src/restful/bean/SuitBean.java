package restful.bean;

public class SuitBean {

	private String code;
	private String name;
	private double price;
	private int zIndex;
	private String image;
	
	public SuitBean() {}
	
	public SuitBean(String code, String name, double price, int zIndex, String image) {
		super();
		this.code = code;
		this.name = name;
		this.price = price;
		this.zIndex = zIndex;
		this.image = image;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public double getPrice() {
		return price;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
	
	public String getImage() {
		return image;
	}
	
	public void setImage(String image) {
		this.image = image;
	}
	
	@Override
	public String toString() {
		return "MySuits [code=" + code + ", name=" + name + ", price=" + price + ", zIndex=" + zIndex + ", image="
				+ image + "]";
	}

	public int getzIndex() {
		return zIndex;
	}

	public void setzIndex(int zIndex) {
		this.zIndex = zIndex;
	}
	
	
}
