package com.yash.onlinehomedecor.test;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.config.SpringRootConfig;
import com.yash.onlinehomedecor.dao.UserDAO;
import com.yash.onlinehomedecor.domain.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class TestUserDAODelete {

    public static void main(String[] args) {
        ApplicationContext ctx=new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO= ctx.getBean(UserDAO.class);
        User u=new User();
        userDAO.delete(6);
        System.out.println("DELETED!!!!!!!");

    }
}
