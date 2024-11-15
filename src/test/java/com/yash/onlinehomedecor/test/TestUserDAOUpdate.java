package com.yash.onlinehomedecor.test;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.config.SpringRootConfig;
import com.yash.onlinehomedecor.dao.UserDAO;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class TestUserDAOUpdate {
    public static void main(String[] args) {
        ApplicationContext ctx= new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO= ctx.getBean(UserDAO.class);
        User u=new User();
        u.setId(1);
        u.setName("Pratham");
        u.setEmail("pratham@gmail.com");
        u.setPassword("12345");
        u.setRole(UserRole.BUYER);

        userDAO.update(u);
        System.out.println("UPDATED!!");
    }


}
