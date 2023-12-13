package restful.utils;

import java.util.List;

import net.sf.json.JSONArray;
import restful.database.EM;
//import restful.entity.Suit;
import restful.entity.Suit;
import restful.entity.Type;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class ImportUtil {

	public static void addAllDataType(JSONArray jsonArray) {
		EntityManagerFactory entityManagerFactory =
				Persistence.createEntityManagerFactory("default");

		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			em.getTransaction().begin();

			List<Type> types = JSONArray.toList(jsonArray, Type.class);
			for (Type type : types) {
				System.out.println(type.getCode());
				if (em.createNamedQuery("Type.findAllByCode", Type.class)
						.setParameter("code", type.getCode()).getResultList().isEmpty()) {
					em.merge(type);  // merge is used for both new and existing entities
				}
			}

			em.getTransaction().commit();
		} catch (Exception e) {
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();  // Or handle the exception as appropriate
		} finally {
			em.close();
		}
	}


	public static void addAllDataSuit(JSONArray jsonArray) {
		EntityManagerFactory entityManagerFactory =
				Persistence.createEntityManagerFactory("default");

		EntityManager em = entityManagerFactory.createEntityManager();
		try {
			// 开始一个新的事务
			em.getTransaction().begin();

			// 将JSONArray转换为Suit对象列表
			List<Suit> suits = JSONArray.toList(jsonArray, Suit.class);

			for (Suit suit : suits) {
				// 检查数据库中是否已经存在具有相同code的Suit
				if (em.createNamedQuery("Suit.findAllByCode", Suit.class)
						.setParameter("code", suit.getCode()).getResultList().isEmpty()) {
					// 如果不存在，则保存新的Suit对象
					suit = em.merge(suit);
					em.persist(suit);
				}
			}

			// 提交事务
			em.getTransaction().commit();
		} catch (Exception e) {
			// 出现异常时回滚事务
			if (em.getTransaction().isActive()) {
				em.getTransaction().rollback();
			}
			e.printStackTrace();  // 或根据需要进行适当的异常处理
		} finally {
			// 最后确保关闭EntityManager
			em.close();
		}
	}


}
