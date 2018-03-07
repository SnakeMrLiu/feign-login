package com.lbw.controller.login;

import com.lbw.pojo.login.LogBean;
import com.lbw.service.login.LoginService;
import com.lbw.util.PoolThread;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@RequestMapping(value = "login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @RequestMapping(value = "loginUser")
    @ResponseBody
    public boolean loginUser(String username,String password){
        LogBean logBean = new LogBean();
        logBean.setFuncName("loginUser");
        logBean.setIp("196.125.1.135");
        logBean.setIpAddress("北京");
        logBean.setLogTime(new Date());
        logBean.setRequestInfo("username:"+username+";;password:"+password);
        logBean.setResponseInfo("登录成功");
        PoolThread.fixedThread(new LoginTreadPool(loginService,logBean));
        return false;
    }
}
