module provider {
	requires api;
	provides io.b3.api.Provider with io.b3.provider.ProviderImpl;
}