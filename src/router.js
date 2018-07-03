const express = require('express');
const router = express.Router();
const controller = require('./controller');

router.post('/add-booking', controller.addBooking);

module.exports = router;