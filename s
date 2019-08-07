[1mdiff --git a/backend/.gitignore b/backend/.gitignore[m
[1mindex 28b08da..9b58180 100644[m
[1m--- a/backend/.gitignore[m
[1m+++ b/backend/.gitignore[m
[36m@@ -1,3 +1,15 @@[m
 /target/[m
[31m-*.properties[m
[31m-*.class[m
\ No newline at end of file[m
[32m+[m[32m# Compiled class file[m
[32m+[m[32m*.class[m
[32m+[m
[32m+[m[32m# Log file[m
[32m+[m[32m*.log[m
[32m+[m
[32m+[m[32m# BlueJ files[m
[32m+[m[32m*.ctxt[m
[32m+[m
[32m+[m[32m# Mobile Tools for Java (J2ME)[m
[32m+[m[32m.mtj.tmp/[m
[32m+[m
[32m+[m[32mhs_err_pid*[m
[32m+[m[32m*.properties[m
\ No newline at end of file[m
[1mdiff --git a/backend/.idea/vcs.xml b/backend/.idea/vcs.xml[m
[1mindex 6c0b863..288b36b 100644[m
[1m--- a/backend/.idea/vcs.xml[m
[1m+++ b/backend/.idea/vcs.xml[m
[36m@@ -2,5 +2,6 @@[m
 <project version="4">[m
   <component name="VcsDirectoryMappings">[m
     <mapping directory="$PROJECT_DIR$/.." vcs="Git" />[m
[32m+[m[32m    <mapping directory="$PROJECT_DIR$" vcs="Git" />[m
   </component>[m
 </project>[m
\ No newline at end of file[m
[1mdiff --git a/backend/pom.xml b/backend/pom.xml[m
[1mindex dc49a78..11d08b3 100644[m
[1m--- a/backend/pom.xml[m
[1m+++ b/backend/pom.xml[m
[36m@@ -26,7 +26,12 @@[m
             <groupId>org.springframework.boot</groupId>[m
             <artifactId>spring-boot-starter-web</artifactId>[m
         </dependency>[m
[31m-<!--        <dependency>[m
[32m+[m[32m        <dependency>[m
[32m+[m[32m            <groupId>org.springframework.boot</groupId>[m
[32m+[m[32m            <artifactId>spring-boot-starter-thymeleaf</artifactId>[m
[32m+[m[32m            <version>2.0.5.RELEASE</version>[m
[32m+[m[32m        </dependency>[m
[32m+[m[32m        <dependency>[m
             <groupId>mysql</groupId>[m
             <artifactId>mysql-connector-java</artifactId>[m
             <version>5.1.21</version>[m
[36m@@ -35,8 +40,9 @@[m
             <groupId>org.mybatis.spring.boot</groupId>[m
             <artifactId>mybatis-spring-boot-starter</artifactId>[m
             <version>1.3.0</version>[m
[31m-        </dependency>-->[m
[32m+[m[32m        </dependency>[m
     </dependencies>[m
[32m+[m
     <build>[m
         <plugins>[m
             <plugin>[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/controller/UserController.java b/backend/src/main/java/com/zhonghuasheng/musicstore/controller/UserController.java[m
[1mindex 6ed86b7..9033ec9 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/controller/UserController.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/controller/UserController.java[m
[36m@@ -1,4 +1,24 @@[m
 package com.zhonghuasheng.musicstore.controller;[m
 [m
[32m+[m[32mimport com.zhonghuasheng.musicstore.model.User;[m
[32m+[m[32mimport com.zhonghuasheng.musicstore.service.UserService;[m
[32m+[m[32mimport org.springframework.beans.factory.annotation.Autowired;[m
[32m+[m[32mimport org.springframework.stereotype.Controller;[m
[32m+[m[32mimport org.springframework.web.bind.annotation.RequestMapping;[m
[32m+[m[32mimport org.springframework.web.bind.annotation.RequestMethod;[m
[32m+[m[32mimport org.springframework.web.bind.annotation.RestController;[m
[32m+[m
[32m+[m[32m@RestController[m
[32m+[m[32m@RequestMapping(value = "/user")[m
 public class UserController {[m
[32m+[m
[32m+[m[32m    @Autowired[m
[32m+[m[32m    private UserService userService;[m
[32m+[m
[32m+[m[32m    @RequestMapping(value = "/login", method = RequestMethod.POST)[m
[32m+[m[32m    public User login(String email, String password) {[m
[32m+[m[32m        User user = userService.getUserByEmailAndPassword(email, password);[m
[32m+[m
[32m+[m[32m        return user;[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/UserDao.java b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/UserDao.java[m
[1mindex c5aaf11..603e727 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/UserDao.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/UserDao.java[m
[36m@@ -1,4 +1,7 @@[m
 package com.zhonghuasheng.musicstore.dao;[m
 [m
[32m+[m[32mimport com.zhonghuasheng.musicstore.model.User;[m
[32m+[m
 public interface UserDao {[m
[32m+[m[32m    User getUserByEmailAndPassword(String email, String password);[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/BaseDao.java b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/BaseDao.java[m
[1mindex cd54497..d3a5621 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/BaseDao.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/BaseDao.java[m
[36m@@ -1,4 +1,18 @@[m
 package com.zhonghuasheng.musicstore.dao.impl;[m
 [m
[31m-public class BaseDao {[m
[32m+[m[32mimport org.mybatis.spring.SqlSessionTemplate;[m
[32m+[m[32mimport org.mybatis.spring.support.SqlSessionDaoSupport;[m
[32m+[m[32mimport org.springframework.beans.factory.annotation.Autowired;[m
[32m+[m[32mimport org.thymeleaf.util.StringUtils;[m
[32m+[m
[32m+[m[32mpublic class BaseDao extends SqlSessionDaoSupport {[m
[32m+[m
[32m+[m[32m    @Autowired[m
[32m+[m[32m    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {[m
[32m+[m[32m        super.setSqlSessionTemplate(sqlSessionTemplate);[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    protected String getSqlNameSpace(Class<?> c) {[m
[32m+[m[32m        return StringUtils.concat(c.getInterfaces()[0], ".");[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/UserDaoImpl.java b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/UserDaoImpl.java[m
[1mindex 4f6c796..52754b6 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/UserDaoImpl.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/dao/impl/UserDaoImpl.java[m
[36m@@ -1,11 +1,23 @@[m
[31m-package com.zhonghuasheng.musicstore.dao;[m
[32m+[m[32mpackage com.zhonghuasheng.musicstore.dao.impl;[m
 [m
[32m+[m[32mimport com.zhonghuasheng.musicstore.dao.UserDao;[m
 import com.zhonghuasheng.musicstore.model.User;[m
[32m+[m[32mimport org.springframework.stereotype.Repository;[m
 [m
[31m-public class UserDaoImpl implements UserDao {[m
[32m+[m[32mimport java.util.HashMap;[m
[32m+[m
[32m+[m[32m@Repository(value = "userDao")[m
[32m+[m[32mpublic class UserDaoImpl extends BaseDao implements UserDao {[m
[32m+[m
[32m+[m[32m    private String statement = getSqlNameSpace(UserDaoImpl.class);[m
 [m
     @Override[m
     public User getUserByEmailAndPassword(String email, String password) {[m
[31m-        return null;[m
[32m+[m[32m        HashMap<String, Object> map = new HashMap<>();[m
[32m+[m[32m        map.put("email", email);[m
[32m+[m[32m        map.put("password", password);[m
[32m+[m[32m        User user = this.getSqlSession().selectOne(statement + "getUserByEmailAndPassword", map);[m
[32m+[m
[32m+[m[32m        return user;[m
     }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/model/BaseModel.java b/backend/src/main/java/com/zhonghuasheng/musicstore/model/BaseModel.java[m
[1mindex 7660b60..0f4d6db 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/model/BaseModel.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/model/BaseModel.java[m
[36m@@ -1,4 +1,53 @@[m
 package com.zhonghuasheng.musicstore.model;[m
 [m
[32m+[m[32mimport java.sql.Timestamp;[m
[32m+[m[32mimport java.util.UUID;[m
[32m+[m
 public class BaseModel {[m
[32m+[m
[32m+[m[32m    private UUID uuid;[m
[32m+[m[32m    private Timestamp createTime;[m
[32m+[m[32m    private Timestamp lastModifiedTime;[m
[32m+[m[32m    private String lastModifiedBy;[m
[32m+[m[32m    private boolean deleted;[m
[32m+[m
[32m+[m[32m    public UUID getUuid() {[m
[32m+[m[32m        return uuid;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setUuid(UUID uuid) {[m
[32m+[m[32m        this.uuid = uuid;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Timestamp getCreateTime() {[m
[32m+[m[32m        return createTime;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setCreateTime(Timestamp createTime) {[m
[32m+[m[32m        this.createTime = createTime;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Timestamp getLastModifiedTime() {[m
[32m+[m[32m        return lastModifiedTime;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setLastModifiedTime(Timestamp lastModifiedTime) {[m
[32m+[m[32m        this.lastModifiedTime = lastModifiedTime;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getLastModifiedBy() {[m
[32m+[m[32m        return lastModifiedBy;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setLastModifiedBy(String lastModifiedBy) {[m
[32m+[m[32m        this.lastModifiedBy = lastModifiedBy;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public boolean isDeleted() {[m
[32m+[m[32m        return deleted;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setDeleted(boolean deleted) {[m
[32m+[m[32m        this.deleted = deleted;[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/model/Gender.java b/backend/src/main/java/com/zhonghuasheng/musicstore/model/Gender.java[m
[1mindex ebfeac6..307aebb 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/model/Gender.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/model/Gender.java[m
[36m@@ -1,4 +1,21 @@[m
 package com.zhonghuasheng.musicstore.model;[m
 [m
 public enum Gender {[m
[32m+[m[32m    MALE("男"),[m
[32m+[m[32m    FEMALE("女"),[m
[32m+[m[32m    UNKNOW("未知");[m
[32m+[m
[32m+[m[32m    private String value;[m
[32m+[m
[32m+[m[32m    private Gender(String value) {[m
[32m+[m[32m        this.value = value;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getValue() {[m
[32m+[m[32m        return value;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setValue(String value) {[m
[32m+[m[32m        this.value = value;[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/model/Role.java b/backend/src/main/java/com/zhonghuasheng/musicstore/model/Role.java[m
[1mindex 75232eb..8c86e30 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/model/Role.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/model/Role.java[m
[36m@@ -1,4 +1,20 @@[m
 package com.zhonghuasheng.musicstore.model;[m
 [m
 public enum Role {[m
[32m+[m[32m    ADMIN("管理员"),[m
[32m+[m[32m    USER("普通用户");[m
[32m+[m
[32m+[m[32m    private String value;[m
[32m+[m
[32m+[m[32m    private Role(String value) {[m
[32m+[m[32m        this.value = value;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getValue() {[m
[32m+[m[32m        return value;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setValue(String value) {[m
[32m+[m[32m        this.value = value;[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/model/User.java b/backend/src/main/java/com/zhonghuasheng/musicstore/model/User.java[m
[1mindex 6f8099f..571eee3 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/model/User.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/model/User.java[m
[36m@@ -1,4 +1,78 @@[m
 package com.zhonghuasheng.musicstore.model;[m
 [m
[31m-public class User {[m
[32m+[m[32mimport java.util.Date;[m
[32m+[m
[32m+[m[32mpublic class User extends BaseModel {[m
[32m+[m[32m    private String username;[m
[32m+[m[32m    private String email;[m
[32m+[m[32m    private String password;[m
[32m+[m[32m    private Role role;[m
[32m+[m[32m    private Date birthday;[m
[32m+[m[32m    private Gender gender;[m
[32m+[m[32m    private String avatar;[m
[32m+[m[32m    private boolean active;[m
[32m+[m
[32m+[m[32m    public String getUsername() {[m
[32m+[m[32m        return username;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setUsername(String username) {[m
[32m+[m[32m        this.username = username;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getEmail() {[m
[32m+[m[32m        return email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setEmail(String email) {[m
[32m+[m[32m        this.email = email;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getPassword() {[m
[32m+[m[32m        return password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setPassword(String password) {[m
[32m+[m[32m        this.password = password;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Role getRole() {[m
[32m+[m[32m        return role;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setRole(Role role) {[m
[32m+[m[32m        this.role = role;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Date getBirthday() {[m
[32m+[m[32m        return birthday;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setBirthday(Date birthday) {[m
[32m+[m[32m        this.birthday = birthday;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public Gender getGender() {[m
[32m+[m[32m        return gender;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setGender(Gender gender) {[m
[32m+[m[32m        this.gender = gender;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public String getAvatar() {[m
[32m+[m[32m        return avatar;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setAvatar(String avatar) {[m
[32m+[m[32m        this.avatar = avatar;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public boolean isActive() {[m
[32m+[m[32m        return active;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    public void setActive(boolean active) {[m
[32m+[m[32m        this.active = active;[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/service/UserService.java b/backend/src/main/java/com/zhonghuasheng/musicstore/service/UserService.java[m
[1mindex 08144fa..edf88dc 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/service/UserService.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/service/UserService.java[m
[36m@@ -1,4 +1,7 @@[m
 package com.zhonghuasheng.musicstore.service;[m
 [m
[32m+[m[32mimport com.zhonghuasheng.musicstore.model.User;[m
[32m+[m
 public interface UserService {[m
[32m+[m[32m    User getUserByEmailAndPassword(String email, String password);[m
 }[m
[1mdiff --git a/backend/src/main/java/com/zhonghuasheng/musicstore/service/impl/UserServiceImpl.java b/backend/src/main/java/com/zhonghuasheng/musicstore/service/impl/UserServiceImpl.java[m
[1mindex c2ecd91..ff16ba1 100644[m
[1m--- a/backend/src/main/java/com/zhonghuasheng/musicstore/service/impl/UserServiceImpl.java[m
[1m+++ b/backend/src/main/java/com/zhonghuasheng/musicstore/service/impl/UserServiceImpl.java[m
[36m@@ -1,4 +1,19 @@[m
 package com.zhonghuasheng.musicstore.service.impl;[m
 [m
[31m-public class UserServiceImpl {[m
[32m+[m[32mimport com.zhonghuasheng.musicstore.dao.UserDao;[m
[32m+[m[32mimport com.zhonghuasheng.musicstore.model.User;[m
[32m+[m[32mimport com.zhonghuasheng.musicstore.service.UserService;[m
[32m+[m[32mimport org.springframework.beans.factory.annotation.Autowired;[m
[32m+[m[32mimport org.springframework.stereotype.Service;[m
[32m+[m
[32m+[m[32m@Service(value = "userService")[m
[32m+[m[32mpublic class UserServiceImpl implements UserService {[m
[32m+[m
[32m+[m[32m    @Autowired[m
[32m+[m[32m    private UserDao userDao;[m
[32m+[m
[32m+[m[32m    @Override[m
[32m+[m[32m    public User getUserByEmailAndPassword(String email, String password) {[m
[32m+[m[32m        return userDao.getUserByEmailAndPassword(email, password);[m
[32m+[m[32m    }[m
 }[m
[1mdiff --git a/backend/src/main/resources/application.properties b/backend/src/main/resources/application.properties[m
[1mindex bafddce..cf9b0a7 100644[m
[1m--- a/backend/src/main/resources/application.properties[m
[1m+++ b/backend/src/main/resources/application.properties[m
[36m@@ -1 +1,2 @@[m
[31m-server.port=8081[m
\ No newline at end of file[m
[32m+[m[32mserver.port=8081[m
[32m+[m[32mmybatis.mapper-locations=mappers/*Mapper.xml[m
\ No newline at end of file[m
[1mdiff --git a/backend/src/main/resources/mappers/UserMapper.xml b/backend/src/main/resources/mappers/UserMapper.xml[m
[1mindex e69de29..977ba39 100644[m
[1m--- a/backend/src/main/resources/mappers/UserMapper.xml[m
[1m+++ b/backend/src/main/resources/mappers/UserMapper.xml[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8"?>[m
[32m+[m[32m<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">[m
[32m+[m
[32m+[m[32m<mapper namespace="com.zhonghuasheng.musicstore.dao.UserDao">[m
[32m+[m[32m    <resultMap id="userMap" type="com.zhonghuasheng.musicstore.model.User">[m
[32m+[m[32m        <id column="id" property="id" />[m
[32m+[m[32m        <result column="nickname" property="nickname" />[m
[32m+[m[32m        <result column="password" property="password" />[m
[32m+[m[32m        <result column="gender" property="gender"/>[m
[32m+[m[32m        <result column="email" property="email"/>[m
[32m+[m[32m        <result column="phonenumber" property="phoneNumber"/>[m
[32m+[m[32m        <result column="status" property="status"/>[m
[32m+[m[32m        <result column="isactive" property="isActive"/>[m
[32m+[m[32m    </resultMap>[m
[32m+[m
[32m+[m[32m    <select id="getByNicknameAndPassword" parameterType="map" resultMap="userMap">[m
[32m+[m[32m        <![CDATA[[m
[32m+[m[32m            SELECT[m
[32m+[m[32m                *[m
[32m+[m[32m            FROM user[m
[32m+[m[32m            WHERE nickname= #{nickname} AND password = #{password}[m
[32m+[m[32m        ]]>[m
[32m+[m[32m    </select>[m
[32m+[m[32m</mapper>[m
\ No newline at end of file[m
