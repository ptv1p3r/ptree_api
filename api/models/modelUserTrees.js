'use strict';

const { dbPool } = require('./../helpers/db');

module.exports = app => {
    const model = {};

    /**
     * Get user by email
     * @param {Integer} groupId - Group Id
     * @returns {Promise<*>}
     */
    model.getUserGroupById = async (groupId) => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            // return await conn.query(`SELECT id, name, description, securityId, active,
            //     CONVERT_TZ(dateCreated,'UTC','Europe/Lisbon') AS dateCreated,
            //     CONVERT_TZ(dateModified,'UTC','Europe/Lisbon') AS dateModified
            //     FROM userGroups WHERE id=${groupId}`);
            return await conn.query(`SELECT userGroups.id, userGroups.name, userGroups.description, userGroups.securityId, userGroups.active,
                CONVERT_TZ(userGroups.dateCreated,'UTC','Europe/Lisbon') AS dateCreated,
                CONVERT_TZ(userGroups.dateModified,'UTC','Europe/Lisbon') AS dateModified,
                security.homeLogin, security.admLogin, security.usersCreate, security.usersRead, security.usersUpdate, security.usersDelete,
                security.userGroupsCreate, security.userGroupsRead, security.userGroupsUpdate, security.userGroupsDelete, security.treesCreate,
                security.treesRead, security.treesUpdate, security.treesDelete, security.treeTypeCreate, security.treeTypeRead, security.treeTypeUpdate,
                security.treeTypeDelete, security.treeImagesCreate, security.treeImagesRead, security.treeImagesUpdate, security.treeImagesDelete
                FROM userGroups, security WHERE userGroups.id=${groupId} AND securityId=security.id`);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Lists user trees
     * @returns {Promise<void>}
     */
    model.getUserTreesList = async () => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            return await conn.query("SELECT userId, treeId, active, " +
                "CONVERT_TZ(dateCreated,'UTC','Europe/Lisbon') AS dateCreated, " +
                "CONVERT_TZ(dateModified,'UTC','Europe/Lisbon') AS dateModified " +
                "FROM usersTrees");
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Create a new user group
     * @param {Object} userGroupData - User group details
     * @returns {Promise<void>}
     */
    model.createUserGroup = async (userGroupData) => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            return await conn.query("INSERT INTO userGroups (name, description, securityId, active) " +
                "VALUES (?, ?, ?, ?)",
                [userGroupData.name, userGroupData.description, userGroupData.securityId, userGroupData.active]);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Edit user group
     * @param {Object} userGroupData - User group details
     * @returns {*}
     */
    model.editUserGroup = async (userGroupData) => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            return await conn.query(`UPDATE userGroups SET name='${userGroupData.name}', description='${userGroupData.description}', 
                securityId=${userGroupData.securityId}, active=${userGroupData.active}, dateModified=NOW() 
                WHERE id=${userGroupData.id}`);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    /**
     * Delete user group
     * @param {Object} userGroupData - User group details
     * @returns {*}
     */
    model.deleteUserGroup = async (userGroupData) => {
        let conn;

        try {
            conn = await dbPool.getConnection();
            return await conn.query(`DELETE FROM userGroups WHERE id=${userGroupData.id}`);
        } catch (err) {
            console.log("error: " + err);
            throw err;
        } finally {
            if (conn) await conn.end();
        }
    }

    return model;
}
