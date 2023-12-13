package restful.interceptor;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Context;

import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ResourceMethodInvoker;
import org.jboss.resteasy.core.ServerResponse;
import org.jboss.resteasy.spi.Failure;
import org.jboss.resteasy.spi.HttpRequest;
import org.jboss.resteasy.spi.interception.PreProcessInterceptor;

import restful.annotation.Permission;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.User;

/**
 * SuitInterceptor 是一个用于RESTful Web服务的预处理拦截器，用于权限检查。
 */
@Permission
public class SuitInterceptor implements PreProcessInterceptor {

	@Context
	HttpServletRequest request;

	/*
	 * preProcess 方法在请求处理之前被调用。
	 * 如果请求是登录、注册或退出操作，则不执行权限检查。
	 * 如果请求不是登录、注册或退出操作，则执行相应的权限检查。
	 */
	@Override
	public ServerResponse preProcess(HttpRequest httpRequest, ResourceMethodInvoker resourceMethodInvoker)
			throws Failure, WebApplicationException {
		//检查是否是登录或注册或退出
		if (isLoginOrRegisterOrExit()) {
			return null;
		}
		//得到用户权限
		Method method = resourceMethodInvoker.getMethod();
		Annotation annotation = method.getAnnotation(Permission.class);
		if (!isPermit(((Permission) annotation).value())) {
			return new ServerResponse(new Result(-10, "用户权限不足！", null, ""),
					200, new Headers<Object>());
		}
		return null;
	}

	public boolean isLoginOrRegisterOrExit() {
		String path = request.getContextPath();
		String uri = request.getRequestURI();
		if (uri.equals(path + "/suitEmpty/login") || uri.equals(path + "/suitEmpty/register") || uri.equals(path + "/suitEmpty/exit")) {
			return true;
		}
		return false;
	}

	/**
	 * 执行实际的权限检查。
	 * @param visiter 访问者权限，例如 "admin"
	 * @return 如果权限足够，返回 true；否则返回 false。
	 */
	public boolean isPermit(String visiter) {
		User user = (User) request.getSession().getAttribute("user");
		if (visiter.equals("admin")) {
			if (!user.getIsAdmin())
			return false;
		}
		return true;
	}

}
