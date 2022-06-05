'use strict';

const { dbPool, buildPatchSqlQuery } = require('./../helpers/db');

module.exports = app => {
    const model = {};

    /**
     * Lists all messages
     * @returns {Promise<void>}
     */
    model.messagesListAll = async () => {
        let conn;

        try {
            conn = await dbPool.getConnection();

            return await conn.query("SELECT id, subject, message, fromUser, fromName, fromEmail, " +
                "toUser, toName, toEmail, active, " +
                "CONVERT_TZ(notificationDate,'UTC','Europe/Lisbon') AS notificationDate, " +
                "CONVERT_TZ(receptionDate,'UTC','Europe/Lisbon') AS receptionDate, " +
                "CONVERT_TZ(dateCreated,'UTC','Europe/Lisbon') AS dateCreated, " +
                "CONVERT_TZ(dateModified,'UTC','Europe/Lisbon') AS dateModified " +
                "FROM messages");
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Get message by id
     * @param {String} messageId - Message unique identifier
     * @returns {Promise<void>}
     */
    model.getMessageById = async (messageId) => {
        let conn;

        try {
            conn = await dbPool.getConnection();

            return await conn.query(`SELECT id, subject, message, fromUser, fromName, fromEmail, toUser, toName, toEmail, active,
                CONVERT_TZ(notificationDate,'UTC','Europe/Lisbon') AS notificationDate,
                CONVERT_TZ(receptionDate,'UTC','Europe/Lisbon') AS receptionDate,
                CONVERT_TZ(dateCreated,'UTC','Europe/Lisbon') AS dateCreated,
                CONVERT_TZ(dateModified,'UTC','Europe/Lisbon') AS dateModified 
                FROM messages WHERE id='${messageId}'`);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Create a new message
     * @param {Object} messageData - Message details
     * @returns {Promise<void>}
     */
    model.createMessage = async (messageData) => {
        let conn;

        try {
            conn = await dbPool.getConnection();

            return await conn.query("INSERT INTO messages value (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                [messageData.id, messageData.subject, messageData.message, messageData.fromUser, messageData.fromName, messageData.fromEmail,
                    messageData.toUser, messageData.toName, messageData.toEmail, messageData.active, null, null, messageData.dateCreated, messageData.dateModified]);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Edit a message using PATCH
     * @param imageData - Image details
     * @returns {Promise<any>}
     */
    model.editPatchMessage = async (imageData) => {
        let conn;

        try {

            conn = await dbPool.getConnection();

            return await conn.query(buildPatchSqlQuery('treeImages',imageData.id, imageData.body));

        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Delete message
     * @param {String} messageId - Message unique identifier
     * @returns {*}
     */
    model.deleteMessage = async (messageId) => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            return await conn.query(`DELETE FROM messages WHERE id='${messageId}'`);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    return model;
}