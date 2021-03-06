package ru.ds.common.listeners;

import javax.servlet.*;
import java.io.File;
import org.apache.log4j.PropertyConfigurator;

public class Log4jInit implements ServletContextListener {

    public void contextInitialized(ServletContextEvent event) {
        String homeDir=event.getServletContext().getRealPath("/");
        File propertiesFile=new File(homeDir,"WEB-INF/classes/log4j.properties");
        PropertyConfigurator.configure(propertiesFile.toString());
    }

    public void contextDestroyed(ServletContextEvent event) {}

}
