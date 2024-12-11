package com.yash.onlinehomedecor.dao;
import java.util.List;
import com.yash.onlinehomedecor.domain.User;
/**
 *
 * @author Kushagra Mishra
 */


public interface UserDAO {
    public void save(User u);
    public void update(User u);
    public void delete(User u);
    public void delete(Integer id);
    public User findById(Integer id);
    public List<User> findAll(Integer id);
    public List<User> findAll();
    public List<User> findByProperty(String propName,Object propValue);
    public boolean isEmailExists(String email);
    User findByName(String name);
    //String getShippingAddress(int userId);


}
