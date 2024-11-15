package com.yash.onlinehomedecor.service;



import com.yash.onlinehomedecor.dao.AdminDAO;
import com.yash.onlinehomedecor.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDAO adminDAO;

    @Override
    public List<User> getAllBuyers() {
        return adminDAO.findAllBuyers();
    }

    @Override
    public List<User> getAllSellers() {
        return adminDAO.findAllSellers();
    }

    @Override
    public void approveSeller(Integer userId) {
        adminDAO.updateSellerStatus(userId, true);
    }

    @Override
    public void rejectSeller(Integer userId) {
        adminDAO.updateSellerStatus(userId, false);
    }
}

