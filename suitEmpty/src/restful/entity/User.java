package restful.entity;

import javax.persistence.*;

@Entity
@Table(name = "user")
@NamedQueries({
		@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
		@NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
		@NamedQuery(name = "User.deleteByUsername", query = "DELETE FROM User u WHERE u.username = :username")
})
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;

	@Column(name = "username")
	private String username;

	@Column(name = "real_name")
	private String realName;

	@Column(name = "password")
	private String password;

	@Column(name = "sex")
	private boolean sex; // 男生为1 女生为0

	@Column(name = "model")
	private String model;

	@Column(name = "model_head")
	private String modelHead;

	@Column(name = "is_admin")
	private boolean isAdmin; // 是为1 否为0
	
	public User() {}
	
	public User(String username, String realName, String password, boolean sex, String model, String modelHead,
                boolean isAdmin) {
		super();
		this.username = username;
		this.realName = realName;
		this.password = password;
		this.sex = sex;
		this.model = model;
		this.modelHead = modelHead;
		this.isAdmin = isAdmin;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getSex() {
		return sex;
	}

	public void setSex(boolean sex) {
		this.sex = sex;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModelHead() {
		return modelHead;
	}

	public void setModelHead(String modelHead) {
		this.modelHead = modelHead;
	}

	public boolean getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", username='" + username + '\'' +
				", realName='" + realName + '\'' +
				", password='" + password + '\'' +
				", sex=" + sex +
				", model='" + model + '\'' +
				", modelHead='" + modelHead + '\'' +
				", isAdmin=" + isAdmin +
				'}';
	}
}
