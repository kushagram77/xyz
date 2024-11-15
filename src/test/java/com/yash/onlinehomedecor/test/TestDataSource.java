package com.yash.onlinehomedecor.test;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.config.SpringRootConfig;
import com.yash.onlinehomedecor.config.SpringWebConfig;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

public class TestDataSource {
    public static void main(String[] args) {
        ApplicationContext ctx=new AnnotationConfigApplicationContext(SpringRootConfig.class);
        DataSource ds =ctx.getBean(DataSource.class);
        JdbcTemplate jt=new JdbcTemplate(ds);

        String sql="Insert into user( `name`, `email`, `password`, `role`) Values (?,?,?,?)";
        Object [] param= new Object[]{"Ananya","joshiji@yash.com","123456","Seller"};
        jt.update(sql,param);
        System.out.println("Executed Query Successfully!!!");

    }


}
