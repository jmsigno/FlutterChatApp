"use strict";

const ApiGateway = require("moleculer-web");

module.exports = {
	name: "api",
	mixins: [ApiGateway],

	// More info about settings: https://moleculer.services/docs/0.13/moleculer-web.html
	settings: {
		port: process.env.PORT || 3000,

		routes: [{
			path: "/api",
			// RESTful aliases
			aliases: {
				"POST user/register": "usermanagement.create",
				"GET user/login": "usermanagement.loginList",
				"POST user/login": "usermanagement.login",
				"GET user/userList": "usermanagement.list",
				"GET user/getRegID/:id": "usermanagement.get",
				"GET user/getLoginID/login": "usermanagement.getLogin",
				//"PUT user/usermanagement/:id": "usermanagement.update",
				//"DELETE user/usermanagement/:id": "usermanagement.remove",
			
			  },
			whitelist: [
				// Access to any actions in all services under "/api" URL
				"**"
			]
		}],

		// Serve assets from "public" folder
		assets: {
			folder: "public"
		}
	}
};
