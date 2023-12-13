package restful.api;

import java.io.File;
import java.util.List;

import javax.persistence.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import net.sf.json.JSONArray;
import restful.annotation.Permission;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Suit;
import restful.utils.ImportUtil;
import restful.utils.JSONStringToJSONArray;

@Path("/suit")
public class SuitAPI {
	
	@Context 
	protected HttpServletRequest request;
	@Context
	protected HttpServletResponse response;
	EntityManagerFactory entityManagerFactory =
			Persistence.createEntityManagerFactory("default");

	EntityManager entityManager = entityManagerFactory.createEntityManager();

	@POST
	@Path("/suitList")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result suitList(Suit suit) {
		EntityTransaction entityTransaction = entityManager.getTransaction();
		try {
			//事务开始
			entityTransaction.begin();

			List<Suit> suitList = (List<Suit>) entityManager
					.createNamedQuery("Suit.findAllBySexAndType", Suit.class)
					.setParameter("sex", suit.isSex())
					.setParameter("type", suit.getType())
					.getResultList();
			//提交事务
			entityTransaction.commit();

			return new Result(10, "获取全部信息成功", suitList, "");

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
	@Path("/suitListByType")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result suitListByType(Suit suit) {
		EntityTransaction entityTransaction = entityManager.getTransaction();
		try {
			//事务开始
			entityTransaction.begin();

			List<Suit> suitList = (List<Suit>) EM.getEntityManager()
					.createNamedQuery("Suit.findAllByType", Suit.class)
					.setParameter("type", suit.getType())
					.getResultList();
			//提交事务
			entityTransaction.commit();

			return new Result(10, "获取全部信息成功", suitList, "");

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
	@Path("/suitListBySex")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result suitListBySex(Suit suit) {
		EntityTransaction entityTransaction = entityManager.getTransaction();
		try {
			//事务开始
			entityTransaction.begin();

			List<Suit> suitList = (List<Suit>) entityManager
					.createNamedQuery("Suit.findAllBySex", Suit.class)
					.setParameter("sex", suit.isSex())
					.getResultList();
			//提交事务
			entityTransaction.commit();

			return new Result(10, "获取全部信息成功", suitList, "");

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
	@Path("/addSuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result addSuit(Suit suit) {
//		suit.setId(0);
		// System.out.println(suit);
		if (EM.getEntityManager()
				.createNamedQuery("Suit.findAllByCode", Suit.class)
				.setParameter("code", suit.getCode()).getResultList().size() != 0) {
			return new Result(0, "不能重复添加", suit, "");
		}
		if (suit.getImage() == null) {
			if (suit.isSex()) {
				suit.setImage("mheadA.png");
			} else {
				suit.setImage("wheadA.png");
			}
		}
		suit = EM.getEntityManager().merge(suit);
		EM.getEntityManager().persist(suit);
		EM.getEntityManager().getTransaction().commit();
		return new Result(10, "添加成功", suit, "");
	}
	
	@POST
	@Path("/deleteSuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result deleteSuit(Suit suit) {
		EM.getEntityManager().remove(EM.getEntityManager().merge(suit));
		EM.getEntityManager().getTransaction().commit();
		return new Result(10, "成功删除", suit, "");
	}
	
	@POST
	@Path("/updateSuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result updateSuit(Suit suit) {
		EM.getEntityManager().persist(EM.getEntityManager().merge(suit));
		EM.getEntityManager().getTransaction().commit();
		return new Result(10, "成功修改", suit, "");
	}
	
	@POST
	@Path("/uploadImg")  
	@Produces("application/json;charset=UTF-8")  
	@Permission("user")
	public Result uploadImage(@QueryParam("suitCode") String suitCode) {  
	    // 创建DiskFileItem工厂 
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 获取项目路径
		String realPath = request.getSession().getServletContext().getRealPath("");
	    // 设置缓存目录
		factory.setRepository(new File(realPath + "WEB-INF\\uploadBuffer"));
		factory.setSizeThreshold(1024 * 1024);
	    // 创建文件上传解析对象
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("utf-8");
		upload.setFileSizeMax(1024 * 1024 * 5);
		upload.setSizeMax(1024 * 1024 * 10);
		// 设置保存路径
		String path = realPath + "images\\data\\suits\\";
		// System.out.println(path);
		
		// 解析并保存
	    try {
	    	List<FileItem> fileItems = upload.parseRequest(request);
	    	// 获取所有上传项
	        for (FileItem item : fileItems) {
	        	if (item.isFormField()) {
	        		// 非文件上传元素
	        		String name = item.getFieldName();
	        		String value = item.getString();
	        		System.out.println(name + ":" + value);
        		} else {
        			String fileName = item.getName();
        			File saveFile = new File(path + fileName);
        			item.write(saveFile);
        			// 持久化
        			Suit suit = EM.getEntityManager().createNamedQuery("Suit.findAllByCode", Suit.class)
        					.setParameter("code", suitCode).getResultList().get(0);
        			suit.setImage(fileName);
        			EM.getEntityManager().persist(EM.getEntityManager().merge(suit));
        			EM.getEntityManager().getTransaction().commit();
        			// 删除临时文件
        			item.delete();
        			return new Result(1, fileName, null, "");
        		}
	        }  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	        return new Result(-1, "服务器文件解析错误", null, "");  
	    }  
	    return new Result(-1, "未发现可供服务保存的数据", null, "");  
	}

	@POST
	@Path("/importSuit")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	@Permission("user")
	public Result importSuit(JSONArray jsonSuit) {
		ImportUtil.addAllDataSuit(JSONStringToJSONArray.getJSONArray(jsonSuit.toString()
				.replaceAll("编号", "code")
				.replaceAll("名称", "name")
				.replaceAll("价格", "price")
				.replaceAll("性别", "sex")
				.replaceAll("分类", "type")
				.replace("图片", "image")));
		return new Result(20, "成功导入", null, "");
	}
}
