package com.lbw.service.login;


import com.lbw.controller.login.LoginHystric;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Service
@FeignClient(value = "privoducerlog",fallback = LoginHystric.class)
public interface LoginService {
    @RequestMapping(value = "/log/logRecord")
    void loginUser(@RequestParam(value = "log") String log);
}


