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

public class TestUserFindById {

    public static void main(String[] args) {
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO=ctx.getBean(UserDAO.class);
        User u = userDAO.findById(1);
        System.out.println("--------User Detail------");

        System.out.println(u.getId());

        System.out.println(u.getName());

        System.out.println(u.getEmail());

        System.out.println(u.getRole());
    }
}
