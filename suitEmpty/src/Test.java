import org.junit.Before;
import restful.entity.User;
import restful.entity.UserSuitInfo;

import javax.persistence.*;
import java.util.List;

/**
 * @author 万佳羊
 * {@code @date}  2023-12-04  17:31
 * @version 1.0
 */
public class Test {
    EntityManagerFactory entityManagerFactory;

    @Before
    public void before() {
        entityManagerFactory = Persistence.createEntityManagerFactory("default");
    }

    @org.junit.Test
    public void testA() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();

        List<User> users = entityManager.createNamedQuery("User.findAll", User.class).getResultList();

        for (User user : users) {
            System.out.println("User" + user);
        }

        entityTransaction.commit();
        entityManager.close();
    }


    @org.junit.Test
    public void testB() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();

        try {
            // 查询 ID 为 1 的用户
            User user = entityManager.find(User.class, 1L);

            // 输出用户信息到控制台
            System.out.println("User found: " + user);

            // 如果你还需要执行其他查询，可以在这里添加

            entityTransaction.commit();
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            System.err.println("Test failed with exception: " + e.getMessage());
        } finally {
            entityManager.close();
        }
    }

    @org.junit.Test
    public void testInsertUser() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();

        try {
            // 创建一个新用户
            User newUser = new User();
            newUser.setUsername("黄昊66");
            newUser.setPassword("123456");
            newUser.setRealName("黄昊66666");
            newUser.setSex(true);
            newUser.setModelHead("??");
            newUser.setModel("232");
            newUser.setIsAdmin(false);

            // 将新用户持久化到数据库
            entityManager.persist(newUser);

            // 提交事务
            entityTransaction.commit();

            // 输出插入的用户信息到控制台
            System.out.println("User inserted: " + newUser);
        } catch (Exception e) {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            System.err.println("Insertion failed with exception: " + e.getMessage());
        } finally {
            entityManager.close();
        }
    }

    @org.junit.Test
    public void testFindUserByUsername() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        try {
            // 使用 JPQL 查询用户
            String jpql = "SELECT u FROM User u WHERE u.username = :username";
            Query query = entityManager.createQuery(jpql, User.class);
            query.setParameter("username", "黄昊");

            // 执行查询
            List<User> users = query.getResultList();

            // 输出查询结果到控制台
            if (!users.isEmpty()) {
                System.out.println("User found: " + users.get(0));
            } else {
                System.out.println("User not found with username: your_username");
            }

        } catch (Exception e) {
            System.err.println("Query failed with exception: " + e.getMessage());
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }

    @org.junit.Test
    public void testFindAllUsers() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        try {
            // 使用 JPQL 查询所有用户
            String jpql = "SELECT u FROM User u";
            Query query = entityManager.createQuery(jpql, User.class);

            // 执行查询
            List<User> users = query.getResultList();

            // 输出查询结果到控制台
            if (!users.isEmpty()) {
                System.out.println("All Users:");
                for (User user : users) {
                    System.out.println(user);
                }
            } else {
                System.out.println("No users found.");
            }

        } catch (Exception e) {
            System.err.println("Query failed with exception: " + e.getMessage());
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }
    @org.junit.Test
    public void testMysuit() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        entityManager.getTransaction().begin();

        try {
            // 使用 JPQL 查询所有用户
            String jpql = "SELECT NEW restful.entity.UserSuitInfo(t1.codeSuit, t1.username, t1.zIndex, t2.price, t2.image, t2.name) " +
                    "FROM UserSuit t1, Suit t2 " +
                    "WHERE t1.codeSuit = t2.code";



            Query query = entityManager.createQuery(jpql);
            List<UserSuitInfo> mySuitDTOList = query.getResultList();

            for (UserSuitInfo mySuitDTO : mySuitDTOList) {
                // 在这里你可以处理每个查询结果，比如打印或进行其他操作
                System.out.println(mySuitDTO);
            }
        } catch (Exception e) {
            System.err.println("Query failed with exception: " + e.getMessage());
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }


}


