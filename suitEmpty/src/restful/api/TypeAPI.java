package restful.api;

import java.util.List;

import javax.persistence.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import net.sf.json.JSONArray;
import restful.annotation.Permission;
import restful.bean.Result;
import restful.entity.Type;
import restful.entity.User;
import restful.utils.ImportUtil;
import restful.utils.JSONStringToJSONArray;

@Path("/suit")
public class TypeAPI {

	@Context 
	protected HttpServletRequest request;
	@Context
	protected HttpServletResponse response;
	EntityManagerFactory entityManagerFactory =
			Persistence.createEntityManagerFactory("default");

	EntityManager entityManager = entityManagerFactory.createEntityManager();
	
	@POST
	@Path("/typeList")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result typeList() {
//		List<Type> result = (List<Type>) EM.getEntityManager()
//				.createNamedQuery("Type.findAll", Type.class)
//				.getResultList();
//		return new Result(10, "", result, "");
		System.out.println("进入方法");
		EntityTransaction entityTransaction = entityManager.getTransaction();
		try {
			//事务开始
			entityTransaction.begin();
			// 使用命名查询通过用户名检索所有用户
			Query query = entityManager.createNamedQuery("Type.findAll");
			List<Type> typeList = query.getResultList();
			//提交事务
			entityTransaction.commit();

			return new Result(10, "获取全部信息成功", typeList, "");

		} catch (Exception e) {
			if (entityTransaction.isActive()) {
				entityTransaction.rollback();
			}
			e.printStackTrace();
			// 返回失败的Result
			return new Result(-10, "获取全部信息成功失败", null,"");
		} finally {
			entityManager.close();
		}
	}
	
	@POST
	@Path("/addType")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
//	@Permission("admin")
	public Result addType(Type type) {
		System.out.println("用户注册：" + type);

		EntityTransaction entityTransaction = entityManager.getTransaction();

		try {
			// 事务开始
			entityTransaction.begin();

			// 检查用户名是否已存在
			TypedQuery<Type> query = entityManager.createNamedQuery("Type.findAllByCode", Type.class);
			query.setParameter("code", type.getCode());
			List<Type> existingTypes = query.getResultList();

			if (!existingTypes.isEmpty()) {
				return new Result(-10, "服饰类型已存在，请输入其他服饰类型", null, "");
			}

			// 保存新用户
			entityManager.persist(type);

			entityTransaction.commit();

			return new Result(10, "添加成功", type, "");
		} catch (Exception e) {
			if (entityTransaction.isActive()) {
				entityTransaction.rollback();
			}
			throw new RuntimeException(e);
		} finally {
			// 在 finally 块中关闭 EntityManager
			if (entityManager.isOpen()) {
				entityManager.close();
			}
		}
	}
	
	@POST
	@Path("/deleteType")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result deleteType(Type type) {
		System.out.println("type---->" + type);
		String code = type.getCode();

		try {
			// 1. 开始事务
			entityManager.getTransaction().begin();

			// 2. 使用NamedQuery删除用户
			Query query = entityManager.createNamedQuery("Type.deleteByCode");
			query.setParameter("code", code);
			int deletedCount = query.executeUpdate();

			// 3. 提交事务
			entityManager.getTransaction().commit();

			if (deletedCount > 0) {
				return new Result(10, "服饰类型删除成功", code, "");
			} else {
				return new Result(-10, "服饰类型不存在或删除失败", null, "");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 处理异常，回滚事务
			entityManager.getTransaction().rollback();
			return new Result(-10, "删除失败", null, e.getMessage());
		} finally {
			// 关闭EntityManager
			entityManager.close();
		}
	}
	
	@POST
	@Path("/updateType")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result updateType(Type type) {
		System.out.println("type---->" + type);
		try {
			// 1. 开始事务
			entityManager.getTransaction().begin();

			// 使用命名查询通过用户名检索用户
			TypedQuery<Type> query = entityManager.createNamedQuery("Type.findAllByCode", Type.class);
			query.setParameter("code",type.getCode());

			// 根据需要处理找到的用户
			Type existingtype = query.getSingleResult();
//			更新用户
			if (existingtype != null) {
				existingtype.setCode(type.getCode());
				existingtype.setName(type.getName());
				// 将更新后的用户对象合并到持久化上下文
				entityManager.merge(existingtype);
			}
			// 3. 提交事务
			entityManager.getTransaction().commit();


			return new Result(10, "成功修改", existingtype, "");
		} catch (Exception e) {
			e.printStackTrace();
			// 处理异常，回滚事务
			entityManager.getTransaction().rollback();
			return new Result(-10, "修改失败", null, e.getMessage());
		} finally {
			// 关闭EntityManager
			entityManager.close();
		}
	}
	
	@POST
	@Path("/importType")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result importType(JSONArray jsonType) {
		// System.out.println(jsonType);
		ImportUtil.addAllDataType(JSONStringToJSONArray.getJSONArray(jsonType.toString().replaceAll("编号", "code").replaceAll("名称", "name")));
		return new Result(20, "成功导入", null, "");
	}


}
