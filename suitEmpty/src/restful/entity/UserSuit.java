package restful.entity;

import javax.persistence.*;

@Entity
@Table(name = "usersuit")
@NamedQueries({
    @NamedQuery(name = "UserSuit.findAll", query = "SELECT mySuit FROM UserSuit mySuit"),
    @NamedQuery(name = "UserSuit.findAllByUsername", query = "SELECT mySuit FROM UserSuit mysuit where mySuit.username like :username"),
    @NamedQuery(name = "UserSuit.findAllByUsernameAndCode", query = "SELECT mySuit FROM UserSuit mySuit  where mySuit.username = :username and mySuit.codeSuit = :codeSuit"),
//		@NamedQuery(name = "UserSuit.getList", query = "SELECT NEW restful.entity.UserSuitInfo(t1.codeSuit, t1.username, t2.price, t1.zIndex, t2.image, t2.name)\n" +
//				"FROM UserSuit t1, Suit t2\n" +
//				"WHERE t1.codeSuit = t2.code\n"),
	@NamedQuery(name = "UserSuit.deleteByUsernameAndCode", query = "DELETE FROM UserSuit t WHERE t.username = :username and t.codeSuit = :codeSuit"),
	@NamedQuery(name = "UserSuit.UpdatSuitByUsernameAndCode", query = "update UserSuit set zIndex = :zIndex where username = :username and codeSuit = :codeSuit")



			})
public class UserSuit {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private Long id;
	@Column(name = "username")
	private String username;
	@Column(name = "codeSuit")
	private String codeSuit;
	@Column(name = "zIndex")
	private int zIndex;

	public UserSuit() {}

	public UserSuit(String username, String codeSuit, int zIndex) {
		this.username = username;
		this.codeSuit = codeSuit;
		this.zIndex = zIndex;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getCodeSuit() {
		return codeSuit;
	}

	public void setCodeSuit(String codeSuit) {
		this.codeSuit = codeSuit;
	}

	public int getzIndex() {
		return zIndex;
	}

	public void setzIndex(int zIndex) {
		this.zIndex = zIndex;
	}

	@Override
	public String toString() {
		return "UserSuit [username=" + username + ", codeSuit=" + codeSuit + ", zIndex=" + zIndex + "]";
	}

}
