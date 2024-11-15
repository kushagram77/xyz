package com.yash.onlinehomedecor.service;


import com.yash.onlinehomedecor.domain.User;
import java.util.List;

public interface AdminService {
    List<User> getAllBuyers();
    List<User> getAllSellers();
    void approveSeller(Integer userId);
    void rejectSeller(Integer userId);
}