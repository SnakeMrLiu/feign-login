package com.lbw.controller.login;

import com.lbw.service.login.LoginService;
import org.springframework.stereotype.Component;

@Component
public class LoginHystric implements LoginService {
    @Override
    public void loginUser(String log) {
        System.out.println("短路了，速度解决问题！");
    }
}
