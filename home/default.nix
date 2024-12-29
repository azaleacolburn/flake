{...}: {
	imports = [
		./apps
		./desktop
		./shell
		./suites
		./fix-xdg.nix
		./monitors.nix
	];
	
	home = {
		stateVersion = "24.05";
		sessionVariables = {
			editor = "nvim";
		};
	 };
}
