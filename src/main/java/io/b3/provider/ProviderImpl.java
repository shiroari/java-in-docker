package io.b3.provider;

import io.b3.api.Provider;

public class ProviderImpl implements Provider {

	@Override
	public String getName() {
		return "java9";
	}

}