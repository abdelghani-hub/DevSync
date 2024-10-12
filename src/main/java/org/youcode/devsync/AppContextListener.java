package org.youcode.devsync;

import org.youcode.devsync.scheduler.TokenSchedular;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {
    private TokenSchedular tokenSchedular;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        tokenSchedular = new TokenSchedular();
        tokenSchedular.startTokenScheduler();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        tokenSchedular.stopTokenScheduler();
    }
}