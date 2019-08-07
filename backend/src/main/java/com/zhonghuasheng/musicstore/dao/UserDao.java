package com.zhonghuasheng.musicstore.dao;

import com.zhonghuasheng.musicstore.model.User;

public interface UserDao {
    User getUserByEmailAndPassword(String email, String password);
}
