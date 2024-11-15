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

import java.util.List;

public class TestUserDAOFindAll {
    public static void main(String[] args) {
        ApplicationContext ctx=new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO=ctx.getBean(UserDAO.class);
        User user=new User();

        List<User> users = userDAO.findAll();
    for(User u : users) {
        System.out.println(u.getId()+" "+u.getName()+" "+u.getRole());

    }
        System.out.println("FIND ALL DONE!!!!!!!!!");
    }

}
