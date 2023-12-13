package restful.api;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import org.junit.Test;
import restful.annotation.Permission;
import restful.bean.Result;
import restful.bean.SuitBean;
import restful.entity.Type;
import restful.entity.UserSuitInfo;
import restful.entity.User;
import restful.entity.UserSuit;

@Path("/suit")
public class MySuitAPI {

	@Context
	protected HttpServletRequest request;
	@Context
	protected HttpServletResponse response;
	EntityManagerFactory entityManagerFactory =
			Persistence.createEntityManagerFactory("default");

	EntityManager entityManager = entityManagerFactory.createEntityManager();


	@POST
	@Path("/mySuitList")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result mySuitList() {
		User user = (User) request.getSession().getAttribute("user");
		System.out.println("nmsl");
		entityManager.getTransaction().begin();
		List<UserSuitInfo> mySuitDTOList=null;
		try {
			// 使用 JPQL 查询所有用户
			String jpql = "SELECT NEW restful.entity.UserSuitInfo( t1.codeSuit, t1.username, t1.zIndex, t2.price, t2.image, t2.name) " +
					"FROM UserSuit t1, Suit t2 " +
					"WHERE t1.codeSuit = t2.code "+
					"and"+ " t1.username=:username";
			Query query = entityManager.createQuery(jpql)
					.setParameter("username",user.getUsername());
			mySuitDTOList = query.getResultList();

			for (UserSuitInfo mySuitDTO : mySuitDTOList) {
				// 在这里你可以处理每个查询结果，比如打印或进行其他操作
				System.out.println(mySuitDTO);
			}
			entityManager.getTransaction().commit();
		} catch (Exception e) {
			System.err.println("Query failed with exception: " + e.getMessage());
		} finally {
			entityManager.close();
		}
		return new Result(10, "",mySuitDTOList , "");
	}


	@POST
	@Path("/addMySuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result addMySuit(UserSuit mySuit) {
		try {
			entityManager.getTransaction().begin();
			// System.out.println(mySuit);
			if (entityManager
					.createNamedQuery("UserSuit.findAllByUsernameAndCode", UserSuit.class)
					.setParameter("username", mySuit.getUsername())
					.setParameter("codeSuit", mySuit.getCodeSuit()).getResultList().size() != 0) {
				return new Result(-10, "不能重复添加", mySuit, "");
			}
			mySuit = entityManager.merge(mySuit);
			entityManager.persist(mySuit);
			entityManager.getTransaction().commit();
			return new Result(10, "添加成功", mySuit, "");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}finally {
			entityManager.close();
		}
	}

	@POST
	@Path("/deleteMySuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result deleteMySuit(UserSuitInfo mySuit) {
		User user = (User) request.getSession().getAttribute("user");

		entityManager.getTransaction().begin();
		try {
			int result = entityManager.createNamedQuery("UserSuit.deleteByUsernameAndCode")
					.setParameter("username", user.getUsername())
					.setParameter("codeSuit", mySuit.getCodeSuit())
					.executeUpdate();
			entityManager.getTransaction().commit();
			System.out.println(result);
			return new Result(10, "成功删除", null, "");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}finally {
			entityManager.close();
		}
	}

	@POST
	@Path("/updateMySuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result updateMySuit(UserSuitInfo mySuit) {
		User user = (User) request.getSession().getAttribute("user");
		try {
			entityManager.getTransaction().begin();
			int result = entityManager.createNamedQuery("UserSuit.UpdatSuitByUsernameAndCode")
					.setParameter("zIndex", mySuit.getzIndex())
					.setParameter("username", user.getUsername())
					.setParameter("codeSuit", mySuit.getCodeSuit())
					.executeUpdate();
			entityManager.getTransaction().commit();
			System.out.println(result);
			return new Result(10, "成功修改", null, "");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}finally {
			entityManager.close();
		}
	}

}
