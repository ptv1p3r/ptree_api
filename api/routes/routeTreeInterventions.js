'use strict';

const { AuthenticateJWT } = require("../helpers/security")

module.exports = app => {
    const controller = app.controllers.controllerTreeInterventions;

    /**
     * Interventions list
     */
    app.route('/api/v1/interventions/list').get(AuthenticateJWT, controller.listAll);

    /**
     * Intervention view by id
     */
    app.route('/api/v1/interventions/view/:interventionId').get(AuthenticateJWT, controller.viewIntervention);

    /**
     * Intervention create
     */
    app.route('/api/v1/interventions/create').post(AuthenticateJWT, controller.createIntervention);

    /**
     * Edit intervention
     */
    app.route('/api/v1/interventions/edit/:interventionId').put(AuthenticateJWT, controller.editIntervention);

    /**
     * Delete intervention by id
     */
    app.route('/api/v1/interventions/delete/:interventionId').delete(AuthenticateJWT, controller.deleteIntervention);

}
