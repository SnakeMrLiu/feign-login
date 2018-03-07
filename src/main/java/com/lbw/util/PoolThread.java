package com.lbw.util;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class PoolThread {

    private static  ExecutorService fixedThreadPool = Executors.newFixedThreadPool(10);

    public static void fixedThread(Runnable runnable){
        fixedThreadPool.execute(runnable);
    }
}
