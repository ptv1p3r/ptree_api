'use strict';

const emailController = require('./../helpers/email');
const jwt = require('jsonwebtoken');
const responseCode = require('../helpers/httpCodesDefinitions')
const { verifyRefreshJWT, encryptText, decryptText } = require("../helpers/security")
const { validationResult } = require("../helpers/validator")
const modelUser = require('./../models/modelUsers')();

module.exports = app => {
    const controller = {};

    /**
     * User controller login returning access and refresh token
     * @param req
     * @param res
     * @returns {*}
     */
    controller.login = async (req, res) => {
        try {
            const errors = validationResult(req);
            if (!errors.isEmpty()) {
                return res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                    auth: false,
                    errors: errors.array()
                });
            }

            const userData = {
                email: req.body.email.trim().toLowerCase(),
                password: req.body.password.trim()
            }
            //const { email, password } = req.body;

            if (!userData.email || !userData.password) {
                return res.status(responseCode.ERROR_CODE.NOT_FOUND).json({
                    auth: false,
                    error: "Enter valid authorization credentials!"
                });
            }

            const user = await modelUser.getUserByEmail(userData.email);

            if (user.length === 0) return res.status(responseCode.ERROR_CODE.NOT_FOUND).json({
                auth: false,
                error: "Enter valid authorization credentials!"
            });

            if(user[0].password !== userData.password) return res.status(responseCode.ERROR_CODE.NOT_FOUND).json({
                auth: false,
                error: "Enter valid authorization credentials!"
            });

            if(user[0].active !== 1) return res.status(responseCode.ERROR_CODE.FORBIDDEN).json({
                auth: false,
                error: "User not active!"
            });

            const accessToken = jwt.sign({email: userData.email}, app.get('token.accessSecret'), {
                expiresIn: app.get('token.accessValidity'),
            });
            const refreshToken = jwt.sign({email: userData.email}, app.get('token.refreshSecret'), {
                expiresIn: app.get('token.refreshValidity'),
            });

            await modelUser.setUserLoginTime(user[0].id);

            res.status(responseCode.SUCCESS_CODE.OK).json({
                auth: true,
                accessToken: accessToken,
                refreshToken: refreshToken
            });

        } catch (error) {
            res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                login: false,
                code: error.code,
                message: error.text
            });
        }
    }

    /**
     * User controller logout
     * @param req
     * @param res
     * @returns {*}
     */
    controller.logout = (req, res) => res.status(responseCode.SUCCESS_CODE.OK).json({
        auth: false,
        accessToken: null,
        refreshToken: null,
        message: "User logged out!"
    });

    /**
     * User controller account activation
     * @param req
     * @param res
     * @returns {*}
     */
    controller.register = async (req, res) => {

        try {
            const userData = {
                activationToken: req.params.activationToken.trim()
            }

            const userEmail = await modelUser.getUserEmailByActivationToken(userData.activationToken);

            await modelUser.activateUser(userData.activationToken)
                .then( async () => {
                    await emailController.sendMail({
                        from: '"www.adoteumaarvore.pt 👻" <' + global.smtpUser + '>', // sender address
                        to: userEmail[0].email, // list of receivers
                        subject: "User Activation ✔", // Subject line
                        template: 'userActivated', // template to use
                        context:{
                            domain: "www.adoteumaarvore.pt", // {{domain}}
                            helpEmail: "info@adoteumaarvore.pt", // {{helpEmail}}
                        },
                    });
            });

            res.status(responseCode.SUCCESS_CODE.OK).end('User account activated.');

        } catch (error) {
            res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                activated: false,
                code: error.code,
                message: error.text
            });
        }
    }

    /**
     * User getting new access token using refresh token
     * @param req
     * @param res
     * @returns {*}
     */
    controller.refresh = (req, res) => {
        const { email, refreshToken } = req.body;

        const isValid = verifyRefreshJWT(email, refreshToken);

        if (!isValid) {
            return res.status(responseCode.ERROR_CODE.UNAUTHORIZED).json({
                auth: false,
                message: "Invalid token,login again!"
            });
        }

        const accessToken = jwt.sign({ email: email }, app.get('token.accessSecret'), {
            expiresIn: app.get('token.accessValidity'),
        });

        res.status(responseCode.SUCCESS_CODE.OK).json({
            auth: true,
            accessToken: accessToken
        });
    }

    /**
     * User recover password
     * @param req
     * @param res
     * @returns {Promise<*>}
     */
    controller.recover = async (req, res) => {
        try {
            const userData = {
                email: req.body.email.toLowerCase().trim()
            }

            const user = await modelUser.getUserByEmail(userData.email);

            if (!user) {
                return res.status(responseCode.ERROR_CODE.NOT_FOUND).json({
                    recover: false,
                    message: "User not found!"
                });
            }

            // encrypt user id and generate encrypted object (iv, encryptedData)
            const encryptedData = encryptText(user[0].id);

            // store encrypt key
            const userEncryptData = {
                id: user[0].id,
                iv: encryptedData.iv
            }
            // store encryption key on user record
            await modelUser.setUserEncryptKey(userEncryptData);

            await emailController.sendMail({
                from: '"www.adoteumaarvore.pt 👻" <' + global.smtpUser + '>', // sender address
                to: user[0].email, // list of receivers
                subject: "User Password Recovery ✔", // Subject line
                template: 'userPasswordRecovery', // template to use
                context:{
                    domain: "www.adoteumaarvore.pt", // {{domain}}
                    recoverPasswordLink: `http://127.0.0.1/register/passrecover/${user[0].id}/${encryptedData.encryptedData}`, // {{recoverPasswordLink}}
                    helpEmail: "info@adoteumaarvore.pt", // {{helpEmail}}
                },
            });

            res.status(responseCode.SUCCESS_CODE.OK).end('User password recovery email sent.');

        } catch (error) {
            res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                activated: false,
                code: error.code,
                message: error.text
            });
        }
    }

    /**
     * User recover password activation
     * @param req
     * @param res
     * @returns {Promise<*>}
     */
    controller.activation = async (req, res) => {
        try {
            const userData = {
                id: req.params.userId.trim(),
                token: req.body.token.trim(),
            }

            // get user data
            const user = await modelUser.getUserById(userData.id);

            if (!user) {
                return res.status(responseCode.ERROR_CODE.NOT_FOUND).json({
                    recover: false,
                    message: "User not found!"
                });
            }

            // create decrypt object
            const decryptPayload = {
                iv: user[0].encryptKey,
                encryptedData: userData.token
            }

            // encrypt user id and generate encrypted object (iv, encryptedData)
            const decryptedData = decryptText(decryptPayload);
            // check decrypted user id with supplied id
            if (user[0].id !== decryptedData) {
                return res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                    recover: false,
                    message: "Encryption validation mismatch!"
                });
            }

            // setup user payload
            const userUpdateData = {
                id: user[0].id,
                body: {
                    password: req.body.password.trim()
                }
            }
            // set password
            await modelUser.editPatchUser(userUpdateData)

            // clear encryption key on user record
            const userEncryptData = {
                id: user[0].id,
                iv: ""
            }
            await modelUser.setUserEncryptKey(userEncryptData);

            res.status(responseCode.SUCCESS_CODE.OK).json({
                recover: true,
                message: "User password recovery completed successfully!"
            });

        } catch (error) {
            res.status(responseCode.ERROR_CODE.BAD_REQUEST).json({
                activated: false,
                code: error.code,
                message: error.text
            });
        }
    }

    return controller;
}
