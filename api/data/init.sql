CREATE TABLE `users` (
                         `id` char(36) NOT NULL,
                         `name` varchar(255) NOT NULL,
                         `entity` varchar(255) NULL,
                         `email` varchar(255) NOT NULL UNIQUE,
                         `password` TEXT NOT NULL,
                         `groupId` INT NOT NULL,
                         `activationToken` TEXT NULL,
                         `encryptKey` TEXT NULL,
                         `dateBirth` DATE NOT NULL,
                         `address` TEXT NOT NULL,
                         `codPost` varchar(10) NOT NULL,
                         `genderId` INT NOT NULL,
                         `locality` varchar(255) NOT NULL,
                         `mobile` varchar(255) NOT NULL,
                         `nif` int(10) NOT NULL,
                         `countryId` INT NOT NULL,
                         `active` BOOLEAN NOT NULL,
                         `activationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `dateModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                         `lastLogin` TIMESTAMP NULL,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `messages` (
                         `id` char(36) NOT NULL,
                         `subject` varchar(255) NOT NULL,
                         `message` TEXT NOT NULL,
                         `fromUser` char(36) NOT NULL,
                         `fromName` varchar(255) NOT NULL,
                         `fromEmail` varchar(255) NOT NULL,
                         `toUser` char(36) NOT NULL,
                         `toName` varchar(255) NOT NULL,
                         `toEmail` varchar(255) NOT NULL,
                         `active` BOOLEAN NOT NULL,
                         `notificationDate` TIMESTAMP NULL,
                         `receptionDate` TIMESTAMP NULL,
                         `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `dateModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `userGroups` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) NOT NULL,
                         `description` TEXT NOT NULL,
                         `securityId` int NOT NULL,
                         `active` BOOLEAN NOT NULL,
                         `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (`id`)
);

CREATE TABLE `treeType` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) NOT NULL,
                        `description` TEXT NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `trees` (
                        `id` char(36) NOT NULL,
                        `name` varchar(255) NOT NULL,
                        `nameCommon` varchar(255) NOT NULL,
                        `description` TEXT NULL,
                        `observations` TEXT NULL,
                        `typeId` int NOT NULL,
                        `lat` double(9,6) NOT NULL,
                        `lng` double(9,6) NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `usersTrees` (
                        `userId` char(36) NOT NULL,
                        `treeId` char(36) NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `treeInterventions` (
                                     `id` char(36) NOT NULL,
                                     `treeId` char(36) NOT NULL,
                                     `interventionDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     `subject` varchar(255) NOT NULL,
                                     `description` TEXT NULL,
                                     `observations` TEXT NULL,
                                     `public` BOOLEAN NOT NULL,
                                     `active` BOOLEAN NOT NULL,
                                     `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     PRIMARY KEY (`id`)
);

CREATE TABLE `security` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `homeLogin` BOOLEAN NOT NULL,
                        `admLogin` BOOLEAN NOT NULL,
                        `usersCreate` BOOLEAN NOT NULL,
                        `usersRead` BOOLEAN NOT NULL,
                        `usersUpdate` BOOLEAN NOT NULL,
                        `usersDelete` BOOLEAN NOT NULL,
                        `userGroupsCreate` BOOLEAN NOT NULL,
                        `userGroupsRead` BOOLEAN NOT NULL,
                        `userGroupsUpdate` BOOLEAN NOT NULL,
                        `userGroupsDelete` BOOLEAN NOT NULL,
                        `usersTreesCreate` BOOLEAN NOT NULL,
                        `usersTreesRead` BOOLEAN NOT NULL,
                        `usersTreesUpdate` BOOLEAN NOT NULL,
                        `usersTreesDelete` BOOLEAN NOT NULL,
                        `treesCreate` BOOLEAN NOT NULL,
                        `treesRead` BOOLEAN NOT NULL,
                        `treesUpdate` BOOLEAN NOT NULL,
                        `treesDelete` BOOLEAN NOT NULL,
                        `treeTypeCreate` BOOLEAN NOT NULL,
                        `treeTypeRead` BOOLEAN NOT NULL,
                        `treeTypeUpdate` BOOLEAN NOT NULL,
                        `treeTypeDelete` BOOLEAN NOT NULL,
                        `treeImagesCreate` BOOLEAN NOT NULL,
                        `treeImagesRead` BOOLEAN NOT NULL,
                        `treeImagesUpdate` BOOLEAN NOT NULL,
                        `treeImagesDelete` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `transactions` (
                        `id` char(36) NOT NULL,
                        `transactionTypeId` int NOT NULL,
                        `transactionMethodId` int NOT NULL,
                        `userId` char(36) NOT NULL,
                        `userName` varchar(255) NOT NULL,
                        `userNif` int(10) NOT NULL,
                        `treeId` char(36) NOT NULL,
                        `treeName` varchar(255) NOT NULL,
                        `reference` varchar(255) NULL,
                        `referenceId` varchar(255) NULL,
                        `requestId` varchar(255) NULL,
                        `terminal` varchar(255) NULL,
                        `serviceTariff` DECIMAL(5, 2) NULL,
                        `value` DECIMAL(5, 2) NOT NULL,
                        `valueNet` DECIMAL(5, 2) NULL,
                        `valid` BOOLEAN NOT NULL,
                        `state` varchar(255) NULL,
                        `message` varchar(255) NULL,
                        `code` varchar(255) NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateValidated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `transactionType` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) NOT NULL,
                        `description` TEXT NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `transactionMethod` (
                        `id` int NOT NULL AUTO_INCREMENT,
                        `name` varchar(255) NOT NULL,
                        `description` TEXT NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `treeImages` (
                        `id` char(36) NOT NULL,
                        `treeId` char(36) NOT NULL,
                        `name` varchar(255) NOT NULL,
                        `path` varchar(255) NOT NULL,
                        `description` TEXT NULL,
                        `size` int NOT NULL,
                        `position` int NOT NULL,
                        `active` BOOLEAN NOT NULL,
                        `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        `dateModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (`id`)
);

CREATE TABLE `countries` (
                              `id` INT NOT NULL AUTO_INCREMENT,
                              `name` varchar(255) NOT NULL,
                              `code` varchar(5) NOT NULL,
                              `active` BOOL NOT NULL,
                              `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              `dateModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                              PRIMARY KEY (`id`)
);

CREATE TABLE `gender` (
                             `id` INT NOT NULL AUTO_INCREMENT,
                             `name` varchar(255) NOT NULL,
                             `active` BOOL NOT NULL,
                             `dateCreated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `dateModified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                             PRIMARY KEY (`id`)
);

ALTER TABLE `users` ADD CONSTRAINT `users_fk0` FOREIGN KEY (`groupId`) REFERENCES `userGroups`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk1` FOREIGN KEY (`countryId`) REFERENCES `countries`(`id`);

ALTER TABLE `users` ADD CONSTRAINT `users_fk2` FOREIGN KEY (`genderId`) REFERENCES `gender`(`id`);

ALTER TABLE `userGroups` ADD CONSTRAINT `userGroups_fk0` FOREIGN KEY (`securityId`) REFERENCES `security`(`id`);

ALTER TABLE `trees` ADD CONSTRAINT `trees_fk0` FOREIGN KEY (`typeId`) REFERENCES `treeType`(`id`);

ALTER TABLE `treeInterventions` ADD CONSTRAINT `treeInterventions_fk0` FOREIGN KEY (`treeId`) REFERENCES `trees`(`id`);

ALTER TABLE `usersTrees` ADD CONSTRAINT `usersTrees_fk0` FOREIGN KEY (`userId`) REFERENCES `users`(`id`);

ALTER TABLE `usersTrees` ADD CONSTRAINT `usersTrees_fk1` FOREIGN KEY (`treeId`) REFERENCES `trees`(`id`);

ALTER TABLE `usersTrees` ADD CONSTRAINT `usersTrees_pk`  UNIQUE (`userId`, `treeId`);

ALTER TABLE `transactions` ADD CONSTRAINT `transactions_fk0` FOREIGN KEY (`transactionTypeId`) REFERENCES `transactionType`(`id`);

ALTER TABLE `transactions` ADD CONSTRAINT `transactions_fk1` FOREIGN KEY (`transactionMethodId`) REFERENCES `transactionMethod`(`id`);

ALTER TABLE `transactions` ADD CONSTRAINT `transactions_fk2` FOREIGN KEY (`userId`) REFERENCES `users`(`id`);

ALTER TABLE `transactions` ADD CONSTRAINT `transactions_fk3` FOREIGN KEY (`treeId`) REFERENCES `trees`(`id`);

ALTER TABLE `treeImages` ADD CONSTRAINT `treeImages_fk0` FOREIGN KEY (`treeId`) REFERENCES `trees`(`id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk0` FOREIGN KEY (`fromUser`) REFERENCES `users`(`id`);

ALTER TABLE `messages` ADD CONSTRAINT `messages_fk1` FOREIGN KEY (`toUser`) REFERENCES `users`(`id`);

INSERT INTO `security` (homeLogin, admLogin, usersCreate, usersRead, usersUpdate, usersDelete,
                        userGroupsCreate, userGroupsRead, userGroupsUpdate, userGroupsDelete,
                        usersTreesCreate, usersTreesRead, usersTreesUpdate, usersTreesDelete,
                        treesCreate, treesRead, treesUpdate, treesDelete,
                        treeTypeCreate, treeTypeRead, treeTypeUpdate, treeTypeDelete,
                        treeImagesCreate, treeImagesRead, treeImagesUpdate, treeImagesDelete)
VALUES (true, false, false, true, true, false,
        false, true, false, false,
        false, true, false, false,
        false, true, false, false,
        false, true, false, false,
        true, false, false, false),
       (false, true, true, true, true, true,
        true, true, true, true,
        true, true, true, true,
        true, true, true, true,
        true, true, true, true,
        true, true, true, true);

INSERT INTO `userGroups` (name, description, securityId, active, dateCreated, dateModified)
VALUES ('Public Frontend','Generic Frontend Access', 1, true, NOW(), NOW()),
       ('Private Backoffice','Generic Backoffice Access', 2, true, NOW(), NOW());

INSERT INTO `gender` (name, active, dateCreated, dateModified)
VALUES ('Masculino', true, NOW(), NOW()),
       ('Feminino', true, NOW(), NOW()),
       ('Indefinido', true, NOW(), NOW());

INSERT INTO `treeType` (name, description, active, dateCreated, dateModified)
VALUES ('Fanerofito','Fanerofito', true, NOW(), NOW());

INSERT INTO `countries` (name, code, active, dateCreated, dateModified)
VALUES ('Andorra', 'AD', true, NOW(), NOW()),
       ('United Arab Emirates', 'AE', true, NOW(), NOW()),
       ('Afghanistan', 'AF', true, NOW(), NOW()),
       ('Antigua and Barbuda', 'AG', true, NOW(), NOW()),
       ('Anguilla', 'AI', true, NOW(), NOW()),
       ('Albania', 'AL', true, NOW(), NOW()),
       ('Armenia', 'AM', true, NOW(), NOW()),
       ('Netherlands Antilles', 'AN', true, NOW(), NOW()),
       ('Angola', 'AO', true, NOW(), NOW()),
       ('Antarctica', 'AQ', true, NOW(), NOW()),
       ('Argentina', 'AR', true, NOW(), NOW()),
       ('American Samoa', 'AS', true, NOW(), NOW()),
       ('Austria', 'AT', true, NOW(), NOW()),
       ('Australia', 'AU', true, NOW(), NOW()),
       ('Aruba', 'AW', true, NOW(), NOW()),
       ('Azerbaijan', 'AZ', true, NOW(), NOW()),
       ('Bosnia and Herzegovina', 'BA', true, NOW(), NOW()),
       ('Barbados', 'BB', true, NOW(), NOW()),
       ('Bangladesh', 'BD', true, NOW(), NOW()),
       ('Belgium', 'BE', true, NOW(), NOW()),
       ('Burkina Faso', 'BF', true, NOW(), NOW()),
       ('Bulgaria', 'BG', true, NOW(), NOW()),
       ('Bahrain', 'BH', true, NOW(), NOW()),
       ('Burundi', 'BI', true, NOW(), NOW()),
       ('Benin', 'BJ', true, NOW(), NOW()),
       ('Bermuda', 'BM', true, NOW(), NOW()),
       ('Brunei', 'BN', true, NOW(), NOW()),
       ('Bolivia', 'BO', true, NOW(), NOW()),
       ('Brazil', 'BR', true, NOW(), NOW()),
       ('Bahamas', 'BS', true, NOW(), NOW()),
       ('Bhutan', 'BT', true, NOW(), NOW()),
       ('Bouvet Island', 'BV', true, NOW(), NOW()),
       ('Botswana', 'BW', true, NOW(), NOW()),
       ('Belarus', 'BY', true, NOW(), NOW()),
       ('Belize', 'BZ', true, NOW(), NOW()),
       ('Canada', 'CA', true, NOW(), NOW()),
       ('Cocos [Keeling] Islands', 'CC', true, NOW(), NOW()),
       ('Congo [DRC]', 'CD', true, NOW(), NOW()),
       ('Central African Republic', 'CF', true, NOW(), NOW()),
       ('Congo [Republic]', 'CG', true, NOW(), NOW()),
       ('Switzerland', 'CH', true, NOW(), NOW()),
       ('Côte d''Ivoire', 'CI', true, NOW(), NOW()),
       ('Cook Islands', 'CK', true, NOW(), NOW()),
       ('Chile', 'CL', true, NOW(), NOW()),
       ('Cameroon', 'CM', true, NOW(), NOW()),
       ('China', 'CN', true, NOW(), NOW()),
       ('Colombia', 'CO', true, NOW(), NOW()),
       ('Costa Rica', 'CR', true, NOW(), NOW()),
       ('Cuba', 'CU', true, NOW(), NOW()),
       ('Cape Verde', 'CV', true, NOW(), NOW()),
       ('Christmas Island', 'CX', true, NOW(), NOW()),
       ('Cyprus', 'CY', true, NOW(), NOW()),
       ('Czech Republic', 'CZ', true, NOW(), NOW()),
       ('Germany', 'DE', true, NOW(), NOW()),
       ('Djibouti', 'DJ', true, NOW(), NOW()),
       ('Denmark', 'DK', true, NOW(), NOW()),
       ('Dominica', 'DM', true, NOW(), NOW()),
       ('Dominican Republic', 'DO', true, NOW(), NOW()),
       ('Algeria', 'DZ', true, NOW(), NOW()),
       ('Ecuador', 'EC', true, NOW(), NOW()),
       ('Estonia', 'EE', true, NOW(), NOW()),
       ('Egypt', 'EG', true, NOW(), NOW()),
       ('Western Sahara', 'EH', true, NOW(), NOW()),
       ('Eritrea', 'ER', true, NOW(), NOW()),
       ('Spain', 'ES', true, NOW(), NOW()),
       ('Ethiopia', 'ET', true, NOW(), NOW()),
       ('Finland', 'FI', true, NOW(), NOW()),
       ('Fiji', 'FJ', true, NOW(), NOW()),
       ('Falkland Islands [Islas Malvinas]', 'FK', true, NOW(), NOW()),
       ('Micronesia', 'FM', true, NOW(), NOW()),
       ('Faroe Islands', 'FO', true, NOW(), NOW()),
       ('France', 'FR', true, NOW(), NOW()),
       ('Gabon', 'GA', true, NOW(), NOW()),
       ('United Kingdom', 'GB', true, NOW(), NOW()),
       ('Grenada', 'GD', true, NOW(), NOW()),
       ('Georgia', 'GE', true, NOW(), NOW()),
       ('French Guiana', 'GF', true, NOW(), NOW()),
       ('Guernsey', 'GG', true, NOW(), NOW()),
       ('Ghana', 'GH', true, NOW(), NOW()),
       ('Gibraltar', 'GI', true, NOW(), NOW()),
       ('Greenland', 'GL', true, NOW(), NOW()),
       ('Gambia', 'GM', true, NOW(), NOW()),
       ('Guinea', 'GN', true, NOW(), NOW()),
       ('Guadeloupe', 'GP', true, NOW(), NOW()),
       ('Equatorial Guinea', 'GQ', true, NOW(), NOW()),
       ('Greece', 'GR', true, NOW(), NOW()),
       ('South Georgia and the South Sandwich Islands', 'GS', true, NOW(), NOW()),
       ('Guatemala', 'GT', true, NOW(), NOW()),
       ('Guam', 'GU', true, NOW(), NOW()),
       ('Guinea-Bissau', 'GW', true, NOW(), NOW()),
       ('Guyana', 'GY', true, NOW(), NOW()),
       ('Gaza Strip', 'GZ', true, NOW(), NOW()),
       ('Hong Kong', 'HK', true, NOW(), NOW()),
       ('Heard Island and McDonald Islands', 'HM', true, NOW(), NOW()),
       ('Honduras', 'HN', true, NOW(), NOW()),
       ('Croatia', 'HR', true, NOW(), NOW()),
       ('Haiti', 'HT', true, NOW(), NOW()),
       ('Hungary', 'HU', true, NOW(), NOW()),
       ('Indonesia', 'ID', true, NOW(), NOW()),
       ('Ireland', 'IE', true, NOW(), NOW()),
       ('Israel', 'IL', true, NOW(), NOW()),
       ('Isle of Man', 'IM', true, NOW(), NOW()),
       ('India', 'IN', true, NOW(), NOW()),
       ('British Indian Ocean Territory', 'IO', true, NOW(), NOW()),
       ('Iraq', 'IQ', true, NOW(), NOW()),
       ('Iran', 'IR', true, NOW(), NOW()),
       ('Iceland', 'IS', true, NOW(), NOW()),
       ('Italy', 'IT', true, NOW(), NOW()),
       ('Jersey', 'JE', true, NOW(), NOW()),
       ('Jamaica', 'JM', true, NOW(), NOW()),
       ('Jordan', 'JO', true, NOW(), NOW()),
       ('Japan', 'JP', true, NOW(), NOW()),
       ('Kenya', 'KE', true, NOW(), NOW()),
       ('Kyrgyzstan', 'KG', true, NOW(), NOW()),
       ('Cambodia', 'KH', true, NOW(), NOW()),
       ('Kiribati', 'KI', true, NOW(), NOW()),
       ('Comoros', 'KM', true, NOW(), NOW()),
       ('Saint Kitts and Nevis', 'KN', true, NOW(), NOW()),
       ('North Korea', 'KP', true, NOW(), NOW()),
       ('South Korea', 'KR', true, NOW(), NOW()),
       ('Kuwait', 'KW', true, NOW(), NOW()),
       ('Cayman Islands', 'KY', true, NOW(), NOW()),
       ('Kazakhstan', 'KZ', true, NOW(), NOW()),
       ('Laos', 'LA', true, NOW(), NOW()),
       ('Lebanon', 'LB', true, NOW(), NOW()),
       ('Saint Lucia', 'LC', true, NOW(), NOW()),
       ('Liechtenstein', 'LI', true, NOW(), NOW()),
       ('Sri Lanka', 'LK', true, NOW(), NOW()),
       ('Liberia', 'LR', true, NOW(), NOW()),
       ('Lesotho', 'LS', true, NOW(), NOW()),
       ('Lithuania', 'LT', true, NOW(), NOW()),
       ('Luxembourg', 'LU', true, NOW(), NOW()),
       ('Latvia', 'LV', true, NOW(), NOW()),
       ('Libya', 'LY', true, NOW(), NOW()),
       ('Morocco', 'MA', true, NOW(), NOW()),
       ('Monaco', 'MC', true, NOW(), NOW()),
       ('Moldova', 'MD', true, NOW(), NOW()),
       ('Montenegro', 'ME', true, NOW(), NOW()),
       ('Madagascar', 'MG', true, NOW(), NOW()),
       ('Marshall Islands', 'MH', true, NOW(), NOW()),
       ('Macedonia', 'MK', true, NOW(), NOW()),
       ('Mali', 'ML', true, NOW(), NOW()),
       ('Myanmar', 'MM', true, NOW(), NOW()),
       ('Mongolia', 'MN', true, NOW(), NOW()),
       ('Macau', 'MO', true, NOW(), NOW()),
       ('Northern Mariana Islands', 'MP', true, NOW(), NOW()),
       ('Martinique', 'MQ', true, NOW(), NOW()),
       ('Mauritania', 'MR', true, NOW(), NOW()),
       ('Montserrat', 'MS', true, NOW(), NOW()),
       ('Malta', 'MT', true, NOW(), NOW()),
       ('Mauritius', 'MU', true, NOW(), NOW()),
       ('Maldives', 'MV', true, NOW(), NOW()),
       ('Malawi', 'MW', true, NOW(), NOW()),
       ('Mexico', 'MX', true, NOW(), NOW()),
       ('Malaysia', 'MY', true, NOW(), NOW()),
       ('Mozambique', 'MZ', true, NOW(), NOW()),
       ('Namibia', 'NA', true, NOW(), NOW()),
       ('New Caledonia', 'NC', true, NOW(), NOW()),
       ('Niger', 'NE', true, NOW(), NOW()),
       ('Norfolk Island', 'NF', true, NOW(), NOW()),
       ('Nigeria', 'NG', true, NOW(), NOW()),
       ('Nicaragua', 'NI', true, NOW(), NOW()),
       ('Netherlands', 'NL', true, NOW(), NOW()),
       ('Norway', 'NO', true, NOW(), NOW()),
       ('Nepal', 'NP', true, NOW(), NOW()),
       ('Nauru', 'NR', true, NOW(), NOW()),
       ('Niue', 'NU', true, NOW(), NOW()),
       ('New Zealand', 'NZ', true, NOW(), NOW()),
       ('Oman', 'OM', true, NOW(), NOW()),
       ('Panama', 'PA', true, NOW(), NOW()),
       ('Peru', 'PE', true, NOW(), NOW()),
       ('French Polynesia', 'PF', true, NOW(), NOW()),
       ('Papua New Guinea', 'PG', true, NOW(), NOW()),
       ('Philippines', 'PH', true, NOW(), NOW()),
       ('Pakistan', 'PK', true, NOW(), NOW()),
       ('Poland', 'PL', true, NOW(), NOW()),
       ('Saint Pierre and Miquelon', 'PM', true, NOW(), NOW()),
       ('Pitcairn Islands', 'PN', true, NOW(), NOW()),
       ('Puerto Rico', 'PR', true, NOW(), NOW()),
       ('Palestinian Territories', 'PS', true, NOW(), NOW()),
       ('Portugal', 'PT', true, NOW(), NOW()),
       ('Palau', 'PW', true, NOW(), NOW()),
       ('Paraguay', 'PY', true, NOW(), NOW()),
       ('Qatar', 'QA', true, NOW(), NOW()),
       ('Romania', 'RO', true, NOW(), NOW()),
       ('Serbia', 'RS', true, NOW(), NOW()),
       ('Russia', 'RU', true, NOW(), NOW()),
       ('Rwanda', 'RW', true, NOW(), NOW()),
       ('Saudi Arabia', 'SA', true, NOW(), NOW()),
       ('Solomon Islands', 'SB', true, NOW(), NOW()),
       ('Seychelles', 'SC', true, NOW(), NOW()),
       ('Sudan', 'SD', true, NOW(), NOW()),
       ('Sweden', 'SE', true, NOW(), NOW()),
       ('Singapore', 'SG', true, NOW(), NOW()),
       ('Saint Helena', 'SH', true, NOW(), NOW()),
       ('Slovenia', 'SI', true, NOW(), NOW()),
       ('Slovakia', 'SK', true, NOW(), NOW()),
       ('Sierra Leone', 'SL', true, NOW(), NOW()),
       ('San Marino', 'SM', true, NOW(), NOW()),
       ('Senegal', 'SN', true, NOW(), NOW()),
       ('Somalia', 'SO', true, NOW(), NOW()),
       ('São Tomé and Príncipe', 'ST', true, NOW(), NOW()),
       ('El Salvador', 'SV', true, NOW(), NOW()),
       ('Swaziland', 'SZ', true, NOW(), NOW()),
       ('Togo', 'TG', true, NOW(), NOW()),
       ('Thailand', 'TH', true, NOW(), NOW()),
       ('Tajikistan', 'TJ', true, NOW(), NOW()),
       ('Timor-Leste', 'TL', true, NOW(), NOW()),
       ('Turkmenistan', 'TM', true, NOW(), NOW()),
       ('Tunisia', 'TN', true, NOW(), NOW()),
       ('Tonga', 'TO', true, NOW(), NOW()),
       ('Turkey', 'TR', true, NOW(), NOW()),
       ('Trinidad and Tobago', 'TT', true, NOW(), NOW()),
       ('Taiwan', 'TW', true, NOW(), NOW()),
       ('Tanzania', 'TZ', true, NOW(), NOW()),
       ('Ukraine', 'UA', true, NOW(), NOW()),
       ('Uganda', 'UG', true, NOW(), NOW()),
       ('United States', 'US', true, NOW(), NOW()),
       ('Uruguay', 'UY', true, NOW(), NOW()),
       ('Uzbekistan', 'UZ', true, NOW(), NOW()),
       ('Venezuela', 'VE', true, NOW(), NOW()),
       ('British Virgin Islands', 'VG', true, NOW(), NOW()),
       ('Vietnam', 'VN', true, NOW(), NOW()),
       ('Samoa', 'WS', true, NOW(), NOW()),
       ('Kosovo', 'XK', true, NOW(), NOW()),
       ('Yemen', 'YE', true, NOW(), NOW()),
       ('South Africa', 'ZA', true, NOW(), NOW()),
       ('Zambia', 'ZM', true, NOW(), NOW()),
       ('Zimbabwe', 'ZW', true, NOW(), NOW());

INSERT INTO `transactionType` (name, description, active, dateCreated, dateModified)
VALUES ('Credit', 'Credit movement', true, NOW(), NOW()),
       ('Debit', 'Debit movement', true, NOW(), NOW());

INSERT INTO `transactionMethod` (name, description, active, dateCreated, dateModified)
VALUES ('MBWay', 'MBWay', true, NOW(), NOW()),
       ('MB', 'MB ATM', true, NOW(), NOW()),
       ('Payshop', 'Payshop', true, NOW(), NOW()),
       ('Bank Transfer', 'SEPA Bank Transfer', true, NOW(), NOW()),
       ('VISA/Mastercard', 'Visa credit card', true, NOW(), NOW());
