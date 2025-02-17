package com.yash.onlinehomedecor.dao;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.rm.UserRowMapper;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDAOImpl extends BaseDAO implements UserDAO{
    @Override
    public void save(User u) {
        System.out.println("save in dao");
        String sql="INSERT INTO user (`name`, `email`, `password`, `role`,`address`)"+" VALUES (:name,:email,:password,:role,:address)";

        Map m=new HashMap();
        m.put("name",u.getName());
        m.put("email",u.getEmail());
        m.put("password",u.getPassword());
        m.put("role",u.getRole().name());
        m.put("address",u.getAddress());
        KeyHolder kh=new GeneratedKeyHolder();// holds value which get auto incremented
        SqlParameterSource ps=new MapSqlParameterSource(m);
        super.getNamedParameterJdbcTemplate().update(sql,ps,kh);
        Integer id =kh.getKey().intValue();

        u.setId(id);
    }


    @Override
    public void update(User u) {
        String sql = "UPDATE user " +
                "SET `name` = :name, " +
                "`email` = :email, " +
                "`password` = :password, " +
                "`role`=:role, "+
                "`address`=:address "+
                "WHERE id = :userId";
        Map m = new HashMap();
        m.put("name", u.getName());

        m.put("email", u.getEmail());



        m.put("userId", u.getId());

        m.put("password",u.getPassword());
        m.put("role",u.getRole().name());
        m.put("address",u.getAddress());
        getNamedParameterJdbcTemplate().update(sql, m);
    }

    @Override
    public void delete(User u) {
        this.delete(u.getId());
    }

    @Override
    public void delete(Integer userId) {
        String sql="DELETE FROM user WHERE id=?";
        getJdbcTemplate().update(sql, userId);
    }

    public User findById(Integer userId) {
        String sql = "SELECT * "
                + " FROM user WHERE id=?";
        User u = getJdbcTemplate().queryForObject(sql, new UserRowMapper(),userId);
        System.out.println("Shipping address in DAO"+u.getAddress());
        System.out.println("Customer Name"+u.getName());
        return u;
    }

    @Override
    public List<User> findAll(Integer id) {
        return Collections.emptyList();
    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT * "
                + " FROM user";
           /*
           List<User> users = getJdbcTemplate().query(sql, new UserRowMapper());
           return users;
           */
        return getJdbcTemplate().query(sql, new UserRowMapper());
    }

    @Override
    public List<User> findByProperty(String propName, Object propValue) {
        String sql = "SELECT * "
                + " FROM user WHERE "+propName+"=?";
        return getJdbcTemplate().query(sql, new UserRowMapper(), propValue);
    }



    public User findByName(String name ){
        String sql = "SELECT * "
                + " FROM user WHERE name=?";
        User u = getJdbcTemplate().queryForObject(sql, new UserRowMapper(),name);

        return u;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM user WHERE email = ?";
        try {
            Integer count = getJdbcTemplate().queryForObject(sql, Integer.class, email);
            return count != null && count > 0;
        } catch (EmptyResultDataAccessException e) {
            return false;
        }
    }

}
