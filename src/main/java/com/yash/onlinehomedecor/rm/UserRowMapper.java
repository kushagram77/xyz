package com.yash.onlinehomedecor.rm;
/**
 *
 * @author Kushagra Mishra
 */
import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRowMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet resultSet, int i) throws SQLException {
        User user=new User();
        user.setPassword(resultSet.getString("password"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setId(resultSet.getInt("id"));
        user.setRole(UserRole.valueOf(resultSet.getString("role").toUpperCase()));
        user.setAddress(resultSet.getString("address"));
        return user;
    }
}
