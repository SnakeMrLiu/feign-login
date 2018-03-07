package com.lbw.controller.login;

import com.alibaba.fastjson.JSON;
import com.lbw.pojo.login.LogBean;
import com.lbw.service.login.LoginService;

public class LoginTreadPool implements Runnable {

    private LoginService loginService;

    private LogBean logBean;

    public LoginTreadPool(LoginService loginService, LogBean logBean) {
        this.loginService = loginService;
        this.logBean = logBean;
    }
    @Override
    public void run() {
        String log = JSON.toJSONString(logBean);
        loginService.loginUser(log);
    }
}
