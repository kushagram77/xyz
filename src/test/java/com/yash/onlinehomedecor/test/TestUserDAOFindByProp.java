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

public class TestUserDAOFindByProp {

    public static void main(String[] args) {
        ApplicationContext ctx = new AnnotationConfigApplicationContext(SpringRootConfig.class);
        UserDAO userDAO=ctx.getBean(UserDAO.class);


        List<User> users = userDAO.findByProperty("role", 2);
        for (User u : users) {
            System.out.println(u.getId()+" "+u.getName()+" "+u.getRole());
            //TODO: access other columns
        }

        System.out.println("FIND BY PROP!!!!!!");
    }
}
