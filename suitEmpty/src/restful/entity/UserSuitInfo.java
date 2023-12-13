package restful.entity;

import javax.persistence.*;


public class UserSuitInfo {

    private String codeSuit; // 将code属性指定为主键

    private String username;

    private Integer zIndex;
    private Double price;

    private String image;

    private String name;

    public UserSuitInfo() {
        // 默认构造函数
    }

    public UserSuitInfo(String codeSuit, String username, Integer zIndex, Double price, String image, String name) {
        this.codeSuit = codeSuit;
        this.username = username;
        this.zIndex = zIndex;
        this.price = price;
        this.image = image;
        this.name = name;
    }
    // Getter 和 setter 方法


    public String getCodeSuit() {
        return codeSuit;
    }

    public void setCodeSuit(String codeSuit) {
        this.codeSuit = codeSuit;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getzIndex() {
        return zIndex;
    }

    public void setzIndex(Integer zIndex) {
        this.zIndex = zIndex;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "UserSuitInfo{" +
                "code='" + codeSuit + '\'' +
                ", username='" + username + '\'' +
                ", price=" + price +
                ", zIndex=" + zIndex +
                ", image='" + image + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
