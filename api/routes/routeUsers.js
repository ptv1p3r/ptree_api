'use strict';

const { AuthenticateJWT } = require("../helpers/security")

module.exports = app => {
    const controller = app.controllers.controllerUsers;

    /**
     * Users list endpoint
     */
    app.route('/api/v1/users/list').get(AuthenticateJWT, controller.listAll);

    /**
     * User details endpoint
     */
    app.route('/api/v1/users/view/:userId').get(AuthenticateJWT, controller.viewUser);

    /**
     * User creation endpoint
     */
    app.route('/api/v1/users/create').post(AuthenticateJWT, controller.createUser);
    // TODO Add a public create user for frontend

    /**
     * User update endpoint
     */
    app.route('/api/v1/users/edit/:userId').put(AuthenticateJWT, controller.editUser);

    /**
     * User deletion endpoint
     */
    app.route('/api/v1/users/delete/:userId').delete(AuthenticateJWT, controller.deleteUser);

}
