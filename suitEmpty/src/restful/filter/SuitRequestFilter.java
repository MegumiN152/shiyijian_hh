package restful.filter; /**
 * @Description ${TODO}
 * @Author 住京华 www.zhujinghua.com
 * @Date 2023/12/2
 */

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SuitRequestFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }
    
    public void destroy() {
    }
    
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws ServletException, IOException {

        servletResponse.setContentType("text/html; charset=utf-8");
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if (!isLoginOrRegister(request) && !isLogin(request)) {
            response.getWriter().print("<script language='javascript'>alert('请先登录用户');" +
                    "window.location.href='/suitEmpty/jsp/login.jsp';</script>");
            // response.sendRedirect("/suit/jsp/login.jsp");
        }
        chain.doFilter(request, response);

    }


    public boolean isLoginOrRegister(HttpServletRequest request) {
        String path = request.getContextPath();
        if (request.getRequestURI().equals(path + "/jsp/login.jsp")
                || request.getRequestURI().equals(path + "/jsp/register.jsp")) {
            return true;
        }
        return false;
    }

    public boolean isLogin(HttpServletRequest request) {
        if (request.getSession().getAttribute("user") == null) {
            return false;
        }
        return true;
    }
}
