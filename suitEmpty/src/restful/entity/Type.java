package restful.entity;

import javax.persistence.*;


@Entity
@Table(name = "t_type")
@NamedQueries({
		@NamedQuery(name = "Type.findAll", query = "SELECT type FROM Type type"),
		@NamedQuery(name = "Type.findAllByCode", query = "SELECT type FROM Type type where type.code like :code"),
		@NamedQuery(name = "Type.deleteByCode", query = "DELETE FROM Type t WHERE t.code = :code")
})
public class Type {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;


	@Column(name = "code", nullable = false, length = 50)
	private String code;

	@Column(name = "name", nullable = false, length = 50)
	private String name;

	// Constructors, getters, setters, and toString() method

	public Type(Long id, String code, String name) {
		this.id = id;
		this.code = code;
		this.name = name;
	}

	public Type() {
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

	@Override
	public String toString() {
		return "Type{" +
				"id=" + id +
				", code='" + code + '\'' +
				", name='" + name + '\'' +
				'}';
	}
}
