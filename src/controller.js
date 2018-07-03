const db = require('./database/index');


exports.addBooking = (req, res) => {
	const postQuery = req.body;

	//const booking_id = postQuery.booking_id;
	const shipper_name = postQuery.shipper_name;
	const contact_number  = postQuery.contact_number;
	const email = postQuery.email; 
	const company_name = postQuery.company_name; 
	const pickup_address = postQuery.pickup_address;
	const account_number = postQuery.account_number;

	//const item_id = postQuery.item_id;
	const quantity = postQuery.quantity;
	const description = postQuery.description;
	const size = postQuery.size;

	
	const queryString = "call insert_booking('" + shipper_name+"', '" + contact_number+"', '" + email+"', '" + company_name+"', '" + pickup_address+"', '" + account_number+"', '" + quantity+"', '" + description+"', '" + size+"')";

	db.query(queryString, function(err, rows) {
	        if (!err) {
	            res.json(rows);
	            console.log("Booking added!");
	        } else {
	            res.json([]);
	            console.log("Booking not added!");
	        }
	});
}