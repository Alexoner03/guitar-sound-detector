const express = require('express');
const router = express.Router();
const UserInformationController = require('./UserInformationController')

router.use('/user',UserInformationController)

module.exports = router;