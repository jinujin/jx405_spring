package com.bit.spring.service;

import com.bit.spring.model.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final String NAMESPACE = "mapper.UserMapper";
    private SqlSession session;
    @Autowired
    public UserService(SqlSession session) {
        this.session = session;
    }
    public UserDTO auth(UserDTO attempt){
        // .auth 는 UserMapper.xml 안에 id가 auth인 애를 실행시키려고
        return session.selectOne(NAMESPACE+".auth",attempt);

    }

    public boolean validate(String username) {
        return session.selectOne(NAMESPACE+".validate", username) == null;
    }

    public boolean insert(UserDTO userDTO) {
        if (validate((userDTO.getUsername()))) {
            session.insert(NAMESPACE + ".register", userDTO);
            return true;
        } else {
            return false;
        }
    }
    public void update(UserDTO userDTO) {
        session.update(NAMESPACE+".update", userDTO);
    }

    public void delete(int id) {
        session.delete(NAMESPACE + ".delete", id);
    }

//    public UserDTO selectOne(int id) {
//        return session.selectOne(NAMESPACE + ".selectOne", id);
//    }

}
