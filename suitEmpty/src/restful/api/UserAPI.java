package restful.api;

import restful.annotation.Permission;
import restful.bean.Result;
import restful.entity.User;

import javax.persistence.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import java.util.List;

@Path("/suit")
public class UserAPI {

	@Context 
	protected HttpServletRequest request;
	@Context
	protected HttpServletResponse response;

	EntityManagerFactory entityManagerFactory =
			Persistence.createEntityManagerFactory("default");

	EntityManager entityManager = entityManagerFactory.createEntityManager();

	@POST
	@Path("/login")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result login(User user) {
		System.out.println("用户登录："+user);

		EntityTransaction entityTransaction = entityManager.getTransaction();

		try {
			//事务开始
			entityTransaction.begin();
			//得到用户昵称
			String username = user.getUsername();
			//得到用户密码
			String password = user.getPassword();

			// 使用命名查询通过用户名检索用户
			TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsername", User.class);
			query.setParameter("username", username);

			// 根据需要处理找到的用户
			User foundUser = query.getSingleResult();
			System.out.println(foundUser);

			entityTransaction.commit();

			//验证用户
			if (foundUser == null) {
			return new Result(-10, "用户名不存在，请重新登录", foundUser, "");
			}
			if (!password.equals(foundUser.getPassword())) {
				return new Result(-10, "密码错误，请重新登录", foundUser, "");
			}
			//设置session
			request.getSession().setAttribute("user", foundUser);
			request.setAttribute("user", user);
			return new Result(10, "", foundUser, "");

		} catch (Exception e) {
			if (entityTransaction.isActive()) {
				entityTransaction.rollback();
			}
			e.printStackTrace();
			// 返回登录失败的Result
			return new Result(-10, "登录失败", null,"");
		} finally {
			entityManager.close();
		}
	}
	
	@POST
	@Path("/exit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public void exit() {
		request.getSession().removeAttribute("user");
	}

	@POST
	@Path("/register")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result register(User user) {
		System.out.println("用户注册：" + user);

		EntityTransaction entityTransaction = entityManager.getTransaction();

		try {
			// 事务开始
			entityTransaction.begin();

			// 检查用户名是否已存在
			TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsername", User.class);
			query.setParameter("username", user.getUsername());
			List<User> existingUsers = query.getResultList();

			if (!existingUsers.isEmpty()) {
				return new Result(-10, "用户名已存在，请选择其他用户名", null, "");
			}

			// 保存新用户
			entityManager.persist(user);

			entityTransaction.commit();

			return new Result(10, "添加成功", user, "");
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
	@Path("/all")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result all() {
		EntityTransaction entityTransaction = entityManager.getTransaction();
		try {
			//事务开始
			entityTransaction.begin();
			// 使用命名查询通过用户名检索所有用户
			Query query = entityManager.createNamedQuery("User.findAll");
			List<User> userList = query.getResultList();
			//提交事务
			entityTransaction.commit();

			return new Result(10, "获取全部信息成功", userList, "");

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
	@Path("/updateUser")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result updateUser(User user) {
		System.out.println("user---->" + user);
		try {
			// 1. 开始事务
			entityManager.getTransaction().begin();

			// 使用命名查询通过用户名检索用户
			TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsername", User.class);
			query.setParameter("username", user.getUsername());

			// 根据需要处理找到的用户
			User existingUser = query.getSingleResult();
//			更新用户
			if (existingUser != null) {
				existingUser.setRealName(user.getRealName());
				existingUser.setPassword(user.getPassword());
				existingUser.setSex(user.getSex());
				if (user.getModelHead()!=null){
					existingUser.setModel(user.getModel());
				}
				if (user.getModelHead()!=null) {
					existingUser.setModelHead(user.getModelHead());
				}
				existingUser.setIsAdmin(user.getIsAdmin());
				// 将更新后的用户对象合并到持久化上下文
				entityManager.merge(existingUser);
			}
			// 3. 提交事务
			entityManager.getTransaction().commit();

			if (((User)request.getSession().getAttribute("user")).getUsername().equals(user.getUsername())) {
				request.getSession().setAttribute("user", user);
			}

			return new Result(10, "成功修改", existingUser, "");
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
	@Path("/updateUserInfor")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result updateUserInfor(User user) {
		System.out.println("user---->" + user);
		EntityTransaction entityTransaction = entityManager.getTransaction();

		try {
			// 1. 开始事务
			entityManager.getTransaction().begin();

			// 使用命名查询通过用户名检索用户
			TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsername", User.class);
			query.setParameter("username", user.getUsername());

			// 根据需要处理找到的用户
			User existingUser = query.getSingleResult();
//			更新用户
			if (existingUser != null) {
				existingUser.setRealName(user.getRealName());
				existingUser.setPassword(user.getPassword());
				existingUser.setSex(user.getSex());
				if (user.getModelHead()!=null){
					existingUser.setModel(user.getModel());
				}
				if (user.getModelHead()!=null) {
					existingUser.setModelHead(user.getModelHead());
				}
				// 将更新后的用户对象合并到持久化上下文
				entityManager.merge(existingUser);
			}
			// 3. 提交事务
			entityManager.getTransaction().commit();

			// 4. 更新Session中的用户信息
			request.getSession().setAttribute("user", existingUser);

			return new Result(10, "成功修改", existingUser, "");
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
	@Path("/del")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result del(User user) {
		System.out.println("user---->" + user);
		EntityTransaction entityTransaction = entityManager.getTransaction();
		String username = user.getUsername();

		try {
			// 1. 开始事务
			entityManager.getTransaction().begin();

			// 2. 使用NamedQuery删除用户
			Query query = entityManager.createNamedQuery("User.deleteByUsername");
			query.setParameter("username", username);
			int deletedCount = query.executeUpdate();

			// 3. 提交事务
			entityManager.getTransaction().commit();

			if (deletedCount > 0) {
				return new Result(10, "删除成功", user, "");
			} else {
				return new Result(-10, "用户不存在或删除失败", null, "");
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
	@Path("/getOne")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("admin")
	public Result getOne(User user) {
		System.out.println("getOne："+user);

		// 使用命名查询通过用户名检索用户
		TypedQuery<User> query = entityManager.createNamedQuery("User.findByUsername", User.class);
		query.setParameter("username", user.getUsername());
		// 根据需要处理找到的用户
		User foundUser = query.getSingleResult();
		return new Result(10, "成功获取信息", foundUser, "");
	}

}
