package com.zhonghuasheng.musicstore.dao.impl;

import com.zhonghuasheng.musicstore.dao.UserDao;
import com.zhonghuasheng.musicstore.model.User;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository(value = "userDao")
public class UserDaoImpl extends BaseDao implements UserDao {

    private String statement = getSqlNameSpace(UserDaoImpl.class);

    @Override
    public User getUserByEmailAndPassword(String email, String password) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("email", email);
        map.put("password", password);
        User user = this.getSqlSession().selectOne(statement + "getUserByEmailAndPassword", map);

        return user;
    }
}
