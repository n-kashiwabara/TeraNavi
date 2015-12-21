package ttc.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import ttc.context.RequestContext;
import ttc.command.AbstractCommand;
import ttc.exception.PresentationException;

public abstract class CommandFactory{
	public static AbstractCommand getCommand(RequestContext rc){
		AbstractCommand command = null;
		Properties prop = new Properties();

		try{
			prop.load(new FileInputStream("c:/GitHub/TeraNavi/resources/command.properties"));

			String name = prop.getProperty(rc.getCommandPath());

			Class c = Class.forName(name);

			command = (AbstractCommand)c.newInstance();

		} catch(FileNotFoundException e){
			throw new PresentationException(e.getMessage(), e);
		} catch(IOException e){
			throw new PresentationException(e.getMessage(), e);
		} catch(ClassNotFoundException e){
			throw new PresentationException(e.getMessage(), e);
		} catch(InstantiationException e){
			throw new PresentationException(e.getMessage(), e);
		} catch(IllegalAccessException e){
			throw new PresentationException(e.getMessage(), e);
		}
		return command;
	}

}
