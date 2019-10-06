"use strict";

var admin = require("firebase-admin");

var serviceAccount = require("./fluttermolecular-7cd66-firebase-adminsdk-2imcx-9cad1fc2e6.json");

module.exports = {
  name: "register",

  /**
   * Service settings
   */
  settings: {},

  /**
   * Service dependencies
   */
  dependencies: [],

  /**
   * Actions
   */
  actions: {
    // registration process
    list: {
      handler(ctx) {
        return "GET register list";
      }
    },

    get: {
      handler(ctx) {
        return `GET the register with Id = ${ctx.params.id}`;
      }
    },

    getLogin: {
      handler(ctx) {
        return `GET the register with`;
      }
    },

    create: {
      params: {
        username: { type: "string" },
        password: { type: "string" }
      },
      handler(ctx) {
        let db = this.getDb();

        return db
          .collection("users")
          .where("username", "==", ctx.params.username)
          .get()
          .then(function(querySnapshot) {
            if (querySnapshot.size == 0) {
              return db
                .collection("users")
                .add({
                  username: ctx.params.username,
                  password: ctx.params.password
                })
                .then(function(docRef) {
                  console.log("Document written with ID: ", docRef.id);
                  return "Success";
                })
                .catch(function(error) {
                  console.error("Error adding document: ", error);
                });
            } else {
              return "UserExist";
            }
          });
      }
    },

    update: {
      params: {
        title: { type: "string" }
      },
      handler(ctx) {
        return `UPDATE title of register with Id = ${ctx.params.id}. New title: ${ctx.params.title}`;
      }
    },

    remove: {
      handler(ctx) {
        return `DELETE register with Id = ${ctx.params.id}`;
      }
    },

    // login process
    loginList: {
      handler(ctx) {
        return "GET userLogin list";
      }
    },

    login: {
      params: {
        username: { type: "string" },
        password: { type: "string" }
      },
      handler(ctx) {
        let db = this.getDb();

        return db
          .collection("users")
          .where("username", "==", ctx.params.username)
          .where("password", "==", ctx.params.password)
          .get()
          .then(function(querySnapshot) {
            if (querySnapshot.size == 1) {
              return "LoginSuccess";
            } else {
              return "InvalidCredentials";
            }
          });
      }
    }
  },

  /**
   * Events
   */
  events: {},

  /**
   * Methods
   */
  methods: {
    getDb() {
      return admin.firestore();
    }
  },

  /**
   * Service created lifecycle event handler
   */
  created() {
    admin.initializeApp({
      credential: admin.credential.cert(serviceAccount),
      databaseURL: "https://fluttermolecular-7cd66.firebaseio.com"
    });

    var db = this.getDb();

    var aa = db
      .collection("users")
      .get()
      .then(s => {
        console.log("Firebase Database Initialzed");
      });
  },

  /**
   * Service started lifecycle event handler
   */
  started() {},

  /**
   * Service stopped lifecycle event handler
   */
  stopped() {}
};
