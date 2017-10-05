package io.b3.app;

import java.util.Iterator;
import java.util.ServiceLoader;

import io.b3.api.Provider;

public class Main {

	public static void main(String[] args) {
		new Main().run();
	}

	private Provider getProvider() {
		ServiceLoader<Provider> spi = ServiceLoader.load(Provider.class);        
		for (Iterator<Provider> it = spi.iterator(); it.hasNext();) {
			return it.next();	
		}
		throw new RuntimeException("No service providers found!");
	}

	public void run() {
		System.out.format("Hello, %s!%n", getProvider().getName());
	}

}