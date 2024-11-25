package com.yash.onlinehomedecor.dao;



import com.yash.onlinehomedecor.domain.User;
import com.yash.onlinehomedecor.enums.UserRole;
import com.yash.onlinehomedecor.rm.UserRowMapper;
import org.springframework.stereotype.Repository;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AdminDAOImpl extends BaseDAO implements AdminDAO {

    @Override
    public List<User> findAllBuyers() {
        String sql = "SELECT * FROM user WHERE role = 'BUYER'";
        return getJdbcTemplate().query(sql, new UserRowMapper());
    }

    @Override
    public List<User> findAllSellers() {
        String sql = "SELECT * FROM user WHERE role IN('SELLER','REQUESTEDSELLER')";
        return getJdbcTemplate().query(sql, new UserRowMapper());
    }

    @Override
    public void updateSellerStatus(Integer userId, boolean approved) {
        String sql = "UPDATE user SET approved = :approved WHERE id = :userId AND role = 'SELLER'";
        Map<String, Object> params = new HashMap<>();
        params.put("approved", approved);
        params.put("userId", userId);
        getNamedParameterJdbcTemplate().update(sql, params);
    }
}
