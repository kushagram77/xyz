package com.yash.onlinehomedecor.service;

import com.yash.onlinehomedecor.dao.BaseDAO;
import com.yash.onlinehomedecor.dao.CartDAO;
import com.yash.onlinehomedecor.dao.UserDAO;
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.exception.UserBlockedException;
import com.yash.onlinehomedecor.rm.UserRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl extends BaseDAO implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private CartDAO cartDAO;

    @Override
    public void register(User u) {
        System.out.println("register in service");
        userDAO.save(u);
    }



    @Override
    public User login(String loginName, String password)  {

        String sql = "SELECT * " +
                "from user where name=:ln and password=:pw";

        Map m = new HashMap();
        m.put("ln", loginName);
        m.put("pw", password);

        try {
            //System.out.println(getNamedParameterJdbcTemplate().queryForObject(sql, m, new UserRowMapper()));
            User u = getNamedParameterJdbcTemplate().queryForObject(sql, m, new UserRowMapper());
            //System.out.println(u);
            return u;
        } catch (EmptyResultDataAccessException ex) {
            return null;
        }
    }

    @Override
    public List<User> getUserList() {
        return userDAO.findAll();
    }

    @Override
    public void update(User u) {
        userDAO.update(u);
    }

    @Override
    public void delete(Integer userId) {
        userDAO.delete(userId);
    }

    @Override
    public User findById(Integer userId) {
        return userDAO.findById(userId);
    }

    @Override
    public List<User> findByProperty(String propName, Object propValue) {
        return userDAO.findByProperty(propName, propValue);
    }
    @Override
    public void blockUser(Integer userId){
        userDAO.delete(userId);
        cartDAO.deleteByUserId(userId);
    }



}