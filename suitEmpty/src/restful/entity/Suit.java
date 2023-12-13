package restful.entity;

import javax.persistence.*;

@Entity
@Table(name = "suit")
@NamedQueries({
		@NamedQuery(name = "Suit.findAll", query = "SELECT suit FROM Suit suit"),
		@NamedQuery(name = "Suit.findAllByCode", query = "SELECT suit FROM Suit suit where suit.code like :code"),
		@NamedQuery(name = "Suit.findAllBySexAndType", query = "SELECT suit FROM Suit suit where suit.sex = :sex and suit.type = :type"),
		@NamedQuery(name = "Suit.findAllBySex", query = "SELECT suit FROM Suit suit where suit.sex = :sex"),
		@NamedQuery(name = "Suit.findAllByType", query = "SELECT suit FROM Suit suit where suit.type = :type")

})
public class Suit {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;

	@Column(name = "code")
	private String code;

	@Column(name = "name")
	private String name;

	@Column(name = "price")
	private double price;

	@Column(name = "sex")
	private boolean sex;

	@Column(name = "type")
	private String type;

	@Column(name = "image")
	private String image;

	public Suit() {}

	public Suit(Long id, String code, String name, double price, boolean sex, String type, String image) {
		this.id = id;
		this.code = code;
		this.name = name;
		this.price = price;
		this.sex = sex;
		this.type = type;
		this.image = image;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public boolean isSex() {
		return sex;
	}

	public void setSex(boolean sex) {
		this.sex = sex;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Suit{" +
				"id=" + id +
				", code='" + code + '\'' +
				", name='" + name + '\'' +
				", price=" + price +
				", sex=" + sex +
				", type='" + type + '\'' +
				", image='" + image + '\'' +
				'}';
	}


}
