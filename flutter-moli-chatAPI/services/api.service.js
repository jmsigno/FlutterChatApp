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
				"GET user/register": "register.list",
				"GET user/register/:id": "register.get",
				"POST user/register": "register.create",
				"GET user/register/login": "register.getLogin",
				"PUT user/register/:id": "register.update",
				"DELETE user/register/:id": "register.remove",
				
			    "GET user/login": "register.loginList",
				// "GET user/login/:id": "login.get",
				"POST user/login": "register.login",
				// "PUT user/login/:id": "login.update",
				// "DELETE user/login/:id": "login.remove"
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
