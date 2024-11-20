package com.yash.onlinehomedecor.dao;
/**
 *
 * @author Kushagra Mishra
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;

import javax.sql.DataSource;
//DO NOT USER REPOSITORY OR SERVICE OR COMPONENT ANNOTATION
public class BaseDAO extends NamedParameterJdbcDaoSupport {
    @Autowired
    public void setDataSource2(DataSource ds){
        super.setDataSource(ds);

    }

//    protected JdbcTemplate jdbcTemplate;
//
//    @Autowired
//    public void setDataSource(DataSource dataSource) {
//        super.setDataSource(dataSource);
//        this.jdbcTemplate = getJdbcTemplate();
//    }




}
